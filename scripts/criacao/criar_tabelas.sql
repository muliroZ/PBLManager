-- ===============================
-- Tabela de Usuários
-- ===============================
CREATE TABLE usuario (
  id INT PRIMARY KEY,
  nome_completo VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  senha VARCHAR NOT NULL
);

-- ===============================
-- Tabela de Professores (Especialização Sobreposta)
-- ===============================
CREATE TABLE professor (
  titulacao VARCHAR NOT NULL,
  id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES usuario(id)
);

-- ===============================
-- Tabela de Alunos (Especialização Sobreposta)
-- ===============================
CREATE TABLE aluno (
  id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES usuario(id)
);

-- ===============================
-- Tabela de Disciplinas
-- ===============================
CREATE TABLE disciplina (
  id INT PRIMARY KEY,
  nome VARCHAR NOT NULL,
  carga_horaria INT NOT NULL
);

-- ===============================
-- Tabela de Turmas
-- ===============================
CREATE TABLE turma (
  id INT PRIMARY KEY,
  semestre VARCHAR NOT NULL,
  id_disciplina INT,
  FOREIGN KEY (id_disciplina) REFERENCES disciplina(id)
);

-- ===============================
-- Tabela de Equipes
-- ===============================
CREATE TABLE equipe (
  id INT PRIMARY KEY,
  data_formacao DATE DEFAULT CURRENT_DATE,
  id_turma INT,
  FOREIGN KEY (id_turma) REFERENCES turma(id)
);

-- ===============================
-- Tabela de Matrículas (Relacionamento N:M -> aluno + turma)
-- ===============================
CREATE TABLE aluno_turma (
  status VARCHAR NOT NULL,
  id_aluno INT,
  id_turma INT,
  PRIMARY KEY (id_aluno, id_turma),
  FOREIGN KEY (id_aluno) REFERENCES aluno(id),
  FOREIGN KEY (id_turma) REFERENCES turma(id)
);

-- ===============================
-- Tabela de Membros da Equipe (Relacionamento N:M -> aluno + equipe)
-- ===============================
CREATE TABLE membro_equipe (
  funcao VARCHAR NOT NULL,
  id_aluno INT,
  id_equipe INT,
  PRIMARY KEY (id_aluno, id_equipe),
  FOREIGN KEY (id_aluno) REFERENCES aluno(id),
  FOREIGN KEY (id_equipe) REFERENCES equipe(id)
);

-- ===============================
-- Tabela de Departamentos
-- ===============================
CREATE TABLE departamento (
  id INT PRIMARY KEY,
  nome VARCHAR NOT NULL,
  sigla VARCHAR NOT NULL
);

