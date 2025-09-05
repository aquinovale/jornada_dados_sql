#!/usr/bin/env bash
set -Eeuo pipefail

# Nome do container (mude aqui se usar outro)
CONTAINER_NAME="${CONTAINER_NAME:-postgres_liga_sudoers_sql}"

# Variáveis padrão caso .env não esteja carregado no shell
PGUSER="${POSTGRES_USER:-sudoers}"
PGDB="${POSTGRES_DB:-liga_sudoers}"

PSQL_BASE="psql -v ON_ERROR_STOP=1 -U ${PGUSER} -d ${PGDB} -h localhost -t -A -c"

echo "[*] Testando conexão..."
docker exec -i "$CONTAINER_NAME" bash -lc "$PSQL_BASE 'select 1;'" >/dev/null
echo "[OK] Conectou no Postgres"

echo "[*] Verificando se existem tabelas (excluindo system schemas)..."
HAS_TABLES=$(
  docker exec -i "$CONTAINER_NAME" bash -lc \
  "$PSQL_BASE \"
    select count(*)::int
    from information_schema.tables
    where table_schema not in ('pg_catalog','information_schema');
  \"" | tr -d '[:space:]"'  # remove espaços, quebras de linha e aspas
)

# Se por algum motivo vier vazio, força 0
HAS_TABLES="${HAS_TABLES:-0}"

if [[ $HAS_TABLES -gt 0 ]]; then
  echo "[OK] Encontrei ${HAS_TABLES} tabela(s) (DDL aplicado)"

  # Gera 1 query de amostra para mostrar dados de uma tabela qualquer do usuário
  SAMPLE_QUERY=$(
    docker exec -i "$CONTAINER_NAME" bash -lc \
    "$PSQL_BASE \"
      select 'select * from '
             || quote_ident(table_schema) || '.' || quote_ident(table_name)
             || ' limit 3;'
      from information_schema.tables
      where table_schema not in ('pg_catalog','information_schema')
      order by table_schema, table_name
      limit 1;
    \"" | tr -d '\r'
  )

  echo "==> ${SAMPLE_QUERY}"
  docker exec -i "$CONTAINER_NAME" bash -lc "$PSQL_BASE \"$SAMPLE_QUERY\""
else
  echo "[!] Não encontrei tabelas. Se era para ter seed, rode:"
  echo "    docker compose down -v && docker compose up -d --build"
  exit 1
fi

echo "Smoke OK"
