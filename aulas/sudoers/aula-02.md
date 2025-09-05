Esse nível é para mostrar ao aluno não só “como usar JOINs”, mas **como pensar em performance, tuning e arquitetura de consultas**. É aqui que a gente fala de como o PostgreSQL decide o plano, quando trocar estratégia, e como proteger a base contra consultas ruins.

👉 Foco Nível Sudoers em JOINs:

* **EXPLAIN ANALYZE e planos de join (Nested Loop, Hash Join, Merge Join)**
* **Índices que ajudam ou atrapalham em joins**
* **Particionamento lógico (estratégia para tabelas grandes)**
* **Reescrevendo consultas para performance**
* **Hints práticos e boas práticas**
* **Armadilhas de FULL JOIN e CROSS JOIN em produção**

---

# Aula 2 – Nível Sudoers 🛡️ (Joins e Performance)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`

---

## 🔧 Comandos mostrados (comentados)

### 1) EXPLAIN ANALYZE – ver plano real
Identificar estratégia de join usada pelo PostgreSQL.

```sql
EXPLAIN ANALYZE
SELECT p.nome, s.salario
FROM pessoas p
INNER JOIN salarios s ON p.id = s.id;
-- Mostra se o PostgreSQL usou Nested Loop, Hash Join ou Merge Join.
````

---

### 2) Nested Loop vs Hash Join

Forçar um tipo de join com parâmetro de sessão (só para estudo).

```sql
SET enable_hashjoin = off;
EXPLAIN ANALYZE
SELECT p.nome, s.salario
FROM pessoas p
JOIN salarios s ON p.id = s.id;
-- Agora só Nested Loop pode ser usado.
```

---

### 3) Índice para acelerar JOIN

Garantir índice na chave de junção.

```sql
CREATE INDEX idx_salarios_id ON salarios(id);
-- Sem índice, o JOIN pode virar um scan custoso.
```

---

### 4) Reescrevendo consulta para performance

Evitar FULL JOIN quando basta LEFT + filtro.

```sql
-- Ruim (pesado)
SELECT p.nome, s.salario
FROM pessoas p
FULL JOIN salarios s ON p.id = s.id;

-- Melhor
SELECT p.nome, s.salario
FROM pessoas p
LEFT JOIN salarios s ON p.id = s.id;
```

---

### 5) Particionamento lógico

Exemplo de junção com tabela particionada.

```sql
CREATE TABLE salarios_2024 PARTITION OF salarios
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
-- Consultas em joins podem ficar mais rápidas se o PostgreSQL ignorar partições irrelevantes.
```

---

### 6) CROSS JOIN em produção (armadilha)

Cuidado com o produto cartesiano.

```sql
SELECT COUNT(*)
FROM pessoas p
CROSS JOIN salarios s;
-- Se p=1.000 e s=10.000 → resultado = 10 milhões de linhas.
```

---

## 🟣 Exercícios (múltipla escolha)

### 1) Plano de execução

Qual comando mostra o plano de execução **real** de uma query?

A) `EXPLAIN SELECT ...`
B) `EXPLAIN ANALYZE SELECT ...`
C) `DESCRIBE SELECT ...`
D) `SHOW PLAN SELECT ...`

✅ **Resposta:** B

---

### 2) Estratégias de JOIN

Quais são os tipos principais de join executados internamente pelo PostgreSQL?

A) Nested Loop, Hash Join, Merge Join
B) INNER, LEFT, RIGHT, FULL
C) Index Join, Bitmap Join, Parallel Join
D) Loop Join, Cross Join, Self Join

✅ **Resposta:** A

---

### 3) Índices em joins

Por que criar índice em colunas usadas no JOIN?

A) Para reduzir custo de busca e evitar full table scan.
B) Para alterar o resultado da query.
C) Para obrigar o uso de CROSS JOIN.
D) Para eliminar a necessidade do ON.

✅ **Resposta:** A

---

### 4) FULL JOIN vs LEFT JOIN

Quando evitar FULL JOIN?

A) Quando queremos todos os registros de ambas as tabelas.
B) Quando basta garantir todos da tabela principal (usando LEFT JOIN).
C) Quando não existem colunas em comum.
D) Nunca, FULL JOIN é sempre a melhor opção.

✅ **Resposta:** B

---

### 5) CROSS JOIN em produção

Se `pessoas` tem 500 registros e `salarios` tem 2.000, quantas linhas gera um CROSS JOIN?

A) 2.000
B) 500
C) 1.000.000
D) 10.000

✅ **Resposta:** C (500 × 2000 = 1.000.000)

---

### 6) Particionamento lógico

Qual a vantagem de particionar uma tabela usada em JOINs?

A) Reduz o tamanho da query escrita.
B) Permite ao PostgreSQL ignorar partições irrelevantes e melhorar a performance.
C) Altera o resultado final da consulta.
D) Substitui a necessidade de índices.

✅ **Resposta:** B

---

## 🛡️ Dicas finais de Guardião

* Sempre rode **EXPLAIN ANALYZE** antes de confiar em um JOIN em tabelas grandes.
* Teste estratégias (Nested Loop, Hash Join, Merge Join) e veja a diferença no custo.
* **FULL JOIN** quase sempre pode ser substituído por LEFT/RIGHT.
* **CROSS JOIN** deve ser evitado, exceto em casos de combinação intencional.
* Índices bem colocados mudam a vida em JOINs complexos.
* Pense como Guardião: não basta “funcionar”, tem que ser **eficiente e seguro**.

---
