CREATE OR REPLACE PROCEDURE matricular_aluno_turma(
    p_id_aluno INT,
    p_id_turma INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_matriculados INT;
BEGIN
   SELECT COUNT(*) INTO v_total_matriculados
    FROM aluno_turma
    WHERE id_turma = p_id_turma;

   IF v_total_matriculados >= 40 THEN
       RAISE EXCEPTION 'Não foi possível executar matrícula. A turma % já atingiu o limite de 40 alunos.', p_id_turma;

    ELSE
       INSERT INTO aluno_turma (id_aluno, id_turma, status)
       VALUES (p_id_aluno, p_id_turma, 'Matriculado');

       RAISE NOTICE 'Aluno % matriculado com sucesso na turma %.', p_id_aluno, p_id_turma;

   END IF;
END;
$$;
