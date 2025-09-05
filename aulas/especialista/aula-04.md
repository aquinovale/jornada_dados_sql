Aqui a ideia é ir além dos operadores básicos/avançados e mostrar **recursos especializados do PostgreSQL** que combinam operadores com estruturas mais ricas.

👉 Foco no Especialista:

* Operadores com **arrays** (`ANY`, `ALL`, `@>`, `<@`, `&&`)
* Operadores com **JSON/JSONB** (`->`, `->>`, `#>` etc.)
* **CASE aninhado** com múltiplas condições
* Uso de **COALESCE e NULLIF** em expressões
* Expressões condicionais dentro de CTEs

---

# Aula 4 – SQL Especialista (Operadores em Estruturas Avançadas)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Operadores com arrays
```sql
SELECT id, nome
FROM pessoas
WHERE nome = ANY(ARRAY['Ana','Bruno','Carla']);
-- Verifica se o nome está dentro de um array.
````

```sql
SELECT ARRAY[1,2,3] @> ARRAY[2];  -- true (contém 2)
SELECT ARRAY[1,2,3] && ARRAY[3,4]; -- true (interseção existe)
```

---

### 2) Operadores com JSON

```sql
SELECT dados->>'cpf' AS cpf, dados->'endereco'->>'cidade' AS cidade
FROM pessoas2;
-- Extrai campos de colunas JSON.
```

```sql
SELECT dados#>>'{endereco,cep}' AS cep
FROM pessoas2;
-- Acessa aninhado via path.
```

---

### 3) CASE aninhado

```sql
SELECT nome,
       CASE 
         WHEN idade < 18 THEN 'Menor'
         WHEN idade BETWEEN 18 AND 29 THEN 
           CASE 
             WHEN nome LIKE 'A%' THEN 'Jovem A'
             ELSE 'Jovem'
           END
         WHEN idade BETWEEN 30 AND 59 THEN 'Adulto'
         ELSE 'Sênior'
       END AS categoria
FROM pessoas;
-- CASE dentro de CASE.
```

---

### 4) COALESCE e NULLIF

```sql
SELECT nome, COALESCE(endereco,'Endereço não informado') AS endereco
FROM pessoas2;
-- Substitui NULL por valor padrão.

SELECT NULLIF(nota1,0) AS nota_ajustada
FROM notas;
-- Retorna NULL se nota1 for igual a 0.
```

---

### 5) Expressões condicionais em CTE

```sql
WITH medias AS (
  SELECT id, (nota1+nota2)/2 AS media FROM notas
)
SELECT id,
       CASE 
         WHEN media >= 7 THEN 'Aprovado'
         ELSE 'Reprovado'
       END AS status
FROM medias;
-- Usa operadores e CASE em pipeline.
```

---

## ⚫ Exercícios (múltipla escolha)

### 1) Operadores em arrays

Como verificar se `idade` é maior que todos os valores de um array?

A) `SELECT * FROM pessoas WHERE idade > ALL(ARRAY[18,25,30]);`
B) `SELECT * FROM pessoas WHERE idade ANY(ARRAY[18,25,30]);`
C) `SELECT * FROM pessoas WHERE idade IN ALL(18,25,30);`
D) `SELECT * FROM pessoas WHERE idade ALL > ARRAY[18,25,30];`

✅ **Resposta:** A

---

### 2) JSON

Qual consulta extrai corretamente o campo `email` de uma coluna JSON chamada `dados`?

A) `SELECT dados.email FROM pessoas2;`
B) `SELECT dados->'email' FROM pessoas2;`
C) `SELECT dados->>'email' FROM pessoas2;`
D) `SELECT email(dados) FROM pessoas2;`

✅ **Resposta:** C

---

### 3) CASE aninhado

Como classificar corretamente jovens que começam com "B" de forma especial?

A)

```sql
SELECT nome,
CASE WHEN idade BETWEEN 18 AND 29
     THEN CASE WHEN nome LIKE 'B%' THEN 'Jovem B'
               ELSE 'Jovem'
          END
     ELSE 'Outro'
END AS categoria
FROM pessoas;
```

B)

```sql
SELECT nome,
IF idade BETWEEN 18 AND 29 AND nome LIKE 'B%' THEN 'Jovem B' ELSE 'Outro'
FROM pessoas;
```

C)

```sql
SELECT nome,
SWITCH(idade, '18-29','Jovem B') FROM pessoas;
```

D)

```sql
SELECT nome,
idade BETWEEN 18 AND 29 ? 'Jovem' : 'Outro'
FROM pessoas;
```

✅ **Resposta:** A

---

### 4) COALESCE vs NULLIF

O que faz `NULLIF(x,0)`?

A) Retorna NULL sempre.
B) Retorna NULL se `x` for 0, caso contrário retorna `x`.
C) Substitui NULL por 0.
D) Retorna erro se `x` for NULL.

✅ **Resposta:** B

---

### 5) CTE com operadores

Qual consulta retorna status de aprovação corretamente?

A)

```sql
WITH medias AS (
  SELECT id, (nota1+nota2)/2 AS media FROM notas
)
SELECT id,
CASE WHEN media >= 7 THEN 'Aprovado'
     ELSE 'Reprovado'
END
FROM medias;
```

B)

```sql
SELECT id, CASE media >= 7 'Aprovado' ELSE 'Reprovado'
FROM notas;
```

C)

```sql
WITH medias AS (
  SELECT id, media FROM notas
)
SELECT id, status FROM medias;
```

D)

```sql
SELECT id, CASE WHEN media THEN 'Aprovado' END FROM notas;
```

✅ **Resposta:** A

---

## 💡 Dicas

* Arrays em PostgreSQL têm operadores poderosos (`ANY`, `ALL`, `@>`, `<@`, `&&`).
* JSON/JSONB permite consultas sem normalizar tudo — mas exige cuidado com performance.
* `CASE` pode ser aninhado para regras complexas.
* `COALESCE` substitui valores nulos; `NULLIF` evita divisões por zero ou regras específicas.
* Combine operadores com CTEs para criar **pipelines claros e expressivos**.
