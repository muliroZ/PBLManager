

# 🎓 PBL Manager - Gestão de Ciclo de Vida de Projetos Acadêmicos

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-00000F?style=for-the-badge&logo=sql&logoColor=white)
![PgAdmin](https://img.shields.io/badge/pgAdmin-4-800080?style=for-the-badge&logo=postgresql)
![Status](https://img.shields.io/badge/Status-Em_Desenvolvimento-green?style=for-the-badge)

## 📖 Introdução
O **PBL Manager** (Project-Based Learning Manager) é um ecossistema digital focado na estruturação, acompanhamento e avaliação de projetos acadêmicos que adotam metodologias ativas de ensino. Desenvolvido com base em um robusto banco de dados relacional, o sistema visa organizar a complexidade do trabalho colaborativo, oferecendo rastreabilidade de entregas e um histórico institucional.

## 🎯 Objetivo
Em vez do modelo tradicional, a Aprendizagem Baseada em Projetos (PBL) foca na resolução prática de problemas do mundo real em equipe. O banco de dados do PBL Manager tem o objetivo de resolver desafios complexos de gestão como:
- Relacionamentos complexos entre alunos, grupos, turmas e projetos.
- Versionamento histórico de entregas e submissões (evitando perda de dados através de rastreabilidade de refatoração).
- Mapeamento de tecnologias e avaliações de feedback.
- Feedbacks do professor nas versões do projeto.

## 🛠️ Stack de Tecnologias
- **SGBD:** PostgreSQL (Relacional)
- **Infraestrutura:** Docker e Docker Compose (Isolamento de ambiente)
- **Modelagem:** ERDPlus (Modelo Conceitual e Relacional)
- **Cliente DB:** PgAdmin (Gestão do PostgreSQL e Consultas DML/DDL)

## 📋 Checklist de Requisitos do Projeto (Critérios de Avaliação)
Mapeamento dos requisitos obrigatórios cumpridos de acordo com as diretrizes da disciplina:

- [x] **Divisão de Grupos (no máximo 4 pessoas):** Controlado de forma estrita via Triggers no banco de dados.
- [x] **Projeto de Banco de Dados Normalizado (40%):** Modelos Conceitual e Relacional projetados sem redundâncias estruturais.
- [x] **Estrutura de Tabelas (30%):** Mais de 20 tabelas e views estruturadas de forma coesa.
- [x] **Camada de Inteligência Funcional (30%):** Conjunto completo de Views, Triggers e Procedures operacionais.
- [x] **Seeders para População (10%):** Scripts SQL de inserts realistas automatizados para testes de concorrência e amostragem.
- [x] **Testes a Nível de Aplicação (10%):** Suíte de testes automatizados escrita em Python com `pytest`.
- [x] **Documentação Completa (10%):** Regras de negócio mapeadas e README atualizado.

## 🛠️ Inteligência Programada (Backend SQL)

### 📈 Views Analíticas

* `vw_visao_geral_equipes`: Consolida os dados cruciais das equipes, seus respectivos projetos, turmas e disciplinas para acompanhamento macro do professor.
* `vw_acompanhamento_sprints`: Mapeia de forma cronológica as sprints vigentes, datas limites e o progresso associado.
* `vw_feedbacks_e_criterios`: Reúne as avaliações feitas pelos professores, as notas aplicadas e as descrições dos critérios de aceitação vinculados.

### ⚙️ Procedures e Automações

* `matricular_aluno_turma`: Processa inscrições de alunos garantindo a integridade e limitando o máximo de 40 matrículas por turma.
* `criar_proxima_sprint`: Facilita o desdobramento ágil ao criar de forma sequencial o próximo ciclo temporal de um projeto.
* `reprovar_por_falta_evasao`: Atualiza massivamente o status acadêmico de discentes que abandonaram ou não se integraram aos fluxos do PBL.

### 🔒 Triggers de Integridade

* `trg_restricao_aluno_equipes`: Garante em nível de banco que nenhum aluno consiga fazer parte de mais de uma equipe dentro da mesma turma.
* `trg_garantia_aluno_matriculado`: Bloqueia tentativas de alocar um aluno em uma equipe se ele não possuir vínculo de matrícula ativo na turma correspondente.
* `trg_mudanca_status_por_feedback`: Analisa a inserção de notas. Atribui automaticamente status de *Aprovado* (Nota ≥ 8.0), *Necessita de ajustes* (Nota entre 4.0 e 7.9) ou *Reprovado* (Nota < 4.0) à respectiva entrega.
## 📁 Estrutura do Projeto

```ini
PBLManager/
├── .env.example                       # Variáveis de ambiente de exemplo
├── docker-compose.yml                 # Orquestração do PostgreSQL via Docker
├── diagramas/
│   ├── Modelo Conceitual.pdf          # Diagrama Entidade-Relacionamento (DER)
│   └── Modelo Relacional.pdf          # Diagrama Relacional/Lógico
├── docs/
│   ├── Captura de tela 2026-06-04 205608.png  # Diretrizes de avaliação
│   └── PBL Manager.pdf                # Regras de negócio e escopo detalhado
├── scripts/
│   ├── criacao/
│   │   └── criar_tabelas.sql          # Script DDL das 20 tabelas principais
│   ├── consulta/
│   │   ├── consulta01.sql             # Consultas pontuais de testes
│   │   ├── scripts_principais_consultas.sql # Queries avançadas do ecossistema
│   │   ├── vw_acompanhamento_sprints.sql    # View de controle de prazos por ciclo
│   │   ├── vw_feedbacks_e_criterios.sql     # View de notas e critérios de aceitação
│   │   └── vw_visao_geral_equipes.sql       # View analítica consolidada de equipes
│   ├── functions/
│   │   ├── func_Alunos_Em_Turma.sql   # Contador de densidade por sala
│   │   ├── func_busca_link_GitHub.sql # Localizador de artefatos por versão
│   │   ├── func_obter_Média_Equipe.sql# Cálculo de média ponderada de notas
│   │   ├── func_Professor_Por_Id.sql  # Captura nominal de orientadores
│   │   └── func_Sprints_Projeto.sql   # Mapeador de ciclos por escopo
│   ├── seeds/
│   │   ├── procedures/
│   │   │   ├── criar_proxima_sprint.sql     # Gerador automatizado de cronograma
│   │   │   ├── matricular_aluno_turma.sql   # Validador de limite de vagas (máx 40)
│   │   │   └── reprovar_por_falta_evasao.sql# Rotina de atualização de status
│   │   └── popular_tabelas.sql        # Ingestão de dados realistas (DML)
│   └── triggers/
│       ├── trg_garantia_aluno_matriculado.sql # Restringe alocações ilegítimas
│       ├── trg_mudanca_status_por_feedback.sql# Automação de status da entrega por nota
│       └── trg_restricao_aluno_equipes.sql    # Impede duplicidade de aluno em equipes
├── diagramas/
│   ├── Modelo Conceitual.pdf          # Diagrama Entidade-Relacionamento
│   └── Modelo Relacional.pdf          # Diagrama Relacional (Lógico)
├── docs/
│   └── PBL Manager.pdf                # Documentação oficial e regras de negócio
└── README.md                          # Este arquivo
```

## 🚀 Como Inicializar o Projeto (Instruções de Uso)

### 1. Pré-requisitos

* Ter o **Docker** e o **Docker Compose** instalados na sua máquina.

### 2. Subindo o Banco de Dados com Docker

O projeto já conta com um `docker-compose.yml` para facilitar a inicialização do PostgreSQL.
No terminal, na raiz do projeto, execute:

```bash
# 1. Copie o arquivo de variáveis de ambiente:
cp .env.example .env
```

Preencha as variáveis de ambiente do arquivo .env após copiar
> **Nota:** O valor da variável `PGADMIN_DEFAULT_EMAIL` deve ser preenchido no padrão 'xxx@xxx.com'. O valor das variáveis de ambiente restantes é arbitrário, preencha como quiser.

```bash
# 2. Inicie o container do banco:
docker-compose up -d
```

*O PostgreSQL estará disponível na porta `5432`.*

### 3. Conectando no PgAdmin

1. Abra o seu navegador e acesse a URL **http://localhost:5050/** e preencha as credenciais com os valores do `.env`.
2. Clique em *Add New Server* e preencha o campo *Name* com o que preferir.
3. Após isso, clique na aba *Connection* e preencha os campos com os valores do `.env`:
* **Host:** `db` # nome do serviço do postgres no docker-compose.yml
* **Port:** `5432` # porta padrão do postgres
* **Maintenance Database:** `pbl_manager` (ou o definido no `.env`)
* **Username:** `postgres` (ou o definido no `.env`)
* **Password:** `postgres` (ou a definida no `.env`)
* **Save Password?:** `Ligado`

3. Clique em *Save* e verifique se o novo Server apareceu no campo superior esquerdo.
4. Acesse-o e entre no seu banco de dados

### 4. Executando os Scripts de Criação (DDL)

**PgAdmin:**
1. Abra um novo CREATE script no Esquema public da conexão criada.
2. Substitua tudo pelo conteúdo do arquivo `scripts/criação/criar_tabelas.sql`.
3. Execute o script. Ele criará todas as 20 tabelas, estruturando os módulos de:
* Fundação Institucional
* Organização Acadêmica
* Core PBL
* Tecnologias
* Ciclos e Versionamento
* Avaliações e Feedback

**PSQL (Terminal):**

1. Abra o terminal na raiz do projeto e execute o seguinte comando:
```bash
# Git Bash / WSL
docker exec -i pg_docker psql -U seu_usuario -d nome_banco < scripts/criacao/criar_tabelas.sql
```

```pwsh
# PowerShell
Get-Content .\scripts\criacao\criar_tabelas.sql | docker exec -i pg_docker psql -U seu_usuario -d nome_banco
```

## 👨‍💻 Créditos

* **Disciplina:** Desenvolvido no escopo da disciplina de **Banco de Dados**.
* **Membros:** Gustavo Vilela, José Severo, Maria Carolina e Murilo Andrade.
* **Professor Orientador:** Prof. Dr. Carlos Melo.

---

> *"A boa arquitetura de dados não é sobre guardar informação, é sobre contar a história do negócio sem perder os detalhes."*
