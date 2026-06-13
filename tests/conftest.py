import os
import pytest
import psycopg2
from testcontainers.postgres import PostgresContainer

@pytest.fixture(scope="session")
def postgres_container():
    with PostgresContainer("postgres:17-alpine") as postgres:
        yield postgres

@pytest.fixture(scope="session")
def db_connection(postgres_container):
    """
    Estabelece a ligação única com o container e aplica o DDL inicial (criar_tabelas.sql).
    """
    conn = psycopg2.connect(
        dbname=postgres_container.POSTGRES_DB,
        user=postgres_container.POSTGRES_USER,
        password=postgres_container.POSTGRES_PASSWORD,
        host=postgres_container.get_container_host_ip(),
        port=postgres_container.get_exposed_port(5432)
    )
    
    script_path = os.path.join("scripts", "criacao", "criar_tabelas.sql")
    
    if os.path.exists(script_path):
        with open(script_path, "r", encoding="utf-8") as f:
            ddl_script = f.read()
        
        with conn.cursor() as cursor:
            cursor.execute(ddl_script)
        conn.commit()
    else:
        raise FileNotFoundError(f"Script de criação de tabelas não encontrado em: {script_path}")
        
    yield conn
    
    conn.close()

@pytest.fixture(scope="function")
def db_session(db_connection):
    """
    Fornece um cursor isolado para cada função de teste.
    Garante o rollback automático ao final do teste, limpando o estado do banco.
    """
    cursor = db_connection.cursor()
    
    yield cursor
    
    db_connection.rollback()
    cursor.close()
