CREATE OR REPLACE VIEW vw_visao_geral_equipes AS
SELECT 
    e.id AS codigo_equipe,
    u.nome_completo AS nome_aluno,
    me.funcao AS papel_aluno,
    p.nome AS nome_do_projeto,
    ep.id_projeto AS codigo_projeto
FROM equipe e
INNER JOIN membro_equipe me ON e.id = me.id_equipe
INNER JOIN aluno a ON me.id_aluno = a.id
INNER JOIN usuario u ON a.id = u.id
LEFT JOIN equipe_projeto ep ON e.id = ep.id_equipe
LEFT JOIN projeto p ON ep.id_projeto = p.id;