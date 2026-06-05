
-- Lista todos os alunos com seus dados básicos
SELECT 
    a.id AS matricula,
    u.nome_completo AS nome_aluno,
    u.email AS email_institucional
FROM aluno a
INNER JOIN usuario u ON a.id = u.id
ORDER BY u.nome_completo;

-- lista alunos e suas respectivas Equipes e Funções
SELECT 
    u.nome_completo AS aluno,
    me.funcao AS papel_na_equipe,
    e.id AS numero_da_equipe
FROM usuario u
INNER JOIN aluno a ON u.id = a.id
INNER JOIN membro_equipe me ON a.id = me.id_aluno
INNER JOIN equipe e ON me.id_equipe = e.id
ORDER BY e.id, u.nome_completo;

-- lista quais Projetos e Tecnologiuas cada equipe está usando
SELECT 
    e.id AS codigo_equipe,
    p.nome AS nome_do_projeto,
    t.nome AS tecnologia_utilizada,
    pt.categoria AS camada_da_stack
FROM equipe e
INNER JOIN equipe_projeto ep ON e.id = ep.id_equipe
INNER JOIN projeto p ON ep.id_projeto = p.id
INNER JOIN projeto_tecnologia pt ON p.id = pt.id_projeto
INNER JOIN tecnologia t ON pt.id_tecnologia = t.id
ORDER BY e.id;