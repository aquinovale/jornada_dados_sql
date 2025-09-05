👉 Aqui o foco é sair dos exemplos “didáticos puros” e usar **cenários mais práticos** com `UNION`, `INTERSECT` e `EXCEPT`:

* Uso em **subqueries**
* Uso em **CTEs (WITH)**
* Diferença entre `UNION` e `UNION ALL` em tabelas grandes
* Combinações avançadas (EXCEPT dentro de UNION, INTERSECT dentro de CTE)
* Comparações entre conjuntos em colunas diferentes

---

# Aula 3 – SQL Avançado (Operadores de Conjuntos em Cenários Reais)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) UNION em subquery
Comparar nomes em subconsulta.

```sql
SELECT nome
FROM (
  SELECT nome FROM pessoas
  UNION
  SELECT nome FROM pessoas2
) todos
ORDER BY nome;
-- Cria uma tabela derivada com todos os nomes únicos.
````

---

### 2) INTERSECT em CTE

Usando CTE para organizar lógica.

```sql
WITH comuns AS (
  SELECT nome FROM pessoas
  INTERSECT
  SELECT nome FROM pessoas2
)
SELECT * FROM comuns;
-- Lista quem aparece nas duas tabelas.
```

---

### 3) EXCEPT em auditoria

Encontrar salários sem pessoa cadastrada.

```sql
SELECT id FROM salarios
EXCEPT
SELECT id FROM pessoas;
-- IDs de salários órfãos.
```

---

### 4) UNION vs UNION ALL em performance

```sql
SELECT id FROM pessoas
UNION ALL
SELECT id FROM pessoas2;
-- Mais rápido, mantém duplicados.
```

```sql
SELECT id FROM pessoas
UNION
SELECT id FROM pessoas2;
-- Mais lento, elimina duplicados.
```

---

### 5) Combinação complexa

```sql
WITH ativos AS (
  SELECT id FROM pessoas
  UNION
  SELECT id FROM pessoas2
),
sem_salario AS (
  SELECT id FROM ativos
  EXCEPT
  SELECT id FROM salarios
)
SELECT * FROM sem_salario;
-- Pessoas ativas (pessoas+pessoas2) que não possuem salário.
```

---

## 🔴 Exercícios (múltipla escolha)

### 1) Subquery com UNION

Qual consulta cria corretamente uma tabela derivada com nomes únicos de `pessoas` e `pessoas2`?

A)

```sql
SELECT nome
FROM (SELECT nome FROM pessoas UNION SELECT nome FROM pessoas2) t;
```

B)

```sql
SELECT nome FROM pessoas
UNION
SELECT nome FROM pessoas2;
```

C) Ambas A e B funcionam.
D) Nenhuma das duas.

✅ **Resposta:** C

---

### 2) INTERSECT em CTE

Qual consulta retorna corretamente nomes em comum?

A)

```sql
WITH comuns AS (
  SELECT nome FROM pessoas
  INTERSECT
  SELECT nome FROM pessoas2
)
SELECT * FROM comuns;
```

B)

```sql
WITH comuns AS (
  SELECT nome FROM pessoas
  UNION
  SELECT nome FROM pessoas2
)
SELECT * FROM comuns;
```

C)

```sql
SELECT * FROM pessoas NATURAL JOIN pessoas2;
```

D)

```sql
SELECT * FROM pessoas FULL JOIN pessoas2;
```

✅ **Resposta:** A

---

### 3) Auditoria com EXCEPT

Queremos IDs que estão em `salarios` mas não em `pessoas`. Qual consulta é correta?

A)

```sql
SELECT id FROM salarios
EXCEPT
SELECT id FROM pessoas;
```

B)

```sql
SELECT id FROM pessoas
EXCEPT
SELECT id FROM salarios;
```

C)

```sql
SELECT id FROM salarios
INTERSECT
SELECT id FROM pessoas;
```

D)

```sql
SELECT id FROM salarios
WHERE id NOT IN (SELECT id FROM pessoas);
```

✅ **Resposta:** A
(D também é válida, mas o exercício pede uso do EXCEPT.)

---

### 4) Performance UNION vs UNION ALL

Qual é mais rápido em tabelas grandes?

A) `UNION` porque elimina duplicados.
B) `UNION ALL` porque não precisa eliminar duplicados.
C) Ambos têm a mesma performance.
D) Depende da ordem dos SELECTs.

✅ **Resposta:** B

---

### 5) Combinação avançada

Qual consulta lista pessoas (pessoas+pessoas2) que não têm salário?

A)

```sql
WITH ativos AS (
  SELECT id FROM pessoas
  UNION
  SELECT id FROM pessoas2
),
sem_salario AS (
  SELECT id FROM ativos
  EXCEPT
  SELECT id FROM salarios
)
SELECT * FROM sem_salario;
```

B)

```sql
SELECT id FROM pessoas
EXCEPT
SELECT id FROM salarios;
```

C)

```sql
SELECT id FROM pessoas2
EXCEPT
SELECT id FROM salarios;
```

D)

```sql
SELECT id FROM pessoas, pessoas2
WHERE id NOT IN (SELECT id FROM salarios);
```

✅ **Resposta:** A

---

## 💡 Dicas

* Use subqueries ou CTEs para deixar a lógica clara.
* Prefira `UNION ALL` quando não precisar eliminar duplicados (ganho de performance).
* `EXCEPT` é ótimo para auditorias e consistência de dados.
* Sempre verifique a ordem de precedência: `INTERSECT` roda antes de `UNION`.

---
