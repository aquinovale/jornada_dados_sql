Aqui a ideia é dar ao aluno consultas de **conjuntos mais sofisticadas**, mas ainda sem entrar no tuning hardcore.

👉 Foco do Especialista:

* **Múltiplas operações de conjunto na mesma query** (com parênteses para controlar precedência)
* **Comparação de conjuntos em várias colunas**
* **UNION/INTERSECT/EXCEPT dentro de CTEs mais elaboradas**
* **Uso de conjuntos para validar integridade/consistência de dados**
* **Exemplo prático de auditoria ou reconciliação de dados**

---
# Aula 3 – SQL Especialista (Operadores de Conjunto Avançados)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Combinação com parênteses
Controlar ordem de avaliação explicitamente.

```sql
(SELECT id FROM pessoas
 INTERSECT
 SELECT id FROM pessoas2)
UNION
(SELECT id FROM salarios);
-- Primeiro pega os ids comuns entre pessoas e pessoas2,
-- depois une com todos de salarios.
````

---

### 2) Comparação em múltiplas colunas

```sql
SELECT id, nome FROM pessoas
EXCEPT
SELECT id, nome FROM pessoas2;
-- Descobre divergências completas (id+nome).
```

---

### 3) CTEs múltiplas

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
),
com_salario AS (
  SELECT id FROM ativos
  INTERSECT
  SELECT id FROM salarios
)
SELECT * FROM sem_salario
UNION ALL
SELECT * FROM com_salario;
-- Divide em blocos e depois recompõe com operadores de conjunto.
```

---

### 4) Auditoria prática

```sql
SELECT id, salario
FROM salarios
EXCEPT
SELECT id, salario
FROM pessoas2;
-- Verifica inconsistências de cadastro entre salarios e pessoas2.
```

---

### 5) Reconciliação entre tabelas

```sql
SELECT 'Somente Pessoas' AS origem, id FROM pessoas
EXCEPT
SELECT 'Somente Pessoas' AS origem, id FROM salarios
UNION ALL
SELECT 'Somente Salarios' AS origem, id FROM salarios
EXCEPT
SELECT 'Somente Salarios' AS origem, id FROM pessoas;
-- Mostra quem está só em uma das tabelas.
```

---

## ⚫ Exercícios (múltipla escolha)

### 1) Precedência e parênteses

O que acontece nesta query?

```sql
SELECT id FROM pessoas
UNION
SELECT id FROM pessoas2
INTERSECT
SELECT id FROM salarios;
```

A) Executa UNION primeiro.
B) Executa INTERSECT primeiro.
C) PostgreSQL não permite.
D) Ordem depende do otimizador.

✅ **Resposta:** B

---

### 2) Diferença em múltiplas colunas

Qual consulta retorna quem está em `pessoas` mas não em `pessoas2`, considerando id e nome?

A)

```sql
SELECT id FROM pessoas
EXCEPT
SELECT id FROM pessoas2;
```

B)

```sql
SELECT id, nome FROM pessoas
EXCEPT
SELECT id, nome FROM pessoas2;
```

C)

```sql
SELECT nome FROM pessoas
EXCEPT
SELECT nome FROM pessoas2;
```

D)

```sql
SELECT id, nome FROM pessoas
INTERSECT
SELECT id, nome FROM pessoas2;
```

✅ **Resposta:** B

---

### 3) CTE com múltiplas operações

Qual consulta retorna IDs de ativos sem salário?

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
UNION
SELECT id FROM pessoas2
EXCEPT
SELECT id FROM salarios;
```

C)

```sql
SELECT id FROM pessoas
EXCEPT
SELECT id FROM salarios;
```

D)

```sql
SELECT id FROM pessoas2
EXCEPT
SELECT id FROM salarios;
```

✅ **Resposta:** A

---

### 4) Auditoria prática

Queremos saber quais salários não estão na tabela `pessoas2`. Qual consulta é correta?

A)

```sql
SELECT id, salario FROM salarios
EXCEPT
SELECT id, salario FROM pessoas2;
```

B)

```sql
SELECT id, salario FROM pessoas2
EXCEPT
SELECT id, salario FROM salarios;
```

C)

```sql
SELECT id FROM salarios
INTERSECT
SELECT id FROM pessoas2;
```

D)

```sql
SELECT salario FROM salarios
WHERE salario NOT IN (SELECT salario FROM pessoas2);
```

✅ **Resposta:** A

---

### 5) Reconciliação de dados

Qual consulta retorna quem está **apenas em uma das tabelas** (`pessoas` ou `salarios`)?

A)

```sql
SELECT id FROM pessoas
EXCEPT
SELECT id FROM salarios
UNION
SELECT id FROM salarios
EXCEPT
SELECT id FROM pessoas;
```

B)

```sql
SELECT id FROM pessoas
INTERSECT
SELECT id FROM salarios;
```

C)

```sql
SELECT id FROM pessoas
UNION
SELECT id FROM salarios;
```

D)

```sql
SELECT DISTINCT id FROM pessoas, salarios;
```

✅ **Resposta:** A

---

## 💡 Dicas

* Sempre use **parênteses** para deixar clara a ordem de execução.
* `EXCEPT` e `INTERSECT` podem ser usados em múltiplas colunas.
* Combine `CTEs` + operadores de conjunto para organizar consultas complexas.
* Conjuntos são ótimos para **auditoria, reconciliação e consistência de dados**.
