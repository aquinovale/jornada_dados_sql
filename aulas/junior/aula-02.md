👉 Estrutura igual à Aula 1:

* **Comandos mostrados (comentados)**
* **Exercícios de múltipla escolha (iniciante)**

Vou usar suas tabelas (`pessoas`, `pessoas2`, `salarios`) para os exemplos.

---

# Aula 2 – SQL Iniciante (FROM e JOINs)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`

---

## 🔧 Comandos mostrados (comentados)

### 1) FROM simples
Selecionar dados de uma única tabela.

```sql
SELECT * 
FROM pessoas;
-- O FROM indica de qual tabela vamos buscar os dados.
````

---

### 2) CROSS JOIN

Combinação cartesiana: cada linha da primeira tabela com cada linha da segunda.

```sql
SELECT p.nome, s.salario
FROM pessoas p
CROSS JOIN salarios s;
-- Junta todas as pessoas com todos os salários (não recomendado em tabelas grandes).
```

---

### 3) INNER JOIN

Traz apenas registros que possuem correspondência em ambas as tabelas.

```sql
SELECT p.nome, s.salario
FROM pessoas p
INNER JOIN salarios s ON p.id = s.id;
-- Retorna apenas quem está nas duas tabelas.
```

---

### 4) LEFT JOIN

Traz todos da esquerda, e da direita só quem casar.

```sql
SELECT p.nome, s.salario
FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id;
-- Todas as pessoas aparecem, mesmo sem salário (neste caso, salário fica NULL).
```

---

### 5) RIGHT JOIN

Traz todos da direita, e da esquerda só quem casar.

```sql
SELECT p.nome, s.salario
FROM pessoas p
RIGHT JOIN salarios s ON p.id = s.id;
-- Todos os salários aparecem, mesmo sem pessoa correspondente.
```

---

### 6) FULL JOIN

Traz todos os registros das duas tabelas, mesmo que não tenham correspondência.

```sql
SELECT p.nome, s.salario
FROM pessoas p
FULL JOIN salarios s ON p.id = s.id;
-- União total: todos de 'pessoas' + todos de 'salarios'.
```

---

## 🟢 Exercícios (múltipla escolha)

### 1) FROM básico

Qual comando retorna todos os registros de `pessoas`?

A) `SELECT * IN pessoas;`
B) `SELECT * FROM pessoas;`
C) `GET ALL pessoas;`
D) `SHOW pessoas;`

✅ **Resposta:** B

---

### 2) CROSS JOIN

Qual resultado um CROSS JOIN entre `pessoas` e `salarios` gera?

A) Apenas registros com correspondência entre as duas tabelas.
B) Todas as combinações possíveis entre as linhas das duas tabelas.
C) Somente registros sem correspondência entre as tabelas.
D) Nenhuma das anteriores.

✅ **Resposta:** B

---

### 3) INNER JOIN

Como trazer apenas pessoas que possuem salário?

A)

```sql
SELECT p.nome, s.salario
FROM pessoas p
INNER JOIN salarios s ON p.id = s.id;
```

B)

```sql
SELECT p.nome, s.salario
FROM pessoas p
CROSS JOIN salarios s;
```

C)

```sql
SELECT p.nome, s.salario
FROM pessoas p
FULL JOIN salarios s ON p.id = s.id;
```

D)

```sql
SELECT p.nome, s.salario
FROM pessoas p;
```

✅ **Resposta:** A

---

### 4) LEFT JOIN

Qual a característica do LEFT JOIN?

A) Mostra apenas quem está nas duas tabelas.
B) Mostra todos da tabela da esquerda, e da direita apenas correspondentes.
C) Mostra todos da tabela da direita, e da esquerda apenas correspondentes.
D) Mostra apenas registros sem correspondência.

✅ **Resposta:** B

---

### 5) RIGHT JOIN

O que o RIGHT JOIN garante?

A) Todos os registros da tabela da direita aparecem, mesmo sem correspondência.
B) Todos da esquerda aparecem sempre.
C) Apenas interseção entre as duas tabelas.
D) Apenas linhas sem match.

✅ **Resposta:** A

---

### 6) FULL JOIN

Quando usar FULL JOIN?

A) Quando queremos **apenas registros em comum**.
B) Quando queremos **todos da esquerda + todos da direita** (com NULL onde não há match).
C) Quando queremos apenas registros da esquerda.
D) Quando queremos apenas registros da direita.

✅ **Resposta:** B

---

## 💡 Dicas

* Use `INNER JOIN` para relações diretas (ex.: pessoas que têm salário).
* Use `LEFT JOIN` para manter a base principal inteira, mesmo sem correspondência.
* `FULL JOIN` une tudo, mas raramente é necessário em cenários práticos.
* `CROSS JOIN` só faz sentido para análises combinatórias ou testes.

---
