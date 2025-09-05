👉 O **nível Sudoers** não é só “mais difícil”: é sobre **pensar como guardião dos dados** — explorando otimização, análise de planos de execução, modelagem criativa e segurança.

---

# Aula – Nível Sudoers 🛡️

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`, `pares`, `impares`, `datas`

---

## 🔧 Comandos mostrados (comentados)

### 1) EXPLAIN ANALYZE
Entender o plano de execução de uma query.

```sql
EXPLAIN ANALYZE
SELECT * FROM pessoas WHERE idade > 30;
-- Mostra como o PostgreSQL executa a consulta, índices usados e custo estimado.
````

---

### 2) Indexação condicional

Criar índice apenas para parte dos dados.

```sql
CREATE INDEX idx_salario_maior_2000
ON salarios(salario)
WHERE salario > 2000;
-- Índice parcial melhora performance de consultas frequentes.
```

---

### 3) CTE materializada (WITH + MATERIALIZED)

Congelar o resultado de uma subconsulta.

```sql
WITH MATERIALIZED maiores AS (
  SELECT * FROM pessoas WHERE idade > 40
)
SELECT * FROM maiores WHERE nome LIKE 'A%';
-- Evita reprocessar a subquery.
```

---

### 4) Funções definidas pelo usuário (UDF)

Criar função customizada no PostgreSQL.

```sql
CREATE OR REPLACE FUNCTION maioridade(idade int)
RETURNS text AS $$
BEGIN
  IF idade < 18 THEN
    RETURN 'Menor';
  ELSE
    RETURN 'Maior';
  END IF;
END;
$$ LANGUAGE plpgsql;

SELECT nome, maioridade(idade) FROM pessoas;
-- Encapsula lógica em função reutilizável.
```

---

### 5) Segurança com RLS (Row Level Security)

Restringir linhas por usuário.

```sql
ALTER TABLE salarios ENABLE ROW LEVEL SECURITY;

CREATE POLICY apenas_meu_id
ON salarios
FOR SELECT
USING (id = current_setting('app.user_id')::int);
-- Cada usuário só enxerga suas próprias linhas.
```

---

### 6) Consultas híbridas (JSON + SQL)

Trabalhar com dados semiestruturados.

```sql
SELECT dados->>'cpf' AS cpf, dados->>'cidade' AS cidade
FROM pessoas2;
-- Extrai campos JSON armazenados em coluna.
```

---

## 🟣 Exercícios (múltipla escolha)

### 1) Plano de execução

Como verificar o plano real de uma query?

A) `EXPLAIN SELECT ...`
B) `EXPLAIN ANALYZE SELECT ...`
C) `SHOW PLAN SELECT ...`
D) `DESCRIBE SELECT ...`

✅ **Resposta:** B

---

### 2) Índice parcial

Qual comando cria índice só para salários maiores que 3000?

A)

```sql
CREATE INDEX idx_salario
ON salarios(salario > 3000);
```

B)

```sql
CREATE INDEX idx_salario_maior_3000
ON salarios(salario)
WHERE salario > 3000;
```

C)

```sql
CREATE PARTIAL INDEX idx_salario ON salarios WHERE salario > 3000;
```

D)

```sql
INDEX salarios ON salario WHERE salario > 3000;
```

✅ **Resposta:** B

---

### 3) CTE materializada

Como garantir que uma subquery seja avaliada só uma vez?

A) `WITH IMMUTABLE ...`
B) `WITH MATERIALIZED ...`
C) `WITH FIXED ...`
D) `WITH ONCE ...`

✅ **Resposta:** B

---

### 4) Função customizada

Qual comando define corretamente uma função que retorna "Par" ou "Ímpar"?

A)

```sql
CREATE FUNCTION par_impar(n int) RETURNS text AS $$
  SELECT CASE WHEN n % 2 = 0 THEN 'Par' ELSE 'Ímpar' END;
$$ LANGUAGE sql;
```

B)

```sql
CREATE FUNCTION par_impar(n int) RETURNS text
BEGIN
  IF n % 2 = 0 RETURN 'Par'; ELSE RETURN 'Ímpar';
END;
```

C)

```sql
CREATE FUNCTION par_impar RETURNS text AS 'SELECT ...';
```

D)

```sql
CREATE PROCEDURE par_impar(n int) LANGUAGE sql;
```

✅ **Resposta:** A

---

### 5) Segurança com RLS

Qual comando ativa Row Level Security em uma tabela?

A) `GRANT RLS ON salarios;`
B) `ALTER TABLE salarios ENABLE RLS;`
C) `ALTER TABLE salarios ENABLE ROW LEVEL SECURITY;`
D) `SET RLS ON salarios;`

✅ **Resposta:** C

---

### 6) Consultas em JSON

Qual consulta extrai corretamente o campo `email` de uma coluna JSON chamada `dados`?

A) `SELECT dados.email FROM pessoas2;`
B) `SELECT dados->'email' FROM pessoas2;`
C) `SELECT dados->>'email' FROM pessoas2;`
D) `SELECT email(dados) FROM pessoas2;`

✅ **Resposta:** C

---

## 🛡️ Dicas Sudoers

* **Leia planos de execução** antes de otimizar.
* **Índices parciais** e **RLS** são armas poderosas, mas exigem cautela.
* **Funções customizadas** (SQL ou PL/pgSQL) trazem reuso e encapsulamento.
* PostgreSQL lida bem com dados híbridos (JSON + relacional).
* No nível Sudoers, não basta saber rodar queries: é preciso **garantir performance, segurança e manutenibilidade**.

---
