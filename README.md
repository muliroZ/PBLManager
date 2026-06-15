# 🎓 PBL Manager - Gestão de Ciclo de Vida de Projetos Acadêmicos

## 📖 Introdução

O **PBL Manager** (Project-Based Learning Manager) é um ecossistema digital focado na estruturação, acompanhamento e avaliação de projetos acadêmicos que adotam metodologias ativas de ensino. Desenvolvido com base em um robusto banco de dados relacional, o sistema visa organizar a complexidade do trabalho colaborativo, oferecendo rastreabilidade de entregas e um histórico institucional.

## 🎯 Objetivo

Em vez do modelo tradicional, a Aprendizagem Baseada em Projetos (PBL) foca na resolução prática de problemas do mundo real em equipe. O banco de dados do PBL Manager tem o objetivo de resolver desafios complexos de gestão como:

* Relacionamentos complexos entre alunos, grupos, turmas e projetos.
* Versionamento histórico de entregas e submissões (evitando perda de dados através de rastreabilidade de refatoração).
* Mapeamento de tecnologias e avaliações de feedback.
* Feedbacks do professor nas versões do projeto.

## 🛠️ Stack de Tecnologias

* **SGBD:** PostgreSQL (Relacional)
* **Backend:** Python + Flask (API integrada ao banco)
* **Frontend:** React + TypeScript + Vite (Interface Web simples)
* **Infraestrutura:** Docker e Docker Compose (Isolamento de ambiente)
* **Modelagem:** ERDPlus (Modelo Conceitual e Relacional)
* **Cliente DB:** PgAdmin (Gestão do PostgreSQL e Consultas DML/DDL)
* **Testes da Aplicação:** Python, `pytest` e `psycopg2` (Validação de restrições de integridade).

---

## 🗄️ Arquitetura e Modelagem do Banco de Dados

O ecossistema é composto por **20 tabelas relacionais** estruturadas de forma coesa e normalizadas até a **3ª Forma Normal (3FN)**, eliminando redundâncias estruturais e inconsistências de atualização.

### 🔷 Módulos do Ecossistema

#### 1. Fundação Institucional e Usuários

Modela os atores centrais e a estrutura macro da instituição de ensino, implementando uma estratégia de **Especialização Sobreposta/Exclusiva** mapeada via chaves estrangeiras (`FOREIGN KEY`) apontando para a tabela pai.

* `usuario`: Entidade abstrata contendo as credenciais globais e informações básicas de autenticação (`id`, `nome_completo`, `email`, `senha`).
* `professor`: Especialização de usuário contendo atributos exclusivos como `titulacao`.
* `aluno`: Especialização de usuário para os discentes.
* `departamento`: Unidades administrativas institucionais (`id`, `nome`, `sigla`).
* `curso`: Cursos vinculados a um departamento através de um relacionamento `1:N`.

#### 2. Organização Acadêmica e Disciplinas

Mapeia como as matérias e os períodos letivos se dividem.

* `disciplina`: Catálogo geral de disciplinas com sua respectiva `carga_horaria`.
* `curso_disciplina`: Tabela de junção configurando a relação muitos-para-muitos (`N:M`) entre cursos e disciplinas.
* `turma`: Instanciação de uma disciplina em um `semestre` específico.
* `aluno_turma`: Histórico de matrículas (`N:M` entre aluno e turma), registrando o `status` acadêmico atual do discente na sala.

#### 3. Core PBL (Equipes e Projetos)

Gerencia o agrupamento de alunos e a vinculação dos desafios práticos propostos.

* `equipe`: Agrupamento gerado em uma determinada `data_formacao` e vinculado a uma única `turma`.
* `membro_equipe`: Tabela associativa `N:M` que aloca alunos em equipes, definindo a `funcao` exercida (ex: Scrum Master, Product Owner, DevOps).
* `projeto`: O escopo geral do desafio acadêmico.
* `equipe_projeto`: Tabela de junção ligando equipes a seus respectivos projetos.
* `tecnologia`: Dicionário global de tecnologias (ex: PostgreSQL, Docker, Python).
* `projeto_tecnologia`: Relacionamento `N:M` mapeando quais ferramentas foram adotadas em cada projeto, especificando a `categoria` e a `versao`.

