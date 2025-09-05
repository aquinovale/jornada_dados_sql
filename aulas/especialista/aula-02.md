👉 Aqui a ideia é mostrar recursos que **vão além dos JOINs tradicionais** e exigem entendimento mais profundo do PostgreSQL:

* **LATERAL JOIN (APPLY)** para consultas dependentes.
* **CTEs com múltiplos JOINs**.
* **ANTI JOIN (usando LEFT JOIN + IS NULL)** para identificar ausências.
* **SEMI JOIN (usando EXISTS)** para verificar existência sem duplicar.
* **JOIN com funções de tabela**.
* Discussão breve de **performance (EXPLAIN, índices e reescrita de JOINs)**.

---

# Aula 2 – SQL Especialista (JOINs Avançados e LATERAL)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) LATERAL JOIN (dependente da linha anterior)
Permite usar valores da tabela da esquerda dentro da subquery da direita.

```sql
SELECT p.nome, n.media
FROM pessoas p
JOIN LATERAL (
    SELECT (nota1 + nota2)/2 AS media
    FROM notas n
    WHERE n.id = p.id
) n ON true;
-- Para cada pessoa, calcula a média de suas notas.
````

---

### 2) CTE com múltiplos JOINs

Organizar consultas complexas em blocos.

```sql
WITH base AS (
  SELECT p.id, p.nome, s.salario, p2.endereco
  FROM pessoas p
  LEFT JOIN salarios s ON p.id = s.id
  LEFT JOIN pessoas2 p2 ON p.id = p2.id
)
SELECT * FROM base WHERE salario > 3000;
-- CTE torna a query mais legível e reaproveitável.
```

---

### 3) ANTI JOIN (quem não tem correspondência)

Encontrar pessoas sem salário.

```sql
SELECT p.nome
FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id
WHERE s.id IS NULL;
-- Pessoas sem salário.
```

---

### 4) SEMI JOIN (existência)

Verificar quem tem salário, mas sem repetir linhas.

```sql
SELECT p.nome
FROM pessoas p
WHERE EXISTS (
  SELECT 1 FROM salarios s WHERE s.id = p.id
);
-- Apenas pessoas que têm salário, sem duplicação.
```

---

### 5) JOIN com função de tabela

Exemplo usando `generate_series` como tabela.

```sql
SELECT p.nome, g.n
FROM pessoas p
JOIN generate_series(1,3) g(n) ON true;
-- Combina cada pessoa com os números 1 a 3.
```

---

### 6) Performance: EXPLAIN em JOIN

Verificando custo de um JOIN.

```sql
EXPLAIN ANALYZE
SELECT p.nome, s.salario
FROM pessoas p
INNER JOIN salarios s ON p.id = s.id;
-- Sempre analise planos em JOINs pesados.
```

---

## ⚫ Exercícios (múltipla escolha)

### 1) LATERAL JOIN

Qual consulta calcula corretamente a média de notas de cada pessoa?

A)

```sql
SELECT p.nome, n.media
FROM pessoas p
JOIN LATERAL (
  SELECT (nota1+nota2)/2 AS media
  FROM notas n WHERE n.id = p.id
) n ON true;
```

B)

```sql
SELECT p.nome, AVG(nota1+nota2)/2
FROM pessoas p, notas n;
```

C)

```sql
SELECT p.nome, media FROM pessoas NATURAL JOIN notas;
```

D)

```sql
SELECT p.nome, (nota1+nota2)/2 FROM pessoas;
```

✅ **Resposta:** A

---

### 2) ANTI JOIN

Como listar apenas pessoas sem salário?

A)

```sql
SELECT p.nome FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id
WHERE s.id IS NULL;
```

B)

```sql
SELECT p.nome FROM pessoas p
INNER JOIN salarios s ON p.id <> s.id;
```

C)

```sql
SELECT p.nome FROM pessoas p
WHERE NOT EXISTS (SELECT 1 FROM salarios);
```

D)

```sql
SELECT p.nome FROM pessoas p FULL JOIN salarios s;
```

✅ **Resposta:** A

---

### 3) SEMI JOIN

Como garantir que só apareçam pessoas com salário (sem duplicar)?

A)

```sql
SELECT p.nome FROM pessoas p
WHERE EXISTS (SELECT 1 FROM salarios s WHERE s.id = p.id);
```

B)

```sql
SELECT DISTINCT p.nome FROM pessoas p
JOIN salarios s ON p.id = s.id;
```

C)

```sql
SELECT p.nome FROM pessoas p
FULL JOIN salarios s ON p.id = s.id;
```

D)

```sql
SELECT p.nome FROM pessoas;
```

✅ **Resposta:** A
(B também funciona, mas é menos eficiente em tabelas grandes.)

---

### 4) JOIN com função de tabela

Qual consulta combina cada pessoa com os números de 1 a 5?

A)

```sql
SELECT p.nome, g.n
FROM pessoas p
JOIN generate_series(1,5) g(n) ON true;
```

B)

```sql
SELECT p.nome, series.n
FROM pessoas p
JOIN (1 TO 5) series;
```

C)

```sql
SELECT p.nome, n FROM pessoas p CROSS JOIN (1,2,3,4,5);
```

D)

```sql
SELECT p.nome, n FROM pessoas p NATURAL JOIN generate_series(1,5);
```

✅ **Resposta:** A

---

### 5) Performance

Qual comando mostra o **plano de execução real** de um JOIN?

A) `DESCRIBE SELECT ...`
B) `SHOW PLAN SELECT ...`
C) `EXPLAIN ANALYZE SELECT ...`
D) `PLAN JOIN SELECT ...`

✅ **Resposta:** C

---

## 💡 Dicas finais

* **LATERAL JOIN** é a arma secreta para consultas linha-a-linha.
* Use **ANTI JOIN** (`LEFT JOIN ... WHERE IS NULL`) para encontrar ausentes.
* Prefira **EXISTS (SEMI JOIN)** quando só precisa saber se algo existe.
* **Funções de tabela** (`generate_series`, `unnest`) são poderosas aliadas.
* Sempre analise **EXPLAIN ANALYZE** em joins complexos para entender custo.
