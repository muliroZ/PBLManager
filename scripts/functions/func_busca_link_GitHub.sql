-- Busca o último link do github enviado por uma equipe
CREATE OR REPLACE FUNCTION obter_ultimo_github(codigo_equipe INT, codigo_projeto INT)
RETURNS VARCHAR AS $$
DECLARE
    link_git VARCHAR;
BEGIN
    SELECT v.link_repositorio INTO link_git
    FROM versao v
    INNER JOIN entrega e ON v.id_entrega = e.id
    INNER JOIN sprint s ON e.id_sprint = s.id
    WHERE e.id_equipe = codigo_equipe 
      AND s.id_projeto = codigo_projeto
    ORDER BY v.data_submissao DESC
    LIMIT 1;

    RETURN COALESCE(link_git, 'Nenhum repositório enviado ainda.');
END;
$$ LANGUAGE plpgsql;