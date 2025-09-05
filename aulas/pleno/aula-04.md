👉 Foco aqui:

* Funções matemáticas (`ROUND`, `CEIL`, `FLOOR`, `POWER`, `MOD`)
* Operadores booleanos combinados (`AND`, `OR`, `NOT`) em condições mais complexas
* Operadores de comparação (`=`, `<>`, `BETWEEN`, `IN`)
* Concatenação + `CASE` para personalizar resultados
* Uso prático em filtros e projeções

---

# Aula 4 – SQL Intermediário (Operadores na Prática)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Arredondamento
```sql
SELECT id, ROUND(salario, 2) AS salario_arredondado
FROM salarios;
-- Arredonda salário para 2 casas decimais.
````

---

### 2) Funções matemáticas

```sql
SELECT id,
       CEIL(salario)   AS teto,
       FLOOR(salario)  AS piso,
       POWER(salario,2) AS ao_quadrado
FROM salarios;
-- CEIL = arredonda pra cima
-- FLOOR = arredonda pra baixo
-- POWER = potência
```

---

### 3) Operadores de comparação

```sql
SELECT * FROM pessoas
WHERE idade BETWEEN 18 AND 30;
-- Traz pessoas de 18 a 30 anos.
```

```sql
SELECT * FROM pessoas
WHERE nome IN ('Ana','Bruno','Carlos');
-- Filtro com múltiplos valores.
```

---

### 4) Expressões booleanas complexas

```sql
SELECT * FROM pessoas
WHERE (idade > 18 AND idade < 60)
  OR nome LIKE 'J%';
-- Combinações com parênteses.
```

---

### 5) Concatenação com CASE

```sql
SELECT nome || ' tem idade de ' || idade || ' anos, categoria: ' ||
       CASE
         WHEN idade < 18 THEN 'Menor'
         WHEN idade BETWEEN 18 AND 59 THEN 'Adulto'
         ELSE 'Sênior'
       END AS descricao
FROM pessoas;
-- Usa operadores e CASE para enriquecer a saída.
```

---

## 🟡 Exercícios (múltipla escolha)

### 1) Arredondar salário

Como arredondar salários para duas casas decimais?

A) `SELECT ROUND(salario,2) FROM salarios;`
B) `SELECT salario,2 FROM salarios;`
C) `SELECT ROUND(2,salario) FROM salarios;`
D) `SELECT CEIL(salario,2) FROM salarios;`

✅ **Resposta:** A

---

### 2) Potência

Como calcular o quadrado do salário?

A) `SELECT POWER(salario,2) FROM salarios;`
B) `SELECT salario^2 FROM salarios;`
C) `SELECT EXP(salario,2) FROM salarios;`
D) `SELECT salario**2 FROM salarios;`

✅ **Resposta:** A
(*Obs:* em PostgreSQL, `^` e `**` também funcionam, mas o padrão SQL é `POWER`.)

---

### 3) Intervalo de idades

Qual consulta lista pessoas de 20 a 40 anos?

A)

```sql
SELECT * FROM pessoas WHERE idade = 20 AND idade = 40;
```

B)

```sql
SELECT * FROM pessoas WHERE idade BETWEEN 20 AND 40;
```

C)

```sql
SELECT * FROM pessoas WHERE idade > 20 OR idade < 40;
```

D)

```sql
SELECT * FROM pessoas WHERE idade IN (20,40);
```

✅ **Resposta:** B

---

### 4) Condição booleana

Qual consulta traz pessoas maiores de 18 **ou** cujo nome começa com "M"?

A)

```sql
SELECT * FROM pessoas 
WHERE idade > 18 OR nome LIKE 'M%';
```

B)

```sql
SELECT * FROM pessoas 
WHERE idade > 18 AND nome LIKE 'M%';
```

C)

```sql
SELECT * FROM pessoas 
WHERE NOT idade > 18;
```

D)

```sql
SELECT * FROM pessoas 
WHERE idade > 18 AND NOT nome LIKE 'M%';
```

✅ **Resposta:** A

---

### 5) Concatenação com CASE

Qual consulta gera frases como `"Ana tem idade de 25 anos, categoria: Adulto"`?

A)

```sql
SELECT nome || ' tem idade de ' || idade || ' anos, categoria: ' ||
CASE WHEN idade < 18 THEN 'Menor'
     WHEN idade BETWEEN 18 AND 59 THEN 'Adulto'
     ELSE 'Sênior'
END
FROM pessoas;
```

B)

```sql
SELECT CONCAT(nome, idade, categoria) FROM pessoas;
```

C)

```sql
SELECT nome + idade + ' anos' FROM pessoas;
```

D)

```sql
SELECT nome & idade & ' anos' FROM pessoas;
```

✅ **Resposta:** A

---

## 💡 Dicas

* Operadores aritméticos podem ser combinados com funções matemáticas.
* Sempre use **parênteses** para deixar claro o que deve ser avaliado primeiro em condições booleanas.
* `BETWEEN` e `IN` são atalhos úteis para simplificar expressões complexas.
* A concatenação (`||`) junto com `CASE` é poderosa para criar relatórios textuais.

---
