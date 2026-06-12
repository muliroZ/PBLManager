CREATE OR REPLACE VIEW vw_visao_geral_equipes AS
SELECT 
    e.id AS codigo_equipe,
    u.nome_completo AS nome_aluno,
    me.funcao AS papel_aluno,
    p.nome AS nome_do_projeto
FROM equipe e
INNER JOIN membro_equipe me ON e.id = me.id_equipe
INNER JOIN aluno a ON me.id_aluno = a.id
INNER JOIN usuario u ON a.id = u.id
LEFT JOIN equipe_projeto ep ON e.id = ep.id_equipe
LEFT JOIN projeto p ON ep.id_projeto = p.id;

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
LEFT JOIN entrega ent ON ent.id_equipe = e.id AND ent.id_projeto = p.id AND ent.id_sprint = s.id
LEFT JOIN versao v ON v.id_equipe = e.id AND v.id_projeto = p.id AND v.id_sprint = s.id AND v.id_entrega = ent.id;

CREATE OR REPLACE VIEW vw_feedbacks_e_criterios AS
SELECT 
    f.id_equipe AS codigo_equipe,
    p.nome AS nome_projeto,
    f.id_sprint AS numero_sprint,
    u_prof.nome_completo AS professor_avaliador,
    f.descricao AS feedback_geral,
    ca.descricao AS criterio_avaliado,
    ca.peso AS peso_criterio
FROM feedback f
INNER JOIN projeto p ON f.id_projeto = p.id
INNER JOIN usuario u_prof ON f.id_professor = u_prof.id
INNER JOIN criterio_aceitacao ca ON ca.id_feedback = f.id;
