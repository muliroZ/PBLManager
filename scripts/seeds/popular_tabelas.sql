
-- 1. TECNOLOGIAS
INSERT INTO tecnologia (id, nome) VALUES 
(1, 'PostgreSQL'),
(2, 'Java (Spring Boot)'),
(3, 'Python (Django)'),
(4, 'React Native'),
(5, 'TypeScript'),
(6, 'Docker'),
(7, 'AWS Cloud'),
(8, 'NestJS'),
(9, 'Haskell'),
(10, 'Vue.js');

-- 2. PROJETOS

INSERT INTO projeto (id, nome) VALUES 
(501, 'Sistema de Gestão de Pizzaria'),
(502, 'Plataforma Acadêmica UPE'),
(503, 'Aplicativo de Monitoria Inteligente'),
(504, 'E-commerce para Produtores Locais'),
(505, 'Dashboard de Desempenho de Sprints');

-- 3. Disciplinas
INSERT INTO disciplina (id, nome, carga_horaria) VALUES 
(101, 'Algoritmos e Estruturas de Dados', 60),
(102, 'Banco de Dados', 60),
(103, 'Engenharia de Software', 45),
(104, 'Programação Funcional', 60),
(105, 'Sistemas Operacionais', 60),
(106, 'Redes de Computadores', 60),
(107, 'Análise de Requisitos', 45),
(108, 'Arquitetura de Software', 45),
(109, 'Interface Usuário-Computador', 30),
(110, 'Metodologias Ágeis', 30),
(111, 'Inteligência Artificial', 60),
(112, 'Segurança de Sistemas', 45),
(113, 'Qualidade de Software', 45),
(114, 'Desenvolvimento Web', 60),
(115, 'Desenvolvimento Mobile', 60),
(116, 'Compiladores', 60),
(117, 'Teoria da Computação', 60),
(118, 'Programação Orientada a Objetos', 60),
(119, 'Governança de TI', 30),
(120, 'Trabalho de Conclusão de Curso 1', 45);

-- Tabelas de Controle Acadêmico de Base
INSERT INTO departamento (id, nome, sigla) VALUES 
(1, 'Departamento de Tecnologia', 'DT');

INSERT INTO curso (id, nome, id_departamento) VALUES 
(10, 'Engenharia de Software', 1);

-- Vinculando as disciplinas ao curso
INSERT INTO curso_disciplina (id_curso, id_disciplina) VALUES 
(10, 101),
(10, 102),
(10, 103),
(10, 104),
(10, 105);
 
 -- Usuários: Professores
INSERT INTO usuario (id, nome_completo, email, senha) VALUES 
(1, 'Carlos Melo', 'carlos.melo@upe.br', 'senhaProf1'),
(2, 'Murilo Monitor', 'murilo.monitor@upe.br', 'senhaProf2'),
(3, 'Alexandre Souza', 'alexandre.souza@upe.br', 'senhaProf3'),
(4, 'Patricia Lima', 'patricia.lima@upe.br', 'senhaProf4'),
(5, 'Roberto Alves', 'roberto.alves@upe.br', 'senhaProf5'),
(6, 'Fernando Costa', 'fernando.costa@upe.br', 'senhaProf6'),
(7, 'Luciana Mendes', 'luciana.mendes@upe.br', 'senhaProf7'),
(8, 'Ricardo Gomes', 'ricardo.gomes@upe.br', 'senhaProf8'),
(9, 'Camila Rocha', 'camila.rocha@upe.br', 'senhaProf9'),
(10, 'Bruno Silva', 'bruno.silva@upe.br', 'senhaProf10');

