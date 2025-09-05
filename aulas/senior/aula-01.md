👉 Foco do avançado:

* **Subqueries no `WHERE` e `SELECT`**
* **CTEs (`WITH`)**
* **CASE aninhado**
* **Funções de string (UPPER, LOWER, SUBSTRING, CONCAT)**
* **Uso criativo de CAST em condições**

Formato: **exemplo comentado** → **exercício de múltipla escolha**.

---

# Aula 1 – SQL Avançado (Subqueries, CTEs e Funções de String)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`, `pares`, `impares`, `datas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Subquery no WHERE
Verificar se uma pessoa tem salário registrado.

```sql
SELECT * 
FROM pessoas 
WHERE id IN (SELECT id FROM salarios);
-- Traz apenas pessoas que possuem salário associado.
````

---

### 2) Subquery no SELECT

Trazer o salário de cada pessoa diretamente no SELECT.

```sql
SELECT p.nome,
       (SELECT s.salario 
        FROM salarios s 
        WHERE s.id = p.id) AS salario
FROM pessoas p;
-- Adiciona coluna "salario" consultando outra tabela.
```

---

### 3) CTE – Common Table Expression

Organizar consultas mais complexas.

```sql
WITH maiores AS (
  SELECT * FROM pessoas WHERE idade > 30
)
SELECT nome, idade FROM maiores;
-- CTE 'maiores' funciona como tabela temporária.
```

---

### 4) CASE aninhado

Combina várias regras em cascata.

```sql
SELECT nome,
       CASE 
         WHEN idade < 18 THEN 'Menor'
         WHEN idade BETWEEN 18 AND 29 THEN 'Jovem Adulto'
         WHEN idade BETWEEN 30 AND 59 THEN 'Adulto'
         ELSE 'Sênior'
       END AS faixa
FROM pessoas;
-- Classificação avançada por faixas etárias.
```

---

### 5) Funções de string

Manipular nomes.

```sql
SELECT UPPER(nome) AS nome_maiusculo,
       LOWER(nome) AS nome_minusculo,
       SUBSTRING(nome,1,3) AS iniciais,
       CONCAT(nome, ' - Liga Sudoers') AS nome_custom
FROM pessoas;
-- Explora transformação de strings.
```

---

### 6) CAST em condições

Comparar numérico como string.

```sql
SELECT * 
FROM salarios
WHERE CAST(salario AS text) LIKE '2%';
-- Encontra salários que começam com "2" (ex.: 2000, 2500).
```

---

## 🔴 Exercícios (múltipla escolha)

### 1) Pessoas que possuem salário

Qual consulta retorna apenas pessoas com salário?

A)

```sql
SELECT * FROM pessoas 
WHERE id IN (SELECT id FROM salarios);
```

B)

```sql
SELECT * FROM pessoas 
WHERE id = ALL (salarios.id);
```

C)

```sql
SELECT * FROM pessoas 
JOIN salarios;
```

D)

```sql
SELECT * FROM pessoas 
WHERE salario IS NOT NULL;
```

✅ **Resposta:** A

---

### 2) Salário no SELECT

Qual consulta insere o salário de cada pessoa diretamente no SELECT?

A)

```sql
SELECT p.nome,
       (SELECT s.salario FROM salarios s WHERE s.id = p.id) AS salario
FROM pessoas p;
```

B)

```sql
SELECT p.nome, salarios.salario
FROM pessoas p;
```

C)

```sql
SELECT nome, salario FROM pessoas, salarios;
```

D)

```sql
SELECT nome, salario FROM pessoas NATURAL JOIN salarios;
```

✅ **Resposta:** A

---

### 3) CTE para maiores de 40 anos

Qual consulta usa CTE corretamente?

A)

```sql
WITH maiores AS (
  SELECT * FROM pessoas WHERE idade > 40
)
SELECT nome, idade FROM maiores;
```

B)

```sql
SELECT * FROM maiores;
WITH maiores AS (SELECT * FROM pessoas WHERE idade > 40);
```

C)

```sql
WITH (maiores) SELECT * FROM pessoas WHERE idade > 40;
```

D)

```sql
CREATE TEMP maiores AS SELECT * FROM pessoas WHERE idade > 40;
```

✅ **Resposta:** A

---

### 4) Classificação avançada de idade

Qual consulta está correta?

A)

```sql
SELECT nome,
CASE 
  WHEN idade < 18 THEN 'Menor'
  WHEN idade BETWEEN 18 AND 29 THEN 'Jovem Adulto'
  WHEN idade BETWEEN 30 AND 59 THEN 'Adulto'
  ELSE 'Sênior'
END AS faixa
FROM pessoas;
```

B)

```sql
SELECT nome,
SWITCH(idade < 18,'Menor','Adulto','Sênior')
FROM pessoas;
```

C)

```sql
SELECT nome,
IF idade < 18 THEN 'Menor' ELSE 'Adulto'
FROM pessoas;
```

D)

```sql
SELECT nome, idade > 18 ? 'Adulto' : 'Menor' FROM pessoas;
```

✅ **Resposta:** A

---

### 5) Nome em maiúsculas

Qual consulta retorna todos os nomes em letras maiúsculas?

A) `SELECT UPPER(nome) FROM pessoas;`
B) `SELECT nome TOUPPER FROM pessoas;`
C) `SELECT MAIUSCULO(nome) FROM pessoas;`
D) `SELECT UPPERCASE(nome) FROM pessoas;`

✅ **Resposta:** A

---

### 6) Salários que começam com “2”

Como encontrar salários que iniciam com o dígito 2?

A)

```sql
SELECT * FROM salarios WHERE CAST(salario AS text) LIKE '2%';
```

B)

```sql
SELECT * FROM salarios WHERE salario LIKE '2%';
```

C)

```sql
SELECT * FROM salarios WHERE salario = 2*;
```

D)

```sql
SELECT * FROM salarios WHERE salario LIKE 2;
```

✅ **Resposta:** A

---

## 💡 Dicas finais

* Subqueries no `SELECT` podem enriquecer os resultados, mas cuidado com performance.
* CTEs (`WITH`) deixam o código mais legível que subconsultas aninhadas.
* `CASE` pode ser expandido em várias condições, funciona como “if-else” dentro da query.
* Funções de string são essenciais para limpeza e padronização de dados.
* `CAST` abre muitas possibilidades de comparação e transformação.

---
