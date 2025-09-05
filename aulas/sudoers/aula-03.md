Aqui não é só “saber usar UNION/INTERSECT/EXCEPT”, mas **pensar como arquiteto**: otimização, armadilhas, uso avançado em cenários reais e tuning de consultas com operadores de conjuntos.

👉 Foco do nível Sudoers:

* **EXPLAIN ANALYZE em UNION/INTERSECT/EXCEPT**
* Diferença prática entre `UNION` vs `UNION ALL` em tabelas grandes (custo de deduplicação)
* **Set operations com múltiplas colunas**
* **Uso combinado com CTEs e índices**
* **Estratégias de tuning e pitfalls** (duplicatas, ordenação global, memória)
* Quando **reescrever com JOIN/EXISTS** em vez de operadores de conjuntos

---

# Aula 3 – Nível Sudoers 🛡️ (Teoria dos Conjuntos e Performance)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`, `notas`

---

## 🔧 Comandos mostrados (comentados)

### 1) Plano de execução em UNION
```sql
EXPLAIN ANALYZE
SELECT id FROM pessoas
UNION
SELECT id FROM pessoas2;
-- Mostra que o PostgreSQL executa cada SELECT separadamente,
-- depois aplica deduplicação global (custo extra).
````

---

### 2) UNION ALL em bases grandes

```sql
SELECT id FROM pessoas
UNION ALL
SELECT id FROM pessoas2;
-- Muito mais rápido, pois não faz deduplicação.
-- Em bases grandes, pode reduzir custo de minutos para segundos.
```

---

### 3) INTERSECT em múltiplas colunas

```sql
SELECT nome, idade FROM pessoas
INTERSECT
SELECT nome, idade FROM pessoas2;
-- Comparação feita em pares de colunas.
-- Só retorna se *todas* as colunas baterem.
```

---

### 4) EXCEPT para auditoria de múltiplas colunas

```sql
SELECT id, salario FROM salarios
EXCEPT
SELECT id, salario FROM pessoas2;
-- Descobre divergências completas (id + salário).
```

---

### 5) CTE com tuning

```sql
WITH ativos AS (
  SELECT id FROM pessoas
  UNION ALL
  SELECT id FROM pessoas2
)
SELECT * FROM ativos a
WHERE NOT EXISTS (
  SELECT 1 FROM salarios s WHERE s.id = a.id
);
-- Mistura UNION ALL (rápido) + EXISTS (eficiente para verificar ausência).
```

---

### 6) Reescrevendo para performance

```sql
-- Versão com EXCEPT
SELECT id FROM pessoas
EXCEPT
SELECT id FROM salarios;

-- Versão reescrita (geralmente mais rápida em bases grandes)
SELECT p.id
FROM pessoas p
WHERE NOT EXISTS (SELECT 1 FROM salarios s WHERE s.id = p.id);
```

---

## 🟣 Exercícios (múltipla escolha)

### 1) EXPLAIN em UNION

Por que `UNION` pode ser mais custoso que `UNION ALL`?

A) Porque executa deduplicação global.
B) Porque executa CROSS JOIN internamente.
C) Porque cria índices temporários automaticamente.
D) Porque exige FULL JOIN entre tabelas.

✅ **Resposta:** A

---

### 2) UNION ALL

Quando usar `UNION ALL` no lugar de `UNION`?

A) Sempre, porque é mais rápido.
B) Quando duplicatas não importam.
C) Quando a tabela é pequena.
D) Quando há ORDER BY no final.

✅ **Resposta:** B

---

### 3) INTERSECT em múltiplas colunas

O que retorna?

```sql
SELECT nome, idade FROM pessoas
INTERSECT
SELECT nome, idade FROM pessoas2;
```

A) Apenas nomes iguais.
B) Apenas idades iguais.
C) Pares (nome, idade) que aparecem em ambas as tabelas.
D) Todos os nomes de pessoas.

✅ **Resposta:** C

---

### 4) Auditoria com EXCEPT

Qual consulta identifica divergências completas entre `id` e `salario`?

A)

```sql
SELECT id FROM salarios
EXCEPT SELECT id FROM pessoas2;
```

B)

```sql
SELECT id, salario FROM salarios
EXCEPT SELECT id, salario FROM pessoas2;
```

C)

```sql
SELECT salario FROM salarios
EXCEPT SELECT salario FROM pessoas2;
```

D)

```sql
SELECT * FROM salarios FULL JOIN pessoas2;
```

✅ **Resposta:** B

---

### 5) Reescrevendo EXCEPT

Por que `NOT EXISTS` pode ser melhor que `EXCEPT`?

A) Porque retorna mais resultados.
B) Porque pode usar índices da tabela da subquery.
C) Porque funciona sem colunas em comum.
D) Porque sempre elimina duplicados.

✅ **Resposta:** B

---

### 6) Armadilha com ORDER BY

Qual cuidado deve-se ter ao usar `ORDER BY` em conjunto com `UNION`?

A) O `ORDER BY` só pode aparecer no último SELECT, a menos que cada subquery esteja entre parênteses.
B) O `ORDER BY` é ignorado sempre.
C) O `ORDER BY` precisa estar em todas as subqueries.
D) O PostgreSQL não permite ORDER BY em UNION.

✅ **Resposta:** A

---

## 🛡️ Dicas finais de Guardião

* Use **UNION ALL sempre que duplicados forem aceitáveis** → performance dispara.
* Prefira **EXISTS/NOT EXISTS** a `EXCEPT` em bases muito grandes.
* Em **INTERSECT/EXCEPT**, lembre-se: comparação é feita coluna a coluna.
* Analise sempre com **EXPLAIN ANALYZE** para confirmar custo.
* Evite `ORDER BY` desnecessário em queries com UNION → pode forçar sort global.
* Pense como Guardião: seu papel é **otimizar e proteger a base contra consultas lentas**.

---
