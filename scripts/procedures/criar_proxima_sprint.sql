CREATE OR REPLACE PROCEDURE criar_proxima_sprint (
    p_id_projeto INT,
    p_id_equipe INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_ultimo_numero INT;
    v_ultima_data DATE;
    v_novo_numero INT;
    v_nova_data DATE;

BEGIN
    SELECT MAX(sprint.numero), MAX(sprint.data_fim)
    INTO v_ultimo_numero, v_ultima_data
    FROM sprint
    WHERE id_projeto = p_id_projeto AND id_equipe = p_id_equipe;

    IF v_ultimo_numero IS NULL THEN
        v_ultimo_numero := v_novo_numero + 1;
        v_nova_data := v_ultima_data +INTERVAL '15 days';
    END IF;

    INSERT INTO sprint(id, numero, data_fim, id_projeto, id_equipe)
    VALUES (
            (SELECT COALESCE(MAX(id), 0) + 1 FROM sprint),
            v_novo_numero,
            v_nova_data,
            p_id_projeto,
            p_id_equipe
           );

    RAISE NOTICE 'Sprint % criada com sucesso para o Projeto %. Data de término: %', v_novo_numero, p_id_projeto, v_nova_data;
END;
$$;