-- Usuários: Alunos
INSERT INTO usuario (id, nome_completo, email, senha) VALUES 
(11, 'Severo Santos', 'severo.santos@upe.br', 'senhaAluno11'),
(12, 'Arthur Aguiar', 'arthur.aguiar@upe.br', 'senhaAluno12'),
(13, 'Beatriz Cavalcanti', 'beatriz.cavalcanti@upe.br', 'senhaAluno13'),
(14, 'Caio Ribeiro', 'caio.ribeiro@upe.br', 'senhaAluno14'),
(15, 'Daniela Albuquerque', 'daniela.albuquerque@upe.br', 'senhaAluno15'),
(16, 'Eduardo Campos', 'eduardo.campos@upe.br', 'senhaAluno16'),
(17, 'Felipe Neto', 'felipe.neto@upe.br', 'senhaAluno17'),
(18, 'Gabriel Jesus', 'gabriel.jesus@upe.br', 'senhaAluno18'),
(19, 'Heitor Villa', 'heitor.villa@upe.br', 'senhaAluno19'),
(20, 'Isabela Fontana', 'isabela.fontana@upe.br', 'senhaAluno20'),
(21, 'Júlia Roberts', 'julia.roberts@upe.br', 'senhaAluno21'),
(22, 'Kevin Bacon', 'kevin.bacon@upe.br', 'senhaAluno22'),
(23, 'Larissa Manoela', 'larissa.manoela@upe.br', 'senhaAluno23'),
(24, 'Matheus Costa', 'matheus.costa@upe.br', 'senhaAluno24'),
(25, 'Nathália Dill', 'nathalia.dill@upe.br', 'senhaAluno25'),
(26, 'Otávio Mesquita', 'otavio.mesquita@upe.br', 'senhaAluno26'),
(27, 'Pedro Bial', 'pedro.bial@upe.br', 'senhaAluno27'),
(28, 'Quezia Lima', 'quezia.lima@upe.br', 'senhaAluno28'),
(29, 'Rodrigo Faro', 'rodrigo.faro@upe.br', 'senhaAluno29'),
(30, 'Sabrina Sato', 'sabrina.sato@upe.br', 'senhaAluno30'),
(31, 'Tiago Leifert', 'tiago.leifert@upe.br', 'senhaAluno31'),
(32, 'Úrsula Corberó', 'ursula.corbero@upe.br', 'senhaAluno32'),
(33, 'Vitor Kley', 'vitor.kley@upe.br', 'senhaAluno33'),
(34, 'Wagner Moura', 'wagner.moura@upe.br', 'senhaAluno34'),
(35, 'Xuxa Meneghel', 'xuxa.meneghel@upe.br', 'senhaAluno35'),
(36, 'Yuri Alberto', 'yuri.alberto@upe.br', 'senhaAluno36'),
(37, 'Zeca Pagodinho', 'zeca.pagodinho@upe.br', 'senhaAluno37'),
(38, 'Alana Torres', 'alana.torres@upe.br', 'senhaAluno38'),
(39, 'Breno Silveira', 'breno.silveira@upe.br', 'senhaAluno39'),
(40, 'Clara Nunes', 'clara.nunes@upe.br', 'senhaAluno40'),
(41, 'Davos Seaworth', 'davos.seaworth@upe.br', 'senhaAluno41'),
(42, 'Elisa Lucinda', 'elisa.lucinda@upe.br', 'senhaAluno42'),
(43, 'Fabio Assunção', 'fabio.assunção@upe.br', 'senhaAluno43'),
(44, 'Gisele Bündchen', 'gisele.bündchen@upe.br', 'senhaAluno44'),
(45, 'Heloísa Périssé', 'heloisa.perisse@upe.br', 'senhaAluno45'),
(46, 'Igor Jansen', 'igor.jansen@upe.br', 'senhaAluno46'),
(47, 'Jonathan Azevedo', 'jonathan.azevedo@upe.br', 'senhaAluno47'),
(48, 'Kéfera Buchmann', 'kefera.buchmann@upe.br', 'senhaAluno48'),
(49, 'Lázaro Ramos', 'lazaro.ramos@upe.br', 'senhaAluno49'),
(50, 'Marieta Severo', 'marieta.severo@upe.br', 'senhaAluno50'),
(51, 'Neymar Junior', 'neymar.junior@upe.br', 'senhaAluno51'),
(52, 'Orlando Bloom', 'orlando.bloom@upe.br', 'senhaAluno52'),
(53, 'Paolla Oliveira', 'paolla.oliveira@upe.br', 'senhaAluno53'),
(54, 'Quentin Tarantino', 'quentin.tarantino@upe.br', 'senhaAluno54'),
(55, 'Reynaldo Gianecchini', 'reynaldo.gianecchini@upe.br', 'senhaAluno55'),
(56, 'Stênio Garcia', 'stenio.garcia@upe.br', 'senhaAluno56'),
(57, 'Tais Araújo', 'tais.araujo@upe.br', 'senhaArthur57'),
(58, 'Viviane Araújo', 'viviane.araujo@upe.br', 'senhaAluno58'),
(59, 'William Bonner', 'william.bonner@upe.br', 'senhaAluno59'),
(60, 'Zezé Polessa', 'zeze.polessa@upe.br', 'senhaAluno60');

-- ESPECIALIZAÇÃO: Vinculando à tabela professor
INSERT INTO professor (id, titulacao) VALUES 
(1, 'Doutorado'),
(2, 'Mestrado'),
(3, 'Doutorado'),
(4, 'Doutorado'),
(5, 'Mestrado'),
(6, 'Doutorado'),
(7, 'Mestrado'),
(8, 'Doutorado'),
(9, 'Doutorado'),
(10, 'Mestrado');