#### 4. Ciclos, Versionamento e Avaliação (Entidades Fracas em 3FN)

Camada de gerenciamento temporal e granularidade de entregas, modelada em níveis hierárquicos de dependência forte.

* `sprint`: Divisão cronológica do projeto (`numero`, `data_fim`).
* `entrega`: Artefatos e marcos esperados de uma equipe dentro de uma sprint.
* `versao`: Versionamento evolutivo das entregas, contendo o `link_repositorio` (GitHub) e a `data_submissao`. Evita perdas por sobrescritas.
* `feedback`: Avaliação nominal realizada por um `professor` direcionada a uma `versao` específica, computando uma `nota` decimal.
* `criterio_aceitacao`: Destrinchamento granular do feedback, definindo uma `descricao` para o item avaliado e seu respectivo `peso` multiplicador na média.

---

## 💻 A Aplicação Fullstack (Flask + React)

A aplicação consome a inteligência funcional programada no banco de dados, atuando como uma ponte direta entre os cálculos relacionais complexos e uma interface rica focada na experiência do usuário.

### 🔌 Backend (Flask API)

Desenvolvido em Python, o servidor REST (`main.py`) expõe endpoints corporativos para controle de turmas, submissão de artefatos e lançamentos de notas.

* **`init_db.py` (Script de Inicialização):** Um script utilitário responsável por se conectar programaticamente ao PostgreSQL usando as credenciais do `.env`, validar a conexão e rodar a criação de tabelas (`criar_tabelas.sql`), funções, triggers e views, além de rodar os seeders (`popular_tabelas.sql`).

* **Ponto de Entrada:** Rodando nativamente no container `pbl_backend` exposto na porta `5000`.

### 🎨 Frontend (React SPA)

Uma interface modular de alta performance estruturada com TypeScript e compilada através do Vite.

* **Componentes Core:**

    * `AbasSprints.tsx`: Chaveamento de ciclos cronológicos e controle visual de prazos limites.

    * `ListaEntregas.tsx`: Listagem em tempo real contendo o status de cada entrega (automatizado via banco de dados).

    * `CardEquipe.tsx`: Cartões consolidados exibindo o mapeamento de alunos, suas funções de liderança e médias ponderadas.

* **Ponto de Entrada**: Rodando no container `pbl_frontend` exposto na porta `5173`.

---

## 📋 Checklist de Requisitos do Projeto (Critérios de Avaliação)

Mapeamento dos requisitos obrigatórios cumpridos de acordo com as diretrizes da disciplina:

* [x] **Divisão de Grupos (no máximo 4 pessoas):** Controlado de forma estrita via Triggers no banco de dados.
* [x] **Projeto de Banco de Dados Normalizado (40%):** Modelos Conceitual e Relacional projetados sem redundâncias estruturais.
* [x] **Estrutura de Tabelas (30%):** Mais de 20 tabelas e views estruturadas de forma coesa.
* [x] **Camada de Inteligência Funcional (30%):** Conjunto completo de Views, Triggers e Procedures operacionais.
* [x] **Seeders para População (10%):** Scripts SQL de inserts realistas automatizados para testes de concorrência e amostragem.
* [x] **Testes a Nível de Aplicação (10%):** Suíte de testes automatizados escrita em Python com `pytest`.
* [x] **Documentação Completa (10%):** Regras de negócio mapeadas e README atualizado.

---

## 🛠️ Inteligência Programada (Backend SQL)

### 📈 Views Analíticas

* `vw_visao_geral_equipes`: Consolida os dados cruciais das equipes, seus respectivos projetos, turmas e disciplinas para acompanhamento macro do professor.
* `vw_acompanhamento_sprints`: Mapeia de forma cronológica as sprints vigentes, datas limites e o progresso associado.
* `vw_feedbacks_e_criterios`: Reúne as avaliações feitas pelos professores, as notas aplicadas e as descrições dos critérios de aceitação vinculados.

