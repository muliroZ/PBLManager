-- funcao que retorna a quantidade alunos em uma turma 

CREATE OR REPLACE FUNCTION total_alunos_turma(codigo_turma INT)
RETURNS INT AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM aluno_turma
    WHERE id_turma = codigo_turma 
      AND status = 'Matriculado';

    RETURN total;
END;
$$ LANGUAGE plpgsql;