-- ESPECIALIZAÇÃO: Vinculando os 50 IDs à tabela aluno
INSERT INTO aluno (id) VALUES 
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35), (36), (37), (38), (39), (40),
(41), (42), (43), (44), (45), (46), (47), (48), (49), (50),
(51), (52), (53), (54), (55), (56), (57), (58), (59), (60);

-- Criando as turmas letivas
INSERT INTO turma (id, semestre, id_disciplina) VALUES 
(1, '2026.1', 101),
(2, '2026.1', 102);

-- Criando as 5 Equipes
INSERT INTO equipe (id, data_formacao, id_turma) VALUES 
(401, '2026-03-01', 1),
(402, '2026-03-01', 1),
(403, '2026-03-01', 1),
(404, '2026-03-01', 2),
(405, '2026-03-01', 2);

-- as Equipes nos Projetos
INSERT INTO equipe_projeto (id_equipe, id_projeto) VALUES 
(401, 501),
(402, 502),
(403, 503),
(404, 504),
(405, 505);



INSERT INTO aluno_turma (id_aluno, id_turma, status) VALUES 
(11, 1, 'Matriculado'), (12, 1, 'Matriculado'), (13, 1, 'Matriculado'), (14, 1, 'Matriculado'), (15, 1, 'Matriculado'),
(16, 1, 'Matriculado'), (17, 1, 'Matriculado'), (18, 1, 'Matriculado'), (19, 1, 'Matriculado'), (20, 1, 'Matriculado'),
(21, 1, 'Matriculado'), (22, 1, 'Matriculado'), (23, 1, 'Matriculado'), (24, 1, 'Matriculado'), (25, 1, 'Matriculado'),
(26, 1, 'Matriculado'), (27, 1, 'Matriculado'), (28, 1, 'Matriculado'), (29, 1, 'Matriculado'), (30, 1, 'Matriculado'),
(31, 1, 'Matriculado'), (32, 1, 'Matriculado'), (33, 1, 'Matriculado'), (34, 1, 'Matriculado'), (35, 1, 'Matriculado'),
(36, 1, 'Matriculado'), (37, 1, 'Matriculado'), (38, 1, 'Matriculado'), (39, 1, 'Matriculado'), (40, 1, 'Matriculado'),
(41, 2, 'Matriculado'), (42, 2, 'Matriculado'), (43, 2, 'Matriculado'), (44, 2, 'Matriculado'), (45, 2, 'Matriculado'),
(46, 2, 'Matriculado'), (47, 2, 'Matriculado'), (48, 2, 'Matriculado'), (49, 2, 'Matriculado'), (50, 2, 'Matriculado'),
(51, 2, 'Matriculado'), (52, 2, 'Matriculado'), (53, 2, 'Matriculado'), (54, 2, 'Matriculado'), (55, 2, 'Matriculado'),
(56, 2, 'Matriculado'), (57, 2, 'Matriculado'), (58, 2, 'Matriculado'), (59, 2, 'Matriculado'), (60, 2, 'Matriculado');

-- ALOCAÇÃO DOS MEMBROS NAS EQUIPES (10 por grupo - Multi-row)

INSERT INTO membro_equipe (id_aluno, id_equipe, funcao) VALUES 
-- Equipe 401
(11, 401, 'Backend'), (12, 401, 'Frontend'), (13, 401, 'Scrum Master'), (14, 401, 'Developer'), (15, 401, 'Developer'),
(16, 401, 'Developer'), (17, 401, 'QA'), (18, 401, 'Developer'), (19, 401, 'Developer'), (20, 401, 'Product Owner'),
-- Equipe 402
(21, 402, 'Backend'), (22, 402, 'Frontend'), (23, 402, 'Scrum Master'), (24, 402, 'Developer'), (25, 402, 'Developer'),
(26, 402, 'Developer'), (27, 402, 'QA'), (28, 402, 'Developer'), (29, 402, 'Developer'), (30, 402, 'Product Owner'),
-- Equipe 403
(31, 403, 'Backend'), (32, 403, 'Frontend'), (33, 403, 'Scrum Master'), (34, 403, 'Developer'), (35, 403, 'Developer'),
(36, 403, 'Developer'), (37, 403, 'QA'), (38, 403, 'Developer'), (39, 403, 'Developer'), (40, 403, 'Product Owner'),
-- Equipe 404
(41, 404, 'Backend'), (42, 404, 'Frontend'), (43, 404, 'Scrum Master'), (44, 404, 'Developer'), (45, 404, 'Developer'),
(46, 404, 'Developer'), (47, 404, 'QA'), (48, 404, 'Developer'), (49, 404, 'Developer'), (50, 404, 'Product Owner'),
-- Equipe 405
(51, 405, 'Backend'), (52, 405, 'Frontend'), (53, 405, 'Scrum Master'), (54, 405, 'Developer'), (55, 405, 'Developer'),
(56, 405, 'Developer'), (57, 405, 'QA'), (58, 405, 'Developer'), (59, 405, 'Developer'), (60, 405, 'Product Owner');

