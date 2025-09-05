Vamos agora para a **Aula 5 – Nível Avançado**, ainda no tema **WHERE e ORDER BY**.

👉 O foco aqui é explorar recursos mais poderosos:

* Subqueries no `WHERE`
* `EXISTS` e `NOT EXISTS`
* Comparações com `ALL` e `ANY`
* Ordenação avançada (`NULLS FIRST` / `NULLS LAST`)
* `CASE` dentro do `ORDER BY` para ordenação condicional

---

# Aula 5 – SQL Avançado (WHERE e ORDER BY Avançados)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Subquery no WHERE
```sql
SELECT nome, salario
FROM salarios
WHERE salario > (SELECT AVG(salario) FROM salarios);
-- Mostra salários acima da média.
````

---

### 2) EXISTS e NOT EXISTS

```sql
SELECT p.nome
FROM pessoas p
WHERE EXISTS (
  SELECT 1 FROM salarios s WHERE s.id = p.id
);
-- Pessoas que possuem salário.
```

```sql
SELECT p.nome
FROM pessoas p
WHERE NOT EXISTS (
  SELECT 1 FROM salarios s WHERE s.id = p.id
);
-- Pessoas sem salário.
```

---

### 3) Comparação com ALL e ANY

```sql
SELECT * FROM salarios
WHERE salario > ALL(SELECT salario FROM salarios WHERE id < 5);
-- Salários maiores que todos os salários de id < 5.
```

```sql
SELECT * FROM salarios
WHERE salario > ANY(SELECT salario FROM salarios WHERE id < 5);
-- Salários maiores que pelo menos um salário do grupo id < 5.
```

---

### 4) Ordenação com NULLS FIRST / NULLS LAST

```sql
SELECT nome, endereco
FROM pessoas2
ORDER BY endereco NULLS LAST;
-- Coloca NULLs no final.
```

```sql
SELECT nome, endereco
FROM pessoas2
ORDER BY endereco NULLS FIRST;
-- Coloca NULLs no início.
```

---

### 5) CASE no ORDER BY

```sql
SELECT nome, idade
FROM pessoas
ORDER BY 
  CASE 
    WHEN idade < 18 THEN 1
    WHEN idade BETWEEN 18 AND 59 THEN 2
    ELSE 3
  END;
-- Ordena por categorias de idade (Menor → Adulto → Sênior).
```

---

## 🔴 Exercícios (múltipla escolha)

### 1) Subquery no WHERE

Qual consulta traz salários acima da média?

A)

```sql
SELECT salario FROM salarios
WHERE salario > (SELECT AVG(salario) FROM salarios);
```

B)

```sql
SELECT salario FROM salarios
WHERE AVG(salario) < salario;
```

C)

```sql
SELECT salario FROM salarios
HAVING salario > AVG(salario);
```

D)

```sql
SELECT salario FROM salarios
WHERE salario > MAX(salario);
```

✅ **Resposta:** A

---

### 2) NOT EXISTS

Como listar pessoas que não possuem salário?

A)

```sql
SELECT p.nome FROM pessoas p
WHERE NOT EXISTS (SELECT 1 FROM salarios s WHERE s.id = p.id);
```

B)

```sql
SELECT nome FROM pessoas WHERE salario IS NULL;
```

C)

```sql
SELECT * FROM pessoas INTERSECT salarios;
```

D)

```sql
SELECT p.nome FROM pessoas p WHERE p.id <> salarios.id;
```

✅ **Resposta:** A

---

### 3) ALL vs ANY

O que significa `salario > ALL(...)`?

A) Salário maior que **qualquer um** da subquery.
B) Salário maior que **todos** da subquery.
C) Salário igual a pelo menos um da subquery.
D) Salário diferente de todos da subquery.

✅ **Resposta:** B

---

### 4) NULLS LAST

Qual consulta coloca registros sem endereço no fim da lista?

A)

```sql
SELECT * FROM pessoas2 ORDER BY endereco NULLS LAST;
```

B)

```sql
SELECT * FROM pessoas2 ORDER BY endereco DESC;
```

C)

```sql
SELECT * FROM pessoas2 WHERE endereco IS NULL;
```

D)

```sql
SELECT * FROM pessoas2 ORDER BY endereco ASC;
```

✅ **Resposta:** A

---

### 5) ORDER BY com CASE

Qual consulta ordena pessoas por categoria de idade (Menor → Adulto → Sênior)?

A)

```sql
SELECT nome, idade FROM pessoas
ORDER BY CASE
           WHEN idade < 18 THEN 1
           WHEN idade BETWEEN 18 AND 59 THEN 2
           ELSE 3
         END;
```

B)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade ASC;
```

C)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade DESC;
```

D)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade % 3;
```

✅ **Resposta:** A

---

## 💡 Dicas

* Use subqueries para comparações dinâmicas (`> (SELECT AVG(...))`).
* `EXISTS` e `NOT EXISTS` são mais eficientes que `IN`/`NOT IN` em tabelas grandes.
* `ALL` exige que a condição seja verdadeira para todos os valores; `ANY` basta para um.
* `NULLS FIRST/LAST` ajuda a organizar resultados com valores nulos.
* `CASE no ORDER BY` dá flexibilidade para ordenar por categorias personalizadas.

---
