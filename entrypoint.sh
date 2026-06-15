#!/bin/sh

set -e

echo "==> Executando inicialização do Banco de Dados (init_db.py)..."
uv run python init_db.py

echo "==> Banco inicializado com sucesso! Iniciando Servidor Flask..."
exec uv run python main.py