👉 Aqui o foco é sair do básico e trazer:

* **Operadores de comparação** (`=`, `<>`, `!=`, `BETWEEN`, `IN`, `IS NULL`, `IS NOT NULL`)
* **Ordenações múltiplas** (`ORDER BY coluna1, coluna2`)
* **Aliases em ORDER BY** (ordenar por colunas derivadas)
* **Expressões condicionais no WHERE** (com `CASE`)
* Diferença prática entre `NULL` e valores explícitos.

---

# Aula 5 – SQL Intermediário (WHERE e ORDER BY na prática)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`, `datas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Comparações avançadas
```sql
SELECT * FROM pessoas
WHERE idade BETWEEN 20 AND 30;
-- Idades entre 20 e 30, inclusive.
````

```sql
SELECT * FROM pessoas
WHERE nome IN ('Ana','Bruno','Carlos');
-- Verifica se o valor está em uma lista.
```

---

### 2) Trabalhando com NULL

```sql
SELECT * FROM pessoas2
WHERE endereco IS NULL;
-- Filtra registros sem endereço.
```

```sql
SELECT * FROM pessoas2
WHERE endereco IS NOT NULL;
-- Filtra registros com endereço informado.
```

---

### 3) Múltiplas ordenações

```sql
SELECT nome, idade FROM pessoas
ORDER BY idade DESC, nome ASC;
-- Ordena primeiro pela idade (maior → menor),
-- e em caso de empate, pelo nome (A → Z).
```

---

### 4) ORDER BY usando alias

```sql
SELECT nome, (nota1+nota2)/2 AS media
FROM notas
ORDER BY media DESC;
-- Ordena por uma coluna derivada.
```

---

### 5) WHERE com CASE

```sql
SELECT * FROM pessoas
WHERE CASE 
        WHEN idade < 18 THEN 'Menor'
        ELSE 'Maior'
      END = 'Maior';
-- Filtra somente os maiores de idade.
```

---

## 🟡 Exercícios (múltipla escolha)

### 1) BETWEEN

Qual consulta retorna pessoas entre 25 e 40 anos?

A)

```sql
SELECT * FROM pessoas WHERE idade >= 25 AND idade <= 40;
```

B)

```sql
SELECT * FROM pessoas WHERE idade BETWEEN 25 AND 40;
```

C) Ambas A e B.
D) Nenhuma das duas.

✅ **Resposta:** C

---

### 2) IN

Como retornar apenas pessoas chamadas Ana, Bruno ou Carlos?

A)

```sql
SELECT * FROM pessoas WHERE nome IN ('Ana','Bruno','Carlos');
```

B)

```sql
SELECT * FROM pessoas WHERE nome = 'Ana' OR 'Bruno' OR 'Carlos';
```

C)

```sql
SELECT * FROM pessoas WHERE nome LIKE 'Ana|Bruno|Carlos';
```

D)

```sql
SELECT * FROM pessoas WHERE nome HAS ('Ana','Bruno','Carlos');
```

✅ **Resposta:** A

---

### 3) NULL

Qual consulta lista pessoas sem endereço?

A)

```sql
SELECT * FROM pessoas2 WHERE endereco = NULL;
```

B)

```sql
SELECT * FROM pessoas2 WHERE endereco IS NULL;
```

C)

```sql
SELECT * FROM pessoas2 WHERE endereco == NULL;
```

D)

```sql
SELECT * FROM pessoas2 WHERE endereco LIKE NULL;
```

✅ **Resposta:** B

---

### 4) Múltiplas ordenações

Como ordenar do mais velho para o mais novo, e em caso de empate pelo nome?

A)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade DESC, nome ASC;
```

B)

```sql
SELECT nome, idade FROM pessoas ORDER BY idade, nome;
```

C)

```sql
SELECT nome, idade FROM pessoas ORDER BY nome, idade;
```

D)

```sql
SELECT nome, idade FROM pessoas SORT BY idade DESC, nome ASC;
```

✅ **Resposta:** A

---

### 5) ORDER BY alias

Como ordenar alunos pela média de notas, da maior para a menor?

A)

```sql
SELECT nome, (nota1+nota2)/2 AS media FROM notas ORDER BY media DESC;
```

B)

```sql
SELECT nome, (nota1+nota2)/2 AS media FROM notas ORDER BY (nota1+nota2)/2 DESC;
```

C) Ambas A e B funcionam.
D) Nenhuma das duas.

✅ **Resposta:** C

---

## 💡 Dicas

* `BETWEEN` é inclusivo: inclui os extremos.
* `IN` é mais limpo do que encadear vários `OR`.
* Nunca use `= NULL` → sempre `IS NULL` / `IS NOT NULL`.
* Ordenar por múltiplas colunas ajuda em relatórios consistentes.
* Ordenar por **alias** deixa queries mais legíveis.

---
