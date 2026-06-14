CREATE OR REPLACE VIEW vw_acompanhamento_sprints AS
SELECT 
    e.id AS codigo_equipe,
    p.nome AS nome_projeto,
    s.numero AS numero_sprint,
    s.data_fim AS prazo_sprint,
    ent.titulo AS titulo_entrega,
    v.link_repositorio,
    v.data_submissao
FROM equipe e
INNER JOIN equipe_projeto ep ON e.id = ep.id_equipe
INNER JOIN projeto p ON ep.id_projeto = p.id
INNER JOIN sprint s ON s.id_projeto = p.id AND s.id_equipe = e.id
LEFT JOIN entrega ent ON ent.id_equipe = e.id AND ent.id_sprint = s.id
LEFT JOIN versao v ON v.id_entrega = ent.id;