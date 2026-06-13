-- Busca o último link do github enviado por uma equipe
CREATE OR REPLACE FUNCTION obter_ultimo_github(codigo_equipe INT, codigo_projeto INT)
RETURNS VARCHAR AS $$
DECLARE
    link_git VARCHAR;
BEGIN
    SELECT link_repositorio INTO link_git
    FROM versao
    WHERE id_equipe = codigo_equipe 
      AND id_projeto = codigo_projeto
    ORDER BY data_submissao DESC
    LIMIT 1;

    RETURN COALESCE(link_git, 'Nenhum repositório enviado ainda.');
END;
$$ LANGUAGE plpgsql;