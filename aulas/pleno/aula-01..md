👉 Foco: **CAST**, **CASE**, **DISTINCT**, e também outros exemplos didáticos para quem já domina o básico.
Formato igual ao do iniciante: **exemplo comentado** → **exercício múltipla escolha**.

---

# Aula 1 – SQL Intermediário (Funções no SELECT, FROM e WHERE)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`, `pares`, `impares`, `datas`

---

## 🔧 Comandos mostrados (comentados)

### 1) CAST – converter tipos
Útil para transformar inteiros em texto, ou datas em texto/números.

```sql
SELECT id, CAST(salario AS text) AS salario_txt
FROM salarios;
-- Converte salário (número) para texto.
````

### 2) CASE – criar colunas condicionais

Permite lógica IF/ELSE dentro do SELECT.

```sql
SELECT nome,
       CASE 
         WHEN idade < 18 THEN 'Menor de idade'
         WHEN idade BETWEEN 18 AND 59 THEN 'Adulto'
         ELSE 'Idoso'
       END AS classificacao
FROM pessoas;
-- Classifica cada pessoa conforme a idade.
```

### 3) DISTINCT – valores únicos

Remove duplicatas de um campo específico.

```sql
SELECT DISTINCT idade 
FROM pessoas;
-- Lista idades únicas, sem repetição.
```

### 4) Funções no WHERE – CAST + filtros

Converter para comparar corretamente.

```sql
SELECT * 
FROM datas
WHERE CAST(data AS date) > '2023-01-01';
-- Garante que a comparação seja feita como data, não texto.
```

### 5) Funções no FROM – subconsulta como tabela

Podemos criar uma tabela derivada.

```sql
SELECT nome, idade
FROM (
  SELECT * FROM pessoas WHERE idade > 25
) AS maiores;
-- Subconsulta vira tabela 'maiores'.
```

---

## 🟡 Exercícios (múltipla escolha)

### 1) Converter salário para texto

Qual comando transforma a coluna `salario` em texto?

A) `SELECT salario::text FROM salarios;`
B) `SELECT CAST(salario AS text) FROM salarios;`
C) `SELECT TO_TEXT(salario) FROM salarios;`
D) Ambas A e B estão corretas.

✅ **Resposta:** D

---

### 2) Classificação por idade

Queremos classificar pessoas como "Jovem" (até 25 anos) e "Adulto" (acima de 25). Qual consulta está correta?

A)

```sql
SELECT nome,
       CASE WHEN idade <= 25 THEN 'Jovem' ELSE 'Adulto' END AS faixa
FROM pessoas;
```

B)

```sql
SELECT nome,
       IF idade <= 25 THEN 'Jovem' ELSE 'Adulto'
FROM pessoas;
```

C)

```sql
SELECT nome,
       SWITCH(idade <= 25,'Jovem','Adulto')
FROM pessoas;
```

D)

```sql
SELECT nome, idade > 25 ? 'Adulto' : 'Jovem'
FROM pessoas;
```

✅ **Resposta:** A

---

### 3) Idades distintas

Qual comando traz somente idades únicas?

A) `SELECT DISTINCT idade FROM pessoas;`
B) `SELECT idade FROM pessoas GROUP BY idade;`
C) `SELECT idade UNIQUE FROM pessoas;`
D) `SELECT idade FROM pessoas WHERE DISTINCT;`

✅ **Resposta:** A

---

### 4) Filtrar datas após 2024

Sabendo que a coluna `data` está como texto, como trazer apenas registros de 2024 em diante?

A)

```sql
SELECT * FROM datas WHERE data > '2024-01-01';
```

B)

```sql
SELECT * FROM datas WHERE CAST(data AS date) >= '2024-01-01';
```

C)

```sql
SELECT * FROM datas WHERE TO_DATE(data) >= '2024-01-01';
```

D)

```sql
SELECT * FROM datas WHERE data IN (2024);
```

✅ **Resposta:** B

---

### 5) Subconsulta no FROM

Qual consulta está correta para listar pessoas acima de 30 anos a partir de uma tabela derivada?

A)

```sql
SELECT nome, idade
FROM (SELECT * FROM pessoas WHERE idade > 30) AS maiores;
```

B)

```sql
SELECT nome, idade
FROM pessoas WHERE idade > 30;
```

C)

```sql
SELECT nome, idade
FROM (pessoas WHERE idade > 30);
```

D)

```sql
SELECT nome, idade
FROM maiores;
```

✅ **Resposta:** A

> *Nota:* B também traria o mesmo resultado, mas o exercício pede uso de **FROM com subconsulta**.

---

## 💡 Dicas finais

* Use `CAST` quando o tipo da coluna não bate com o tipo do filtro.
* `CASE` é poderoso para criar colunas calculadas e rótulos dinâmicos.
* Prefira `DISTINCT` a `GROUP BY` quando só precisa eliminar duplicatas.
* Subconsultas no `FROM` são chamadas **tabelas derivadas** e podem simplificar consultas mais complexas.

---

