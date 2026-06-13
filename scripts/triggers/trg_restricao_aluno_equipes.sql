CREATE OR REPLACE FUNCTION trg_fnc_impedir_multiplas_equipes()
RETURNS TRIGGER AS $$
DECLARE
    v_id_turma INT;
    v_ja_esta_em_equipe BOOLEAN;
BEGIN
    SELECT id_turma INTO v_id_turma
    FROM equipe
    WHERE id = NEW.id_equipe;

    SELECT EXISTS(
        SELECT 1
        FROM membro_equipe me
        INNER JOIN equipe e
            ON e.id = me.id_equipe
        WHERE me.id_aluno = NEW.id_aluno
          AND e.id_turma = v_id_turma
          AND (TG_OP = 'INSERT' OR me.id_equipe <> NEW.id_equipe)
    ) INTO v_ja_esta_em_equipe;

    IF v_ja_esta_em_equipe THEN
        RAISE EXCEPTION 'O aluno (ID %) já está alocado em uma equipe na Turma (ID %)!',
            NEW.id_aluno, v_id_turma;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_aluno_turma_unica
BEFORE INSERT OR UPDATE ON membro_equipe
FOR EACH ROW
EXECUTE FUNCTION trg_fnc_impedir_multiplas_equipes();