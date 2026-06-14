CREATE OR REPLACE PROCEDURE reprovar_por_falta_evasao (
    p_id_turma INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE aluno_turma
    SET status = 'Reprovado'
    WHERE id_turma = p_id_turma
        AND id_aluno NOT IN (
            SELECT id_aluno
            FROM membro_equipe
        );

    RAISE NOTICE 'Processamento concluído para turma %. Alunos sem equipe foram reprovados.', p_id_turma;
END;
$$;