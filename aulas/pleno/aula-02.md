# Aula 2 – SQL Intermediário (JOINs na prática)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`

---

## 🔧 Comandos mostrados (comentados)

### 1) Alias em tabelas
Simplifica o código, especialmente em joins longos.

```sql
SELECT p.nome, s.salario
FROM pessoas AS p
INNER JOIN salarios AS s ON p.id = s.id;
-- "p" e "s" são apelidos para escrever menos.
````

---

### 2) Condição no ON vs WHERE

* **ON:** define como as tabelas se relacionam.
* **WHERE:** filtra o resultado final após o JOIN.

```sql
-- Filtro no ON
SELECT p.nome, s.salario
FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id AND s.salario > 3000;

-- Filtro no WHERE
SELECT p.nome, s.salario
FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id
WHERE s.salario > 3000;
```

> Diferença: no ON, pessoas sem salário continuam aparecendo (salario NULL).
> No WHERE, elimina quem não tem salário.

---

### 3) JOIN de 3 tabelas

Exemplo combinando `pessoas`, `salarios` e `pessoas2`.

```sql
SELECT p.nome, s.salario, p2.endereco
FROM pessoas p
INNER JOIN salarios s ON p.id = s.id
INNER JOIN pessoas2 p2 ON p.id = p2.id;
-- Junta dados de 3 tabelas pela coluna id.
```

---

### 4) NATURAL JOIN

Une tabelas automaticamente pelas colunas de mesmo nome.
⚠️ Deve ser usado com cuidado, pois pode unir mais colunas do que o esperado.

```sql
SELECT * 
FROM pessoas
NATURAL JOIN pessoas2;
-- Une pelas colunas com o mesmo nome (ex.: id).
```

---

## 🟡 Exercícios (múltipla escolha)

### 1) Alias

Qual consulta usa alias corretamente?

A)

```sql
SELECT nome, salario
FROM pessoas p
JOIN salarios s ON pessoas.id = salarios.id;
```

B)

```sql
SELECT p.nome, s.salario
FROM pessoas p
JOIN salarios s ON p.id = s.id;
```

C)

```sql
SELECT pessoas.nome, salarios.salario
FROM pessoas, salarios;
```

D)

```sql
SELECT nome, salario
FROM p JOIN s ON id = id;
```

✅ **Resposta:** B

---

### 2) Diferença ON vs WHERE

No LEFT JOIN abaixo, qual consulta mantém pessoas sem salário?

A)

```sql
SELECT p.nome, s.salario
FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id AND s.salario > 3000;
```

B)

```sql
SELECT p.nome, s.salario
FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id
WHERE s.salario > 3000;
```

C) Ambas consultas mantêm todas as pessoas.
D) Nenhuma das duas mantém pessoas sem salário.

✅ **Resposta:** A

---

### 3) JOIN com 3 tabelas

Qual consulta combina corretamente pessoas, salários e pessoas2?

A)

```sql
SELECT p.nome, s.salario, p2.endereco
FROM pessoas p
JOIN salarios s ON p.id = s.id
JOIN pessoas2 p2 ON p.id = p2.id;
```

B)

```sql
SELECT nome, salario, endereco
FROM pessoas, salarios, pessoas2;
```

C)

```sql
SELECT nome, salario, endereco
FROM pessoas p
JOIN salarios s, pessoas2 p2;
```

D)

```sql
SELECT * FROM pessoas p JOIN salarios s JOIN pessoas2 p2;
```

✅ **Resposta:** A

---

### 4) NATURAL JOIN

O que acontece quando usamos `NATURAL JOIN`?

A) Une tabelas apenas pela coluna `id`.
B) Une tabelas automaticamente por todas as colunas com o mesmo nome.
C) É o mesmo que CROSS JOIN.
D) É o mesmo que FULL JOIN.

✅ **Resposta:** B

---

## 💡 Dicas

* Sempre prefira `JOIN ... ON` ao `NATURAL JOIN`, pois é mais explícito.
* Teste diferenças entre colocar filtros no `ON` e no `WHERE`.
* Com múltiplas tabelas, sempre use **alias** para evitar ambiguidades.

---