-- ===============================
-- Tabela de Cursos
-- ===============================
CREATE TABLE curso (
  id INT PRIMARY KEY,
  nome VARCHAR NOT NULL,
  id_departamento INT,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

-- ===============================
-- Tabela de Disciplinas do Curso (Relacionamento N:M -> curso + disciplina)
-- ===============================
CREATE TABLE curso_disciplina (
  id_curso INT,
  id_disciplina INT,
  PRIMARY KEY (id_curso, id_disciplina),
  FOREIGN KEY (id_curso) REFERENCES curso(id),
  FOREIGN KEY (id_disciplina) REFERENCES disciplina(id)
);

-- ===============================
-- Tabela de Projetos
-- ===============================
CREATE TABLE projeto (
  id INT PRIMARY KEY,
  nome VARCHAR NOT NULL
);

-- ===============================
-- Tabela de Tecnologias
-- ===============================
CREATE TABLE tecnologia (
  id INT PRIMARY KEY,
  nome VARCHAR NOT NULL
);

-- ===============================
-- Tabela de Equipes do Projeto (Relacionamento N:M -> equipe + projeto)
-- ===============================
CREATE TABLE equipe_projeto (
  id_equipe INT,
  id_projeto INT,
  PRIMARY KEY (id_equipe, id_projeto),
  FOREIGN KEY (id_equipe) REFERENCES equipe(id),
  FOREIGN KEY (id_projeto) REFERENCES projeto(id)
);

-- ===============================
-- Tabela de Tecnologias do Projeto (Relacionamento N:M -> projeto + tecnologia)
-- ===============================
CREATE TABLE projeto_tecnologia (
  categoria VARCHAR NOT NULL,
  versao VARCHAR NOT NULL,
  id_projeto INT,
  id_tecnologia INT,
  PRIMARY KEY (id_projeto, id_tecnologia),
  FOREIGN KEY (id_projeto) REFERENCES projeto(id),
  FOREIGN KEY (id_tecnologia) REFERENCES tecnologia(id)
);

-- ===============================
-- Tabela de Sprints (Entidade Fraca)
-- ===============================
CREATE TABLE sprint (
  id INT NOT NULL,
  numero INT NOT NULL,
  data_fim DATE NOT NULL,
  id_projeto INT,
  id_equipe INT,
  PRIMARY KEY (id_projeto, id),
  FOREIGN KEY (id_projeto) REFERENCES projeto(id),
  FOREIGN KEY (id_equipe) REFERENCES equipe(id)
);

-- ===============================
-- Tabela de Entregas (Entidade Fraca)
-- ===============================
CREATE TABLE entrega (
  id INT NOT NULL,
  titulo VARCHAR NOT NULL,
  status VARCHAR DEFAULT 'Avaliação pendente',
  id_equipe INT,
  id_projeto INT,
  id_sprint INT,
  PRIMARY KEY (id_equipe, id_projeto, id_sprint, id),
  FOREIGN KEY (id_equipe) REFERENCES equipe(id),
  FOREIGN KEY (id_projeto, id_sprint) REFERENCES sprint(id_projeto, id)
);

-- ===============================
-- Tabela de Versões (Entidade Fraca)
-- ===============================
CREATE TABLE versao (
  id INT NOT NULL,
  link_repositorio VARCHAR NOT NULL,
  data_submissao DATE DEFAULT CURRENT_DATE,
  id_equipe INT,
  id_projeto INT,
  id_sprint INT,
  id_entrega INT,
  PRIMARY KEY (id_equipe, id_projeto, id_sprint, id_entrega, id),
  FOREIGN KEY (id_equipe, id_projeto, id_sprint, id_entrega) REFERENCES entrega(id_equipe, id_projeto, id_sprint, id)
);

-- ===============================
-- Tabela de Feedbacks (Entidade Fraca)
-- ===============================
CREATE TABLE feedback (
  id INT NOT NULL,
  descricao VARCHAR NOT NULL,
  nota DECIMAL DEFAULT 0.0,
  id_professor INT,
  id_equipe INT,
  id_projeto INT,
  id_sprint INT,
  id_entrega INT,
  id_versao INT,
  PRIMARY KEY (id, id_professor, id_equipe, id_projeto, id_sprint, id_entrega, id_versao),
  FOREIGN KEY (id_professor) REFERENCES professor(id),
  FOREIGN KEY (id_equipe, id_projeto, id_sprint, id_entrega, id_versao) REFERENCES versao(id_equipe, id_projeto, id_sprint, id_entrega, id)
);

-- ===============================
-- Tabela de Critérios de Aceitação (Entidade Fraca)
-- ===============================
CREATE TABLE criterio_aceitacao (
  id INT NOT NULL,
  descricao VARCHAR NOT NULL,
  peso FLOAT NOT NULL,
  id_feedback INT,
  id_professor INT,
  id_equipe INT,
  id_projeto INT,
  id_sprint INT,
  id_entrega INT,
  id_versao INT,
  PRIMARY KEY (id_feedback, id_professor, id_equipe, id_projeto, id_sprint, id_entrega, id_versao, id),
  FOREIGN KEY (id_feedback, id_professor, id_equipe, id_projeto, id_sprint, id_entrega, id_versao) 
    REFERENCES feedback(id, id_professor, id_equipe, id_projeto, id_sprint, id_entrega, id_versao)
);