### ⚙️ Procedures e Automações

* `matricular_aluno_turma`: Processa inscrições de alunos garantindo a integridade e limitando o máximo de 40 matrículas por turma.
* `criar_proxima_sprint`: Facilita o desdobramento ágil ao criar de forma sequencial o próximo ciclo temporal de um projeto.
* `reprovar_por_falta_evasao`: Atualiza massivamente o status acadêmico de discentes que abandonaram ou não se integraram aos fluxos do PBL.

### 🔒 Triggers de Integridade e Regras de Negócio Estritas

* `trg_restricao_aluno_equipes`: Garante em nível de banco que nenhum aluno consiga fazer parte de mais de uma equipe dentro da mesma turma.
* `trg_garantia_aluno_matriculado`: Bloqueia tentativas de alocar um aluno em uma equipe se ele não possuir vínculo de matrícula ativo na turma correspondente.
* `trg_mudanca_status_por_feedback`: Analisa a inserção de notas. Atribui automaticamente status de:
* **Aprovado:** Se $\text{Nota} \ge 8.0$.
* **Necessita de ajustes:** Se $\text{Nota}$ estiver entre $4.0$ e $7.9$.
* **Reprovado:** Se $\text{Nota} < 4.0$.

---

## 📁 Estrutura do Projeto

```ini
PBLManager/
├── .env.example                       # Variáveis de ambiente de exemplo
├── docker-compose.yml                 # Orquestração do PostgreSQL via Docker
├── Dockerfile                         # Arquivo de build Docker do backend
├── diagramas/
│   ├── Modelo Conceitual.pdf          # Diagrama Entidade-Relacionamento (DER)
│   └── Modelo Relacional.pdf          # Diagrama Relacional/Lógico
├── docs/
│   ├── Captura de tela 2026-06-04 205608.png  # Diretrizes de avaliação
│   └── PBL Manager.pdf                # Regras de negócio e escopo detalhado
├── frontend/                          # Interface React + Vite + Typescript (com Bun)
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
├── main.py                            # Ponto de entrada da API Flask
├── init_db.py                         # Inicializador automatizado do banco de dados
├── entrypoint.sh                      # Inicializador do backend no Dockerfile
├── setup.sh                           # Script shell de automação geral do deploy
└── README.md                          # Este arquivo

```

---

## 🚀 Como Inicializar o Projeto (Instruções de Uso)

### 1. Pré-requisitos

* Ter o **Docker** e o **Docker Compose** instalados na sua máquina.
* Python 3.10+ (opcional, apenas se desejar rodar a suíte de testes de aplicação localmente).

### 2. Subindo o Banco de Dados com Docker

O projeto já conta com um `docker-compose.yml` para facilitar a inicialização do PostgreSQL. No terminal, na raiz do projeto, execute:

```bash
# 1. Copie o arquivo de variáveis de ambiente:
cp .env.example .env

```

Preencha as variáveis de ambiente do arquivo `.env` após copiar.

> ⚠️ **Nota:** O valor da variável `PGADMIN_DEFAULT_EMAIL` deve ser preenchido no padrão 'xxx@xxx.com'. O valor das variáveis de ambiente restantes é arbitrário, preencha como quiser.

```bash
# 2. Inicie o container do banco:
docker compose up -d --build

```

> **Nota:** Após executar, rode o comando `uv run init_db.py` com a variável `POSTGRES_HOST` vazia.

*O PostgreSQL estará disponível na porta `5432`.*

#### Inicialização Automatizada (Via setup.sh)

Se você estiver em um ambiente Linux/macOS (ou Git Bash/WSL no Windows), fornecemos um script único que gerencia variáveis de ambiente, sobe os serviços, aguarda a prontidão do banco e injeta os dados iniciais automaticamente.

Na raiz do projeto, execute:
```bash
# Conceda permissão de execução ao script
chmod +x setup.sh

# Execute o setup automatizado
./setup.sh
```

**O que este script faz por baixo dos panos?**

