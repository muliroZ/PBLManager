CREATE OR REPLACE FUNCTION trg_fnc_analisar_feedback()
RETURNS TRIGGER AS $$
DECLARE
    v_nota DECIMAL;
BEGIN
    SELECT nota INTO v_nota
    FROM feedback
    WHERE id = NEW.id;

    IF v_nota >= 8.0 THEN
        UPDATE entrega
        SET status = 'Aprovado'
        WHERE id = NEW.id_entrega;
    end if;

    IF v_nota >= 4.0 AND v_nota < 8.0 THEN
        UPDATE entrega
        SET status = 'Necessita de ajustes'
        WHERE id = NEW.id_entrega;
    END IF;

    IF v_nota < 4.0 THEN
        UPDATE entrega
        SET status = 'Reprovado'
        WHERE id = NEW.id_entrega;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_mudar_status_entrega
AFTER INSERT OR UPDATE ON feedback
FOR EACH ROW
EXECUTE FUNCTION trg_fnc_analisar_feedback();