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