1. Executa a orquestração multi-container `docker-compose up -d --build`.
2. Instala dependências com o comando `uv sync`.
3. Executa o `init_db.py` e popula o banco.

#### 🗺️ URLs e Acessos Rápidos do Ecossistema

Após a finalização de qualquer um dos métodos acima, os seguintes serviços estarão disponíveis:

* 🌐 Interface Frontend (React App): [PBLManager](http://localhost:5173)
* 🔌 API Backend (Flask REST): [Backend](http://localhost:5000)
* 🗃️ Painel de Gestão DB (PgAdmin): [PgAdmin](http://localhost:5050)

### 3. Conectando no PgAdmin

1. Abra o seu navegador e acesse a URL **http://localhost:5050/** e preencha as credenciais com os valores do `.env`.
2. Clique em *Add New Server* e preencha o campo *Name* com o que preferir.
3. Após isso, clique na aba *Connection* e preencha os campos com os valores do `.env`:
* **Host:** `db` *(nome do serviço do postgres no docker-compose.yml)*
* **Port:** `5432` *(porta padrão do postgres)*
* **Maintenance Database:** `pbl_manager` *(ou o definido no `.env`)*
* **Username:** `postgres` *(ou o definido no `.env`)*
* **Password:** `postgres` *(ou a definida no `.env`)*
* **Save Password?:** `Ligado`


4. Clique em *Save* e verifique se o novo Server apareceu no campo superior esquerdo.
5. Acesse-o e entre no seu banco de dados.

### 4. Executando os Scripts de Criação (DDL)

#### **PgAdmin:**

1. Abra um novo CREATE script no Esquema public da conexão criada.
2. Substitua tudo pelo conteúdo do arquivo `scripts/criacao/criar_tabelas.sql`.
3. Execute o script. Ele criará todas as 20 tabelas estruturadas de forma coesa.

#### **PSQL (Terminal):**

Se preferir injetar diretamente via linha de comando:

```bash
# Git Bash / WSL
docker exec -i pg_docker psql -U seu_usuario -d nome_banco < scripts/criacao/criar_tabelas.sql

```

```powershell
# PowerShell
Get-Content .\scripts\criacao\criar_tabelas.sql | docker exec -i pg_docker psql -U seu_usuario -d nome_banco

```

### 5. Ingestão de Dados de Teste (Seeders)

Para rodar os cenários de testes e validar o comportamento real com dados de amostragem:

```bash
docker exec -i pg_docker psql -U seu_usuario -d nome_banco < scripts/seeds/popular_tabelas.sql

```

---

## 🧪 Executando os Testes Automatizados (Nível de Aplicação)

O ecossistema dispõe de uma suíte de testes com `pytest` focada em assegurar que nenhuma alteração de código ou migração viole as regras de negócio em nível de banco de dados.

Os testes cobrem:

* Inserção bem-sucedida de usuários e validação de chaves substitutas (`Surrogate Keys`).
* Violação de e-mails únicos (`Unique Key Validation`).
* Integridade referencial de Especialização (`professor` -> `usuario`).
* Restrição de chaves primárias e duplicidade de cronograma em entidades fracas (`sprint`).
* Bloqueio e barramento de inserções ilegítimas (`ForeignKeyViolation`).

### Passo a Passo para Execução dos Testes:

1. **Crie e Ative um ambiente virtual Python:**
```bash
python -m venv venv
# Linux/macOS:
source venv/bin/activate
# Windows (PowerShell):
.\venv\Scripts\Activate.ps1

```


2. **Instale as dependências da suíte de teste:**
```bash
pip install pytest psycopg2-binary

```


3. **Execute os testes:**
```bash
pytest tests/test_database.py -v

```



---

## 👨‍💻 Créditos

* **Disciplina:** Desenvolvido no escopo da disciplina de **Banco de Dados**.
* **Membros:** Gustavo Vilela, José Severo, Maria Carolina e Murilo Andrade.
* **Professor Orientador:** Prof. Dr. Carlos Melo.

---

> *"A boa arquitetura de dados não é sobre guardar informação, é sobre contar a história do negócio sem perder os detalhes."*