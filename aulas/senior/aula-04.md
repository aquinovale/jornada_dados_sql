👉 Aqui já vamos além do uso básico e intermediário:

* **Operadores bitwise** (`&`, `|`, `#`, `~`, `<<`, `>>`)
* **Regex no PostgreSQL** (`~`, `~*`, `!~`, `!~*`)
* **Uso avançado de booleanos com subqueries**
* **Concatenação + COALESCE** (lidar com `NULL`)
* **Expressões complexas em CTEs** para filtros

---

# Aula 4 – SQL Avançado (Operadores Avançados)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Operadores bitwise
```sql
SELECT id, salario,
       salario & 1   AS bit_and,
       salario | 2   AS bit_or,
       salario << 1  AS shift_left
FROM salarios;
-- Manipula bits do valor numérico.
````

---

### 2) Regex em filtros

```sql
SELECT * FROM pessoas
WHERE nome ~ '^A.*o$';
-- Nomes que começam com "A" e terminam com "o".
```

```sql
SELECT * FROM pessoas
WHERE nome !~* 'silva';
-- Exclui nomes que contenham "silva" (case-insensitive).
```

---

### 3) Booleanos com subquery

```sql
SELECT * FROM pessoas p
WHERE EXISTS (
  SELECT 1 FROM salarios s WHERE s.id = p.id AND s.salario > 3000
);
-- Pessoas que possuem salário acima de 3000.
```

---

### 4) Concatenação com COALESCE

```sql
SELECT nome || ' - ' || COALESCE(endereco, 'Endereço não informado') AS descricao
FROM pessoas2;
-- Substitui NULL por frase padrão.
```

---

### 5) Expressões em CTE

```sql
WITH medias AS (
  SELECT id, (nota1 + nota2)/2 AS media
  FROM notas
)
SELECT * FROM medias
WHERE media >= 7;
-- Usa operadores aritméticos dentro de CTE.
```

---

## 🔴 Exercícios (múltipla escolha)

### 1) Operadores bitwise

O que faz `salario & 1`?

A) Retorna o valor do salário multiplicado por 1.
B) Verifica se o último bit de `salario` é 1 (par/ímpar).
C) Soma 1 ao valor de `salario`.
D) Converte salário em texto.

✅ **Resposta:** B

---

### 2) Regex

Qual consulta encontra nomes que começam com "J"?

A)

```sql
SELECT * FROM pessoas WHERE nome LIKE 'J%';
```

B)

```sql
SELECT * FROM pessoas WHERE nome ~ '^J';
```

C) Ambas A e B.
D) Nenhuma das duas.

✅ **Resposta:** C

---

### 3) Subquery com EXISTS

Qual consulta traz pessoas que possuem salário maior que 4000?

A)

```sql
SELECT * FROM pessoas p
WHERE EXISTS (
  SELECT 1 FROM salarios s WHERE s.id = p.id AND s.salario > 4000
);
```

B)

```sql
SELECT * FROM pessoas
WHERE salario > 4000;
```

C)

```sql
SELECT * FROM pessoas p
WHERE p.id IN (SELECT id FROM salarios);
```

D)

```sql
SELECT * FROM pessoas
INTERSECT
SELECT * FROM salarios WHERE salario > 4000;
```

✅ **Resposta:** A

---

### 4) COALESCE

Qual consulta substitui `NULL` por "Sem endereço"?

A)

```sql
SELECT COALESCE(endereco, 'Sem endereço') FROM pessoas2;
```

B)

```sql
SELECT NVL(endereco, 'Sem endereço') FROM pessoas2;
```

C)

```sql
SELECT endereco OR 'Sem endereço' FROM pessoas2;
```

D)

```sql
SELECT IFNULL(endereco,'Sem endereço') FROM pessoas2;
```

✅ **Resposta:** A
(*Obs:* `NVL` é do Oracle, `IFNULL` é do MySQL.)

---

### 5) CTE com operadores

Qual consulta calcula a média das notas e traz apenas quem tem média >= 8?

A)

```sql
WITH medias AS (
  SELECT id, (nota1 + nota2)/2 AS media
  FROM notas
)
SELECT * FROM medias WHERE media >= 8;
```

B)

```sql
SELECT id, (nota1 + nota2)/2 AS media
FROM notas WHERE media >= 8;
```

C)

```sql
SELECT id, media FROM notas
WHERE nota1 + nota2 / 2 >= 8;
```

D)

```sql
SELECT id FROM notas HAVING (nota1+nota2)/2 >= 8;
```

✅ **Resposta:** A

---

## 💡 Dicas

* **Bitwise** é útil em flags e permissões.
* **Regex** traz flexibilidade de filtros além do `LIKE`.
* **EXISTS** é mais eficiente que `IN` em subqueries grandes.
* **COALESCE** é essencial para evitar valores nulos em relatórios.
* Sempre use **CTEs** para organizar expressões complexas.

---
