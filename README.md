

# 🎓 PBL Manager - Gestão de Ciclo de Vida de Projetos Acadêmicos

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-00000F?style=for-the-badge&logo=sql&logoColor=white)
![PgAdmin](https://img.shields.io/badge/pgAdmin-4-800080?style=for-the-badge&logo=postgresql)
![Status](https://img.shields.io/badge/Status-Em_Desenvolvimento-green?style=for-the-badge)

## 📖 Introdução
O **PBL Manager** (Project-Based Learning Manager) é um ecossistema digital focado na estruturação, acompanhamento e avaliação de projetos acadêmicos que adotam metodologias ativas de ensino. Desenvolvido com base em um robusto banco de dados relacional, o sistema visa organizar a complexidade do trabalho colaborativo, oferecendo rastreabilidade de entregas, avaliações 360 e um histórico institucional.

## 🎯 Objetivo
Em vez do modelo tradicional, a Aprendizagem Baseada em Projetos (PBL) foca na resolução prática de problemas do mundo real em equipe. O banco de dados do PBL Manager tem o objetivo de resolver desafios complexos de gestão como:
- Relacionamentos complexos entre alunos, grupos, turmas e projetos.
- Auto-relacionamentos (ex: monitoria entre alunos).
- Versionamento histórico de entregas e submissões (evitando perda de dados através de rastreabilidade de refatoração).
- Mapeamento de tecnologias e avaliações de feedback.

## 🛠️ Stack de Tecnologias
- **SGBD:** PostgreSQL (Relacional)
- **Infraestrutura:** Docker e Docker Compose (Isolamento de ambiente)
- **Modelagem:** ERDPlus e BrModelo (Modelo Conceitual e Relacional)
- **Cliente DB:** DBeaver (Gestão Universal e Consultas DML/DDL)

## 📁 Estrutura do Projeto

```ini
PBLManager/
├── .env.example                       # Variáveis de ambiente de exemplo
├── docker-compose.yml                 # Orquestração do PostgreSQL via Docker
├── scripts/
│   └── criação/
│       └── criar_tabelas.sql          # Scripts DDL das 20 tabelas estruturadas
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
> **Nota:** O valor da variável `PGADMIN_DEFAULT_PASSWORD` deve ser preenchido no padrão 'xxx@xxx.com'. O valor das variáveis de ambiente restantes é arbitrário, preencha como quiser.

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

## ✨ Próximos Passos (Roadmap)

* [ ] Construir os *Seeders* para popular o banco de dados com dados de teste.
* [ ] Desenvolver as Views e Procedures (regras de negócio e relatórios complexos).
* [ ] Implementar Triggers para as restrições de integridade complexas (ex: limite de alunos no grupo).

## 👨‍💻 Créditos

* **Disciplina:** Desenvolvido no escopo da disciplina de **Banco de Dados**.
* **Membros:** Gustavo Vilela, José Severo, Maria Carolina e Murilo Andrade.
* **Professor Orientador:** Prof. Dr. Carlos Melo.

---

> *"A boa arquitetura de dados não é sobre guardar informação, é sobre contar a história do negócio sem perder os detalhes."*
