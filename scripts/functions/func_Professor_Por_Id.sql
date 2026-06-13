
-- Busca o Nome do Professor pelo ID
CREATE OR REPLACE FUNCTION obter_nome_professor(codigo_professor INT)
RETURNS VARCHAR AS $$
DECLARE
    nome_prof VARCHAR;
BEGIN
    SELECT nome_completo INTO nome_prof
    FROM usuario
    WHERE id = codigo_professor;

    RETURN COALESCE(nome_prof, 'Professor não encontrado');
END;
$$ LANGUAGE plpgsql;