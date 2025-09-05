Boa 👌 agora vamos montar a **Aula 5 – Nível Especialista**, ainda sobre **WHERE e ORDER BY**, mas explorando cenários em que esses comandos aparecem combinados com recursos mais avançados do PostgreSQL.

👉 Aqui entram:

* **Window Functions com ORDER BY** (`ROW_NUMBER`, `RANK`, `DENSE_RANK`)
* **Filtros com subqueries correlacionadas em WHERE**
* **Uso de FILTER em agregações**
* **ORDER BY em CTEs e subqueries**
* **Cláusulas avançadas com DISTINCT ON + ORDER BY**

---

# Aula 5 – SQL Especialista (WHERE e ORDER BY em Cenários Avançados)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Window Functions com ORDER BY
```sql
SELECT nome, salario,
       ROW_NUMBER() OVER (ORDER BY salario DESC) AS posicao
FROM salarios;
-- Numera cada linha conforme o salário (ranking).
````

```sql
SELECT nome, salario,
       RANK() OVER (ORDER BY salario DESC) AS ranking,
       DENSE_RANK() OVER (ORDER BY salario DESC) AS ranking_denso
FROM salarios;
-- RANK deixa "buracos" em empates, DENSE_RANK não.
```

---

### 2) Subquery correlacionada no WHERE

```sql
SELECT nome, idade
FROM pessoas p
WHERE idade > (
  SELECT AVG(idade) FROM pessoas WHERE cidade = p.cidade
);
-- Pessoas mais velhas que a média da sua própria cidade.
```

---

### 3) Uso de FILTER em agregações

```sql
SELECT 
  COUNT(*) FILTER (WHERE idade < 18) AS menores,
  COUNT(*) FILTER (WHERE idade >= 18) AS adultos
FROM pessoas;
-- Conta por categorias usando filtros no agregador.
```

---

### 4) ORDER BY em CTE

```sql
WITH top_salarios AS (
  SELECT nome, salario
  FROM salarios
  ORDER BY salario DESC
  LIMIT 5
)
SELECT * FROM top_salarios;
-- Define um ranking dentro da CTE.
```

---

### 5) DISTINCT ON + ORDER BY

```sql
SELECT DISTINCT ON (cidade) nome, idade, cidade
FROM pessoas
ORDER BY cidade, idade DESC;
-- Retorna apenas 1 pessoa por cidade (a mais velha).
```

---

## ⚫ Exercícios (múltipla escolha)

### 1) Window Functions

Qual consulta gera um ranking contínuo (sem buracos em empates)?

A) `ROW_NUMBER() OVER (ORDER BY salario DESC)`
B) `RANK() OVER (ORDER BY salario DESC)`
C) `DENSE_RANK() OVER (ORDER BY salario DESC)`
D) `NTILE(2) OVER (ORDER BY salario DESC)`

✅ **Resposta:** C

---

### 2) Subquery correlacionada

Queremos pessoas com idade acima da média de sua própria cidade. Qual consulta é correta?

A)

```sql
SELECT nome, idade FROM pessoas p
WHERE idade > (SELECT AVG(idade) FROM pessoas);
```

B)

```sql
SELECT nome, idade FROM pessoas p
WHERE idade > (SELECT AVG(idade) FROM pessoas WHERE cidade = p.cidade);
```

C)

```sql
SELECT nome, idade FROM pessoas WHERE idade > ALL(SELECT AVG(idade) FROM pessoas);
```

D)

```sql
SELECT nome, idade FROM pessoas p
WHERE EXISTS (SELECT AVG(idade) FROM pessoas WHERE cidade = p.cidade);
```

✅ **Resposta:** B

---

### 3) FILTER

Qual consulta conta apenas adultos (>=18 anos)?

A)

```sql
SELECT COUNT(*) FILTER (WHERE idade >= 18) FROM pessoas;
```

B)

```sql
SELECT COUNT(idade >= 18) FROM pessoas;
```

C)

```sql
SELECT COUNT(*) FROM pessoas WHERE idade >= 18 FILTER;
```

D)

```sql
SELECT COUNT(idade) FILTER idade >= 18 FROM pessoas;
```

✅ **Resposta:** A

---

### 4) DISTINCT ON

Qual consulta retorna apenas a pessoa mais velha de cada cidade?

A)

```sql
SELECT DISTINCT ON (cidade) nome, idade, cidade
FROM pessoas
ORDER BY cidade, idade DESC;
```

B)

```sql
SELECT nome, idade, cidade FROM pessoas GROUP BY cidade;
```

C)

```sql
SELECT * FROM pessoas WHERE idade = MAX(idade) GROUP BY cidade;
```

D)

```sql
SELECT nome, idade FROM pessoas ORDER BY cidade DESC;
```

✅ **Resposta:** A

---

### 5) ORDER BY em CTE

Qual consulta gera o top 3 salários?

A)

```sql
WITH top3 AS (
  SELECT nome, salario
  FROM salarios
  ORDER BY salario DESC
  LIMIT 3
)
SELECT * FROM top3;
```

B)

```sql
SELECT nome, salario FROM salarios LIMIT 3;
```

C)

```sql
SELECT nome, salario FROM salarios ORDER BY salario ASC LIMIT 3;
```

D)

```sql
SELECT nome, salario FROM salarios GROUP BY nome ORDER BY salario DESC;
```

✅ **Resposta:** A

---

## 💡 Dicas

* `ROW_NUMBER`, `RANK` e `DENSE_RANK` trazem diferentes tipos de ranking — saiba quando usar cada um.
* Subqueries correlacionadas no `WHERE` são poderosas, mas podem ser custosas em bases grandes.
* `FILTER` simplifica agregações condicionais.
* `DISTINCT ON` (PostgreSQL) é ótimo para pegar “o primeiro de cada grupo” sem precisar de window functions.
* Sempre use **CTEs com ORDER BY + LIMIT** para criar subconjuntos prontos para análise.
