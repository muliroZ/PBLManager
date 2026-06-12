-- conta quantas Sprints tem em um projeto 
CREATE OR REPLACE FUNCTION total_sprints_projeto(codigo_projeto INT)
RETURNS INT AS $$
DECLARE
    qtd_sprints INT;
BEGIN
    SELECT COUNT(*) INTO qtd_sprints
    FROM sprint
    WHERE id_projeto = codigo_projeto;

    RETURN qtd_sprints;
END;
$$ LANGUAGE plpgsql;