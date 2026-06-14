import os
from pathlib import Path
import psycopg2
from dotenv import load_dotenv

load_dotenv()

EXECUTION_ORDER = [
    "scripts/criacao",
    "scripts/functions",
    "scripts/triggers",
    "scripts/procedures",
    "scripts/views",
    "scripts/seeds",
]

def execute_sql_file(cursor, file_path):
    try:
        with open(file_path, encoding="utf-8") as f:
            sql_content = f.read()
            if sql_content.strip():
                cursor.execute(sql_content)
    except Exception as e:
        raise e

def main():
    db_user = os.getenv("POSTGRES_USER", "postgres")
    db_password = os.getenv("POSTGRES_PASSWORD", "postgres")
    db_name = os.getenv("POSTGRES_DB", "pblmanagerdb")
    db_host = os.getenv("POSTGRES_HOST", "localhost")
    db_port = os.getenv("POSTGRES_PORT", "5432")

    base_dir = Path(__file__).parent

    try:
        conn = psycopg2.connect(
            dbname=db_name,
            user=db_user,
            password=db_password,
            host=db_host,
            port=db_port
        )
        cursor = conn.cursor()

        processed_files = set()

        for folder_subpath in EXECUTION_ORDER:
            target_folder = base_dir / folder_subpath

            if not target_folder.exists():
                continue

            sql_files = sorted([f for f in target_folder.glob("*.sql") if f.is_file()])

            for file_path in sql_files:
                if file_path in processed_files:
                    continue

                execute_sql_file(cursor, file_path)
                processed_files.add(file_path)

        conn.commit()

    except Exception as e:
        print("erro: ", e)
        if 'conn' in locals() and conn:
            conn.rollback()
    
    finally:
        if 'cursor' in locals() and cursor:
            cursor.close()

        if 'conn' in locals() and conn:
            conn.close()

if __name__ == "__main__":
    main()
