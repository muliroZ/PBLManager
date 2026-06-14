 -- Obtem nota media de uma equuipe em um projeto
CREATE OR REPLACE FUNCTION calcular_media_equipe(codigo_equipe INT, codigo_projeto INT)
RETURNS DECIMAL AS $$
DECLARE
    nota_media DECIMAL;
BEGIN
    SELECT AVG(f.nota) INTO nota_media
    FROM feedback f
    INNER JOIN versao v ON f.id_versao = v.id
    INNER JOIN entrega e ON v.id_entrega = e.id
    INNER JOIN sprint s ON e.id_sprint = s.id
    WHERE e.id_equipe = codigo_equipe 
      AND s.id_projeto = codigo_projeto;

    RETURN COALESCE(nota_media, 0.0);
END;
$$ LANGUAGE plpgsql;