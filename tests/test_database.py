import pytest
import psycopg2
from psycopg2 import errors

def test_insercao_usuario_sucesso(db_session):
    """Garante que um usuário válido pode ser inserido com sucesso."""
    db_session.execute(
        """
        INSERT INTO usuario (id, nome_completo, email, senha)
        VALUES (%s, %s, %s, %s) RETURNING id;
        """,
        (1, "Arquiteto de Software", "architect@pbl.com", "secure_hash")
    )
    usuario_id = db_session.fetchone()[0]
    assert usuario_id == 1


def test_violacao_email_unico(db_session):
    """Valida a restrição UNIQUE do email cadastrado na tabela usuario."""
    # Inserção do primeiro usuário
    db_session.execute(
        "INSERT INTO usuario (id, nome_completo, email, senha) VALUES (%s, %s, %s, %s);",
        (1, "User One", "shared@pbl.com", "pwd1")
    )
    
    # Tentativa de inserção de duplicado deve estourar a exceção do Postgres
    with pytest.raises(psycopg2.errors.UniqueViolation):
        db_session.execute(
            "INSERT INTO usuario (id, nome_completo, email, senha) VALUES (%s, %s, %s, %s);",
            (2, "User Two", "shared@pbl.com", "pwd2")
        )


def test_insercao_professor_especializacao(db_session):
    """Valida a integridade da especialização da entidade Professor -> Usuario."""
    # 1. Insere o nó na tabela pai (usuario)
    db_session.execute(
        "INSERT INTO usuario (id, nome_completo, email, senha) VALUES (%s, %s, %s, %s);",
        (10, "Dr. Alan Turing", "turing@pbl.com", "pwd123")
    )
    
    # 2. Insere na tabela filha (professor) relacionando os IDs
    db_session.execute(
        "INSERT INTO professor (id, titulacao) VALUES (%s, %s);",
        (10, "Doutorado")
    )
    
    # 3. Asserção
    db_session.execute("SELECT titulacao FROM professor WHERE id = 10;")
    titulacao = db_session.fetchone()[0]
    assert titulacao == "Doutorado"


def test_violacao_fk_professor_sem_usuario(db_session):
    """Garante que não é possível criar um professor sem um usuário base."""
    with pytest.raises(psycopg2.errors.ForeignKeyViolation):
        db_session.execute(
            "INSERT INTO professor (id, titulacao) VALUES (%s, %s);",
            (999, "Mestrado")  # ID 999 não existe na tabela usuario
        )


def test_entidade_fraca_sprint_e_chave_composta(db_session):
    """Valida o comportamento da entidade fraca Sprint e sua PK composta (id_projeto, id)."""
    # 1. Necessário criar o projeto (Entidade Forte) primeiro devido à FK
    db_session.execute("INSERT INTO projeto (id, nome) VALUES (%s, %s);", (5, "Sistema PBL Core"))
    
    # 2. Insere a primeira Sprint do projeto 5
    db_session.execute(
        """
        INSERT INTO sprint (id, numero, data_fim, id_projeto, id_equipe)
        VALUES (%s, %s, %s, %s, %s);
        """,
        (1, 1, "2026-12-31", 5, None)
    )
    
    # 3. Tenta inserir a mesma Sprint (id=1) para o mesmo projeto (id_projeto=5) -> Deve falhar (PK duplicada)
    with pytest.raises(psycopg2.errors.UniqueViolation):
        db_session.execute(
            """
            INSERT INTO sprint (id, numero, data_fim, id_projeto, id_equipe)
            VALUES (%s, %s, %s, %s, %s);
            """,
            (1, 2, "2026-12-31", 5, None)
        )


def test_criar_estrutura_curso_e_disciplina(db_session):
    """
    Valida a integridade referencial (FK) entre as tabelas departamento, curso e disciplina.
    """
    # 1. Inserir Departamento base
    db_session.execute(
        "INSERT INTO departamento (id, nome, sigla) VALUES (%s, %s, %s);",
        (1, "Engenharia de Software", "ES")
    )
    
    # 2. Inserir Curso atrelado ao departamento
    db_session.execute(
        "INSERT INTO curso (id, nome, id_departamento) VALUES (%s, %s, %s);",
        (101, "Lincenciatura em Engenharia de Software", 1)
    )
    
    # 3. Inserir Disciplina
    db_session.execute(
        "INSERT INTO disciplina (id, nome, carga_horaria) VALUES (%s, %s, %s);",
        (10, "Arquitetura de Sistemas Avançados", 80)
    )
    
    # 4. Associar na tabela N:M (curso_disciplina)
    db_session.execute(
        "INSERT INTO curso_disciplina (id_curso, id_disciplina) VALUES (%s, %s);",
        (101, 10)
    )
    
    # Asserção de integridade do relacionamento
    db_session.execute(
        """
        SELECT d.nome FROM disciplina d
        JOIN curso_disciplina cd ON d.id = cd.id_disciplina
        WHERE cd.id_curso = %s;
        """,
        (101,)
    )
    nome_disciplina = db_session.fetchone()[0]
    assert nome_disciplina == "Arquitetura de Sistemas Avançados"


def test_violacao_integridade_membro_equipe_sem_aluno(db_session):
    """
    Garante que a restrição de FK impede a inserção de membros em equipas sem alunos válidos.
    """
    # Inserir apenas a turma e a equipa (sem inserir alunos correspondentes)
    db_session.execute("INSERT INTO disciplina (id, nome, carga_horaria) VALUES (1, 'PBL', 60);")
    db_session.execute("INSERT INTO turma (id, semestre, id_disciplina) VALUES (1, '2026.1', 1);")
    db_session.execute("INSERT INTO equipe (id, id_turma) VALUES (50, 1);")
    
    # Tentar inserir um membro com ID de aluno inexistente (ID 999) deve lançar ForeignKeyViolation
    with pytest.raises(psycopg2.errors.ForeignKeyViolation):
        db_session.execute(
            "INSERT INTO membro_equipe (funcao, id_aluno, id_equipe) VALUES (%s, %s, %s);",
            ("DevOps Engineer", 999, 50)
        )
