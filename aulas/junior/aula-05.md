# Aula 5 – SQL Iniciante (WHERE e ORDER BY)

Banco: **liga_sudoers**  
Tabelas usadas: `pessoas`, `salarios`, `notas`, `datas`

---

##  Comandos mostrados (comentados)

### 1) WHERE – filtrar linhas
```sql
SELECT * FROM pessoas
WHERE idade > 30;
-- Traz apenas pessoas com mais de 30 anos.
````

---

### 2) WHERE com texto

```sql
SELECT * FROM pessoas
WHERE nome LIKE 'A%';
-- Traz pessoas cujo nome começa com 'A'.
```

---

### 3) Combinação de condições (AND / OR)

```sql
SELECT * FROM pessoas
WHERE idade >= 18 AND nome LIKE 'J%';
-- Maiores de 18 cujo nome começa com 'J'.
```

```sql
SELECT * FROM notas
WHERE nota1 >= 7 OR nota2 >= 7;
-- Alguém teve média 7+ em alguma das provas.
```

---

### 4) ORDER BY – ordenar resultados

```sql
SELECT nome, idade FROM pessoas
ORDER BY idade DESC;
-- Ordena do mais velho para o mais jovem.
```

---

### 5) Combinar WHERE + ORDER BY + LIMIT

```sql
SELECT nome, salario FROM salarios
WHERE salario > 3000
ORDER BY salario ASC
LIMIT 5;
-- As 5 pessoas com salários acima de 3000, do menor para o maior.
```

---

## Exercícios (múltipla escolha)

### 1) Filtrar por idade

Como trazer apenas pessoas com menos de 25 anos?

A)

```sql
SELECT * FROM pessoas WHERE idade < 25;
```

B)

```sql
SELECT * FROM pessoas HAVING idade < 25;
```

C)

```sql
SELECT * FROM pessoas FILTER idade < 25;
```

D)

```sql
SELECT idade FROM pessoas WHERE idade = 25;
```

✅ **Resposta:** A

---

### 2) Filtrar por texto

Como retornar nomes que terminam com "o"?

A)

```sql
SELECT * FROM pessoas WHERE nome LIKE '%o';
```

B)

```sql
SELECT * FROM pessoas WHERE nome LIKE 'o%';
```

C)

```sql
SELECT * FROM pessoas WHERE nome = '%o';
```

D)

```sql
SELECT * FROM pessoas WHERE nome ~ 'o$';
```

✅ **Resposta:** A

---

### 3) AND vs OR

Quais pessoas com idade ≤ 20 ou nome começando com "M"?

A)

```sql
SELECT * FROM pessoas WHERE idade <= 20 OR nome LIKE 'M%';
```

B)

```sql
SELECT * FROM pessoas WHERE idade <= 20 AND nome LIKE 'M%';
```

C)

```sql
SELECT * FROM pessoas WHERE NOT idade > 20;
```

D)

```sql
SELECT * FROM pessoas WHERE nome LIKE 'M%' AND idade > 20;
```

✅ **Resposta:** A

---

### 4) Ordenação crescente

Como ordenar pessoas do mais jovem para o mais velho?

A)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade ASC;
```

B)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade DESC;
```

C)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade;
```

D)

```sql
SELECT nome, idade FROM pessoas ORDER BY ABS(idade);
```

✅ **Resposta:** A e C (ASC é padrão)

---

### 5) Filtrar salários e limitar

Mostrar os **3 salários mais altos** dentre os que são maiores que 5000:

A)

```sql
SELECT nome, salario FROM salarios
WHERE salario > 5000
ORDER BY salario DESC
LIMIT 3;
```

B)

```sql
SELECT nome, salario FROM salarios
WHERE salario > 5000
ORDER BY salario ASC
LIMIT 3;
```

C)

```sql
SELECT * FROM salarios LIMIT 3 WHERE salario > 5000 ORDER BY salario DESC;
```

D)

```sql
SELECT nome, salario FROM salarios
ORDER BY salario DESC
WHERE salario > 5000
LIMIT 3;
```

✅ **Resposta:** A

---

## Dicas rápidas

* Use `WHERE` para filtrar linhas antes de qualquer ordenação.
* `AND` e `OR` combinam várias condições (use parênteses se tiver mais de uma mistura).
* `LIKE 'A%'` busca prefixo; `'%A%'` busca substring.
* `ORDER BY` define como os resultados aparecem; `ASC` é padrão, `DESC` inverte.
* `LIMIT` é útil para mostrar amostras (ex.: top 5, 10%).