-- Cadastrando 2 Sprints para cada um dos 5 projetos existentes
INSERT INTO sprint (id, numero, data_fim, id_projeto, id_equipe) VALUES 
(1, 1, '2026-03-15', 501, 401),
(2, 2, '2026-03-30', 501, 401),
(3, 1, '2026-03-15', 502, 402),
(4, 2, '2026-03-30', 502, 402),
(5, 1, '2026-03-15', 503, 403),
(6, 2, '2026-03-30', 503, 403),
(7, 1, '2026-03-15', 504, 404),
(8, 2, '2026-03-30', 504, 404),
(9, 1, '2026-03-15', 505, 405),
(10, 2, '2026-03-30', 505, 405);

-- ===============================================================
-- 5. AS ENTREGAS (Corrigido para 3FN)
-- ID, Titulo, status (default), id_sprint, id_equipe
-- ===============================================================
INSERT INTO entrega (id, titulo, id_sprint, id_equipe) VALUES 
(10, 'Documento de Requisitos e Escopo', 1, 401),
(11, 'Modelagem Relacional (DER) e DDL', 2, 401),
(12, 'Protótipo de Telas de Login e Menu', 3, 402),
(13, 'Arquitetura de Microsserviços base', 5, 403),
(14, 'Mapeamento de APIs de Pagamento', 7, 404);

-- ===============================================================
-- 6. AS VERSÕES (Corrigido para 3FN)
-- ID, Link, Data_submissao, id_entrega
-- ===============================================================
INSERT INTO versao (id, link_repositorio, data_submissao, id_entrega) VALUES 
(1001, 'https://github.com/upe/massa-puba-requisitos', '2026-03-14', 10),
(1002, 'https://github.com/upe/massa-puba-der-sql', '2026-03-29', 11),
(1003, 'https://github.com/upe/plataforma-wireframes', '2026-03-15', 12),
(1004, 'https://github.com/upe/monitoria-core-infra', '2026-03-13', 13),
(1005, 'https://github.com/upe/ecommerce-vendas-api', '2026-03-14', 14);

-- ===============================================================
-- 7. OS FEEDBACKS (Corrigido para 3FN)
-- ID, Descricao, Nota (default), id_professor, id_versao
-- ===============================================================
INSERT INTO feedback (id, descricao, nota, id_professor, id_versao) VALUES 
(50, 'Escopo bem definido, mas a restrição de unicidade do e-commerce precisa ser regra.', 8.5, 1, 1001),
(51, 'Excelente modelagem física de dados. Scripts DDL limpos e organizados.', 9.5, 1, 1002),
(52, 'Falta incluir o fluxo de recuperação de senha no protótipo de telas.', 7.0, 2, 1003),
(53, 'Configuração do Docker Compose está excelente. Infraestrutura validada.', 10.0, 3, 1004);

-- ===============================================================
-- 8. OS CRITÉRIOS DE ACEITAÇÃO (Corrigido para 3FN)
-- ID, Descricao, Peso, id_feedback
-- ===============================================================
INSERT INTO criterio_aceitacao (id, descricao, peso, id_feedback) VALUES 
(1, 'Garantir validação de e-mails corporativos únicos', 2.0, 50),
(2, 'Adicionar índices nas chaves estrangeiras mais consultadas', 3.0, 51),
(3, 'Criar tela de fluxo alternativo para esqueci minha senha', 1.5, 52),
(4, 'Otimizar o tamanho da imagem base do microsserviço no Dockerfile', 2.5, 53);

-- ===============================================================
-- AS TECNOLOGIAS AO PROJETO 
-- ===============================================================
INSERT INTO projeto_tecnologia (id_projeto, id_tecnologia, categoria, versao) VALUES 
(501, 1, 'Banco de Dados', 'PostgreSQL 18'),
(501, 2, 'Backend Framework', 'Spring Boot 3.2'),
(502, 3, 'Backend Framework', 'Django 5.0'),
(502, 5, 'Linguagem Frontend', 'TypeScript 5.0'),
(503, 2, 'Backend Language', 'Java 21'),
(503, 6, 'Containerização', 'Docker v25'),
(504, 7, 'Infraestrutura Cloud', 'AWS'), 
(504, 8, 'Backend Framework', 'NestJS v10'),
(505, 9, 'Linguagem Core', 'Haskell GHC 9.4'), 
(505, 10, 'Frontend Framework', 'Vue.js 3.0'); 
