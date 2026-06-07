CREATE OR REPLACE FUNCTION trg_fnc_verificar_matricula()
RETURNS TRIGGER AS $$
DECLARE
    v_id_turma_equipe INT;
    v_esta_matriculado BOOLEAN;
BEGIN
    SELECT id_turma INTO v_id_turma_equipe
    FROM equipe
    WHERE id = NEW.id_equipe;

    SELECT EXISTS(
        SELECT 1
        FROM aluno_turma
        WHERE id_aluno = NEW.id_aluno
          AND id_turma = v_id_turma_equipe
          AND status = 'Matriculado'
    ) INTO v_esta_matriculado;

    IF NOT v_esta_matriculado THEN
        RAISE EXCEPTION 'O aluno (ID %) não possui matrícula ativa na mesma Turma (ID %) desta equipe!',
            NEW.id_aluno, v_id_turma_equipe;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_aluno_matriculado_na_turma
BEFORE INSERT OR UPDATE ON membro_equipe
FOR EACH ROW
EXECUTE FUNCTION trg_fnc_verificar_matricula();