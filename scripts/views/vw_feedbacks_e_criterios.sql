CREATE OR REPLACE VIEW vw_feedbacks_e_criterios AS
SELECT 
    ent.id_equipe AS codigo_equipe,
    p.nome AS nome_projeto,
    s.numero AS numero_sprint,
    u_prof.nome_completo AS professor_avaliador,
    f.descricao AS feedback_geral,
    ca.descricao AS criterio_avaliado,
    ca.peso AS peso_criterio
FROM feedback f
INNER JOIN versao v ON f.id_versao = v.id
INNER JOIN entrega ent ON v.id_entrega = ent.id
INNER JOIN sprint s ON ent.id_sprint = s.id
INNER JOIN projeto p ON s.id_projeto = p.id
INNER JOIN usuario u_prof ON f.id_professor = u_prof.id
INNER JOIN criterio_aceitacao ca ON ca.id_feedback = f.id;