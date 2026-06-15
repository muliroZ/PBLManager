#!/bin/sh

set -e

echo "=+> Building application setup w/ docker-compose.yml..."
docker compose up -d --build

echo "=+> Populating database w/ init_db.py..."
uv sync
export POSTGRES_HOST=localhost
uv run python init_db.py
unset -v POSTGRES_HOST

echo "=+> Setup build finished!"