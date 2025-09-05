### Tema: Operadores em SQL (Aritméticos, Booleanos, Concatenação)

---
# Aula 4 – SQL Iniciante (Operadores Básicos)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`

---

##  Comandos mostrados (com explicações)

### 1) Operadores aritméticos simples
Permite fazer cálculos diretamente na consulta.

```sql
SELECT id, salario, salario * 0.1 AS bonus
FROM salarios;
-- Calcula 10% de bônus sobre o salário.
````

---

### 2) Soma de notas

Útil para ver o total de pontos de um aluno.

```sql
SELECT id, nota1 + nota2 AS soma_notas
FROM notas;
-- Soma as notas 1 e 2 de cada pessoa.
```

---

### 3) Operadores booleanos (AND, OR, NOT)

Permite combinar condições.

```sql
SELECT * FROM pessoas
WHERE idade > 18 AND nome LIKE 'A%';
-- Filtra maiores de idade cujo nome começa com A.
```

---

### 4) Concatenação de strings

Útil para criar campos customizados ou mensagens.

```sql
SELECT nome || ' tem idade de ' || idade || ' anos' AS descricao
FROM pessoas;
-- Cria frase juntando nome e idade.
```

---

### 5) Aritmética em WHERE

Permite aplicar filtros com expressões.

```sql
SELECT * FROM notas
WHERE (nota1 + nota2) / 2 >= 7;
-- Traz apenas quem tem média >= 7.
```

---

## Exercícios (múltipla escolha)

### 1) Calcular 15% de salário

Qual consulta calcula 15% de gratificação?

A)

```sql
SELECT salario + 15 FROM salarios;
```

B)

```sql
SELECT salario * 0.15 AS bonus FROM salarios;
```

C)

```sql
SELECT salario ^ 15 FROM salarios;
```

D)

```sql
SELECT 15% FROM salarios;
```

✅ **Resposta:** B

---

### 2) Somar as notas

Como somar `nota1` e `nota2`?

A) `SELECT nota1 + nota2 FROM notas;`
B) `SELECT SUM(nota1, nota2) FROM notas;`
C) `SELECT nota1 || nota2 FROM notas;`
D) `SELECT nota1 & nota2 FROM notas;`

✅ **Resposta:** A

---

### 3) Filtro com AND

Qual consulta filtra pessoas maiores de 20 cujo nome começa com “B”?

A)

```sql
SELECT * FROM pessoas 
WHERE idade > 20 AND nome LIKE 'B%';
```

B)

```sql
SELECT * FROM pessoas 
WHERE idade > 20 OR nome LIKE 'B%';
```

C)

```sql
SELECT * FROM pessoas 
WHERE NOT idade > 20 AND nome LIKE 'B%';
```

D)

```sql
SELECT * FROM pessoas 
WHERE idade > 20 AND nome = 'B%';
```

✅ **Resposta:** A

---

### 4) Concatenação de texto

Como criar uma frase `"João tem idade de 30 anos"`?

A)

```sql
SELECT nome || ' tem idade de ' || idade || ' anos' FROM pessoas;
```

B)

```sql
SELECT CONCAT(nome ' tem idade de ' idade ' anos') FROM pessoas;
```

C)

```sql
SELECT nome + idade + 'anos' FROM pessoas;
```

D)

```sql
SELECT nome & idade & ' anos' FROM pessoas;
```

✅ **Resposta:** A

---

### 5) Média mínima

Quem tem média das notas >= 8?

A)

```sql
SELECT * FROM notas 
WHERE (nota1 + nota2) / 2 >= 8;
```

B)

```sql
SELECT * FROM notas 
WHERE nota1 >= 8 AND nota2 >= 8;
```

C)

```sql
SELECT * FROM notas 
HAVING (nota1 + nota2)/2 >= 8;
```

D)

```sql
SELECT * FROM notas 
WHERE nota1 + nota2 >= 8;
```

✅ **Resposta:** A

---

## Dicas rápidas

* **Aritmética**: +, -, \*, /, %, etc. podem ser usados direto em SELECT e WHERE.
* **Booleanos**: `AND`, `OR`, `NOT` ajudam a combinar filtros.
* **Concatenação**: `||` une strings. Em outras bases, você pode usar `CONCAT()`.
* **Expressões em filtros** são poderosas — podem fazer verificações de média, porcentagem e derivadas diretas no SELECT.

---

