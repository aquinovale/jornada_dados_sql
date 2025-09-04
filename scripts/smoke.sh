#!/usr/bin/env bash
set -euo pipefail

echo "[*] Testando conexão..."
docker exec -i postgres_liga_sudoers_sql bash -lc \
"psql -U \$POSTGRES_USER -d \$POSTGRES_DB -h localhost -v ON_ERROR_STOP=1 -c 'select 1' >/dev/null"
echo "[OK] Conectou no Postgres"

echo "[*] Verificando se existem tabelas (excluindo system schemas)..."
HAS_TABLES=$(docker exec -i postgres_liga_sudoers_sql bash -lc \
"psql -U \$POSTGRES_USER -d \$POSTGRES_DB -h localhost -t -A -c \"
  select count(*) 
  from information_schema.tables 
  where table_schema not in ('pg_catalog','information_schema');
\"")

if [[ \"${HAS_TABLES}\" -gt 0 ]]; then
  echo "[OK] Encontrei ${HAS_TABLES} tabela(s) (DDL aplicado)"
  echo "[*] Amostra de até 1 tabela e 3 linhas:"
  docker exec -i postgres_liga_sudoers_sql bash -lc "
    psql -U \$POSTGRES_USER -d \$POSTGRES_DB -h localhost -t -A -c \"
      with t as (
        select table_schema, table_name,
               row_number() over() as rn
        from information_schema.tables
        where table_schema not in ('pg_catalog','information_schema')
        order by table_schema, table_name
      )
      select 'select * from '||quote_ident(table_schema)||'.'||quote_ident(table_name)||' limit 3;' 
      from t where rn = 1;\"
  " | while read -r q; do
        echo \"==> $q\"
        docker exec -i postgres_liga_sudoers_sql bash -lc "psql -U \$POSTGRES_USER -d \$POSTGRES_DB -h localhost -c \"$q\""
      done
else
  echo "[!] Não encontrei tabelas. Se era para ter seed, rode: docker compose down -v && docker compose up -d --build"
  exit 1
fi

echo "Smoke OK"
