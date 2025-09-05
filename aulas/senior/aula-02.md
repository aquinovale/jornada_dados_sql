👉 Aqui o aluno já sabe usar os tipos básicos de JOIN, então vamos elevar:

* **SELF JOIN** (tabela com ela mesma)
* **FULL OUTER JOIN + filtro de exclusão** (encontrar registros que não batem)
* **JOIN com subquery (tabela derivada)**
* **USING** (atalho em colunas com o mesmo nome)
* **JOINs encadeados com mais lógica**

---

# Aula 2 – SQL Avançado (JOINs avançados)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`

---

## 🔧 Comandos mostrados (comentados)

### 1) SELF JOIN
Comparar registros da mesma tabela.

```sql
SELECT p1.nome AS pessoa1, p2.nome AS pessoa2
FROM pessoas p1
JOIN pessoas p2 ON p1.id <> p2.id;
-- Compara pessoas entre si (ex.: pares diferentes).
````

---

### 2) FULL OUTER JOIN + filtro

Encontrar registros que não possuem correspondência em nenhuma das tabelas.

```sql
SELECT p.nome, s.salario
FROM pessoas p
FULL JOIN salarios s ON p.id = s.id
WHERE p.id IS NULL OR s.id IS NULL;
-- Mostra apenas "descasados" (quem tem pessoa sem salário e salário sem pessoa).
```

---

### 3) JOIN com subquery

Criar uma tabela derivada e juntar com ela.

```sql
SELECT p.nome, t.salario
FROM pessoas p
JOIN (
    SELECT id, salario 
    FROM salarios 
    WHERE salario > 3000
) t ON p.id = t.id;
-- Junta pessoas apenas com salários acima de 3000.
```

---

### 4) USING

Atalho quando a coluna tem o mesmo nome nas duas tabelas.

```sql
SELECT p.nome, s.salario
FROM pessoas p
JOIN salarios s USING (id);
-- Evita escrever ON p.id = s.id.
```

---

### 5) JOIN encadeado

Combinar várias tabelas de forma explícita.

```sql
SELECT p.nome, p2.endereco, s.salario
FROM pessoas p
LEFT JOIN pessoas2 p2 USING (id)
LEFT JOIN salarios s USING (id);
-- Reúne informações de 3 tabelas.
```

---

## 🔴 Exercícios (múltipla escolha)

### 1) SELF JOIN

Qual consulta faz um SELF JOIN em `pessoas`?

A)

```sql
SELECT p1.nome, p2.nome
FROM pessoas p1
JOIN pessoas p2 ON p1.id <> p2.id;
```

B)

```sql
SELECT p.nome, p.nome
FROM pessoas p;
```

C)

```sql
SELECT * FROM pessoas SELF JOIN pessoas;
```

D)

```sql
SELECT p1.nome, p2.nome
FROM pessoas p1, pessoas p2;
```

✅ **Resposta:** A
(D também roda, mas sem condição de join, vira CROSS JOIN.)

---

### 2) FULL OUTER JOIN + filtro

Como listar apenas quem **não tem correspondência** entre `pessoas` e `salarios`?

A)

```sql
SELECT p.nome, s.salario
FROM pessoas p
FULL JOIN salarios s ON p.id = s.id
WHERE p.id IS NULL OR s.id IS NULL;
```

B)

```sql
SELECT p.nome, s.salario
FROM pessoas p
FULL JOIN salarios s ON p.id = s.id;
```

C)

```sql
SELECT p.nome, s.salario
FROM pessoas p
RIGHT JOIN salarios s ON p.id = s.id;
```

D)

```sql
SELECT * FROM pessoas MINUS salarios;
```

✅ **Resposta:** A

---

### 3) JOIN com subquery

Qual consulta junta pessoas apenas com salários acima de 4000?

A)

```sql
SELECT p.nome, t.salario
FROM pessoas p
JOIN (SELECT id, salario FROM salarios WHERE salario > 4000) t
ON p.id = t.id;
```

B)

```sql
SELECT p.nome, s.salario
FROM pessoas p, salarios s
WHERE s.salario > 4000;
```

C)

```sql
SELECT nome, salario FROM pessoas NATURAL JOIN salarios;
```

D)

```sql
SELECT nome, salario FROM salarios WHERE salario > 4000;
```

✅ **Resposta:** A

---

### 4) USING

Qual consulta está correta ao usar USING na coluna `id`?

A)

```sql
SELECT p.nome, s.salario
FROM pessoas p
JOIN salarios s USING (id);
```

B)

```sql
SELECT nome, salario FROM pessoas JOIN salarios ON id;
```

C)

```sql
SELECT nome, salario FROM pessoas USING salarios(id);
```

D)

```sql
SELECT nome, salario FROM pessoas NATURAL JOIN salarios(id);
```

✅ **Resposta:** A

---

### 5) JOIN encadeado

Qual consulta combina `pessoas`, `pessoas2` e `salarios`?

A)

```sql
SELECT p.nome, p2.endereco, s.salario
FROM pessoas p
LEFT JOIN pessoas2 p2 USING (id)
LEFT JOIN salarios s USING (id);
```

B)

```sql
SELECT * FROM pessoas, pessoas2, salarios;
```

C)

```sql
SELECT nome, endereco, salario FROM pessoas FULL JOIN pessoas2 FULL JOIN salarios;
```

D)

```sql
SELECT nome, endereco, salario FROM pessoas NATURAL JOIN pessoas2 NATURAL JOIN salarios;
```

✅ **Resposta:** A

---

## 💡 Dicas

* Use **SELF JOIN** quando precisar comparar registros da mesma tabela.
* **FULL OUTER JOIN + filtro** é ótimo para auditoria e checar inconsistências.
* **Subqueries no JOIN** ajudam a pré-filtrar dados antes de combinar.
* **USING** economiza escrita, mas só funciona quando a coluna tem o mesmo nome.

---
