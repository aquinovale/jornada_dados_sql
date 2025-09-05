Chegamos ao **Nível Sudoers da Aula 5 🛡️**, onde `WHERE` e `ORDER BY` deixam de ser apenas filtros e ordenadores, e passam a ser **pontos críticos de performance e arquitetura**.
Aqui o foco é: **tuning, segurança e otimização real em bases grandes**.

---

# Aula 5 – Nível Sudoers 🛡️ (WHERE e ORDER BY em Performance e Arquitetura)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `salarios`, `notas`, `datas`

---

## 🔧 Operadores e Estratégias Avançadas

### 1) Índices e WHERE seletivo
```sql
CREATE INDEX idx_pessoas_idade ON pessoas (idade);

EXPLAIN ANALYZE
SELECT * FROM pessoas WHERE idade > 40;
-- O PostgreSQL usa o índice para filtrar mais rápido (Index Scan).
````

---

### 2) Índices compostos e ORDER BY

```sql
CREATE INDEX idx_salarios_nome_salario ON salarios (nome, salario);

SELECT nome, salario FROM salarios
WHERE salario > 5000
ORDER BY nome ASC, salario DESC;
-- Índice cobre filtro + ordenação.
```

---

### 3) Cuidado com funções no WHERE

❌ Lento:

```sql
SELECT * FROM pessoas
WHERE EXTRACT(YEAR FROM data_nascimento) = 1990;
-- Quebra índice, força full scan.
```

✅ Melhor:

```sql
SELECT * FROM pessoas
WHERE data_nascimento >= '1990-01-01'
  AND data_nascimento < '1991-01-01';
-- Usa índice de data.
```

---

### 4) ORDER BY em grandes volumes

```sql
SET work_mem = '64MB';

EXPLAIN ANALYZE
SELECT * FROM salarios ORDER BY salario DESC LIMIT 10;
-- Ajustar work_mem ajuda a evitar "external sort" em disco.
```

---

### 5) Parallel Query

```sql
EXPLAIN ANALYZE
SELECT * FROM salarios
WHERE salario > 1000
ORDER BY salario DESC;
-- Com tabelas grandes, PostgreSQL pode paralelizar o scan + sort.
```

---

### 6) Reescrevendo consultas pesadas

❌ Ruim:

```sql
SELECT * FROM pessoas
WHERE LOWER(nome) = 'vinicius';
```

✅ Melhor (com índice funcional):

```sql
CREATE INDEX idx_pessoas_nome_lower ON pessoas (LOWER(nome));
SELECT * FROM pessoas WHERE LOWER(nome) = 'vinicius';
-- Índice funcional suporta filtro case-insensitive.
```

---

## 🟣 Exercícios (múltipla escolha)

### 1) Índices e WHERE

Por que `EXTRACT(YEAR FROM data_nascimento) = 1990` é ruim para performance?

A) Porque retorna resultado errado.
B) Porque não pode ser usado em WHERE.
C) Porque invalida o uso de índices.
D) Porque ORDER BY não funciona junto.

✅ **Resposta:** C

---

### 2) Índices compostos

Qual consulta pode se beneficiar de `CREATE INDEX idx_salarios_nome_salario (nome, salario)`?

A)

```sql
SELECT nome, salario FROM salarios
WHERE salario > 5000 ORDER BY nome, salario DESC;
```

B)

```sql
SELECT nome FROM salarios WHERE nome LIKE 'A%';
```

C)

```sql
SELECT salario FROM salarios ORDER BY salario;
```

D)

```sql
SELECT * FROM salarios WHERE id > 10;
```

✅ **Resposta:** A

---

### 3) Funções no WHERE

Qual é a forma correta de buscar pessoas nascidas em 1990 usando índice?

A)

```sql
SELECT * FROM pessoas
WHERE EXTRACT(YEAR FROM data_nascimento) = 1990;
```

B)

```sql
SELECT * FROM pessoas
WHERE data_nascimento BETWEEN '1990-01-01' AND '1990-12-31';
```

C)

```sql
SELECT * FROM pessoas WHERE ano = 1990;
```

D)

```sql
SELECT * FROM pessoas WHERE data_nascimento LIKE '1990%';
```

✅ **Resposta:** B

---

### 4) work\_mem e ORDER BY

Por que aumentar `work_mem` pode acelerar queries com ORDER BY?

A) Porque força o uso de índice.
B) Porque permite que o sort ocorra em memória em vez de disco.
C) Porque cria índice temporário automaticamente.
D) Porque paraleliza todos os ORDER BY.

✅ **Resposta:** B

---

### 5) Parallel Query

O que o PostgreSQL pode fazer em queries grandes com WHERE + ORDER BY?

A) Dividir a execução em múltiplos processos (parallel query).
B) Sempre usar FULL SCAN sem índice.
C) Substituir ORDER BY por GROUP BY.
D) Criar índices automaticamente.

✅ **Resposta:** A

---

### 6) Índice funcional

Qual índice permite buscas case-insensitive em nomes?

A) `CREATE INDEX idx_pessoas_nome ON pessoas (nome);`
B) `CREATE INDEX idx_pessoas_nome_lower ON pessoas (LOWER(nome));`
C) `CREATE INDEX idx_pessoas_nome_ci ON pessoas (nome COLLATE "C");`
D) `CREATE INDEX idx_pessoas_nome_upper ON pessoas (UPPER(id));`

✅ **Resposta:** B

---

## 🛡️ Dicas de Guardião

* **Sempre evite funções diretas no WHERE** se quiser aproveitar índices.
* Índices compostos devem seguir a ordem dos filtros + ordenações mais usadas.
* Ajuste `work_mem` para operações com ORDER BY pesadas.
* Use índices funcionais para filtros case-insensitive ou calculados.
* Em bases grandes, pense em **parallel query** e **partitioning**.
* Como Guardião, sua missão é não só trazer resultados, mas trazer com **eficiência máxima**.

---
