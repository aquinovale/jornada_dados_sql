👉 Foco do especialista:

* **Subqueries correlacionadas** (dependem da linha externa)
* **CTEs recursivas**
* **Window functions** (`ROW_NUMBER`, `RANK`, `LAG`, `LEAD`)
* **Expressões regulares (`~`, `~*`)**
* **Funções avançadas de datas (`AGE`, `EXTRACT`, `DATE_TRUNC`)**
* **Manipulação condicional complexa (CASE dentro de window functions, por ex.)**

# Aula 1 – SQL Especialista (CTEs Recursivas, Janela e Regex)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`, `pares`, `impares`, `datas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Subquery correlacionada
Comparar cada salário com a média de todos os salários.

```sql
SELECT s.id, s.salario
FROM salarios s
WHERE s.salario > (SELECT AVG(s2.salario) FROM salarios s2);
-- Só retorna salários acima da média.
````

---

### 2) Window function – ranking

Numerar pessoas pela idade.

```sql
SELECT nome, idade,
       ROW_NUMBER() OVER (ORDER BY idade DESC) AS posicao
FROM pessoas;
-- Cria ranking de idade, do mais velho ao mais novo.
```

---

### 3) Window function – diferenças

Comparar cada salário com o anterior.

```sql
SELECT id, salario,
       LAG(salario) OVER (ORDER BY salario) AS salario_anterior,
       salario - LAG(salario) OVER (ORDER BY salario) AS diferenca
FROM salarios;
-- Mostra diferença de cada salário para o anterior.
```

---

### 4) CTE recursiva

Gerar números de 1 a 10 (útil para simulações ou joins).

```sql
WITH RECURSIVE numeros AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n+1 FROM numeros WHERE n < 10
)
SELECT * FROM numeros;
-- Constrói uma sequência recursiva.
```

---

### 5) Regex em WHERE

Encontrar nomes que começam com “A” e terminam com “o”.

```sql
SELECT * FROM pessoas
WHERE nome ~ '^A.*o$';
-- Usa regex: ^ = início, .* = qualquer coisa, $ = final.
```

---

### 6) Datas – diferença em anos

Calcular idade a partir de uma data de nascimento.

```sql
SELECT nome, AGE(data_nascimento) AS idade
FROM pessoas;
-- AGE retorna intervalo entre data de nascimento e hoje.
```

---

## ⚫ Exercícios (múltipla escolha)

### 1) Salários acima da média

Qual consulta retorna apenas salários maiores que a média geral?

A)

```sql
SELECT salario FROM salarios 
WHERE salario > (SELECT AVG(salario) FROM salarios);
```

B)

```sql
SELECT salario FROM salarios 
WHERE AVG(salario) > salario;
```

C)

```sql
SELECT salario FROM salarios 
HAVING salario > AVG(salario);
```

D)

```sql
SELECT salario FROM salarios WHERE salario IN AVG;
```

✅ **Resposta:** A

---

### 2) Ranking por idade

Qual comando gera um ranking do mais velho para o mais novo?

A)

```sql
SELECT nome, idade,
       ROW_NUMBER() OVER (ORDER BY idade DESC) AS posicao
FROM pessoas;
```

B)

```sql
SELECT nome, idade, RANK(idade) FROM pessoas;
```

C)

```sql
SELECT nome, idade, POSITION(idade) OVER() FROM pessoas;
```

D)

```sql
SELECT nome, idade, COUNT(*) OVER(idade) FROM pessoas;
```

✅ **Resposta:** A

---

### 3) Diferença entre salários

Como calcular a diferença de cada salário para o anterior?

A)

```sql
SELECT id, salario,
       salario - LAG(salario) OVER (ORDER BY salario) AS diff
FROM salarios;
```

B)

```sql
SELECT id, salario,
       salario - PREV(salario) OVER (ORDER BY salario) AS diff
FROM salarios;
```

C)

```sql
SELECT id, salario,
       DIFF(salario) OVER (ORDER BY salario) AS diff
FROM salarios;
```

D)

```sql
SELECT id, salario,
       LAG(salario) - salario OVER (ORDER BY salario) AS diff
FROM salarios;
```

✅ **Resposta:** A

---

### 4) Gerar sequência 1 a 10

Qual CTE recursiva está correta?

A)

```sql
WITH RECURSIVE numeros AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n+1 FROM numeros WHERE n < 10
)
SELECT * FROM numeros;
```

B)

```sql
WITH numeros AS (
  SELECT generate_series(1,10)
)
SELECT * FROM numeros;
```

C)

```sql
CREATE TEMP TABLE numeros AS 
SELECT 1 TO 10;
```

D)

```sql
WITH RECURSIVE n AS (SELECT 1 TO 10) SELECT * FROM n;
```

✅ **Resposta:** A

> *Nota:* B também funciona, mas usa `generate_series`, não uma CTE recursiva.

---

### 5) Regex em nomes

Como buscar nomes que começam com “A” e terminam com “o”?

A) `SELECT * FROM pessoas WHERE nome ~ '^A.*o$';`
B) `SELECT * FROM pessoas WHERE nome LIKE 'A%o';`
C) `SELECT * FROM pessoas WHERE nome REGEX '^A.*o$';`
D) `SELECT * FROM pessoas WHERE nome MATCHES '^A.*o$';`

✅ **Resposta:** A

---

### 6) Calcular idade

Qual consulta usa a função `AGE` corretamente?

A)

```sql
SELECT nome, AGE(data_nascimento) AS idade
FROM pessoas;
```

B)

```sql
SELECT nome, DATE_PART('age', data_nascimento) FROM pessoas;
```

C)

```sql
SELECT nome, DATEDIFF(NOW(), data_nascimento) FROM pessoas;
```

D)

```sql
SELECT nome, idade() FROM pessoas;
```

✅ **Resposta:** A

---

## 💡 Dicas finais

* **Subqueries correlacionadas** são muito poderosas, mas podem ser lentas em tabelas grandes.
* **Window functions** abrem caminho para análises avançadas sem precisar de `GROUP BY`.
* **CTEs recursivas** resolvem problemas de hierarquia, árvores e sequências.
* **Regex** deixa os filtros textuais extremamente flexíveis.
* Funções de data (`AGE`, `DATE_TRUNC`, `EXTRACT`) são essenciais em cenários reais.

