 -- Obtem nota media de uma equuipe em um projeto
CREATE OR REPLACE FUNCTION calcular_media_equipe(codigo_equipe INT, codigo_projeto INT)
RETURNS DECIMAL AS $$
DECLARE
    nota_media DECIMAL;
BEGIN
    SELECT AVG(nota) INTO nota_media
    FROM feedback
    WHERE id_equipe = codigo_equipe 
      AND id_projeto = codigo_projeto;

    
    RETURN COALESCE(nota_media, 0.0);
END;
$$ LANGUAGE plpgsql;