Agora vamos fechar a **Aula 4 – Nível Sudoers 🛡️**, levando operadores no SQL para o nível de **otimização, arquitetura e segurança**.
Aqui o foco é que o aluno aprenda a pensar como *guardião do banco de dados*: não apenas escrever queries, mas usar operadores de forma eficiente e segura em cenários reais.

---

# Aula 4 – Nível Sudoers 🛡️ (Operadores, Performance e Segurança)

Banco: **liga_sudoers**  
Tabelas: `pessoas`, `pessoas2`, `salarios`, `notas`

---

## 🔧 Operadores em Cenários Avançados

### 1) Índices e operadores
```sql
CREATE INDEX idx_pessoas_nome_pattern ON pessoas (nome text_pattern_ops);
SELECT * FROM pessoas WHERE nome LIKE 'A%';
-- Usando índice para acelerar LIKE com prefixo.
````

---

### 2) JSONB + índices GIN

```sql
CREATE INDEX idx_pessoas2_dados_gin ON pessoas2 USING gin (dados jsonb_path_ops);

SELECT * FROM pessoas2
WHERE dados @> '{"cidade":"São Paulo"}';
-- Operador @> (contém) otimizado com índice GIN.
```

---

### 3) Arrays + índices

```sql
CREATE INDEX idx_pessoas2_tags ON pessoas2 USING gin (tags);

SELECT * FROM pessoas2 WHERE tags && ARRAY['engenheiro','dados'];
-- Usa operador && (interseção de arrays).
```

---

### 4) Operadores e segurança (SQL Injection)

Errado ❌:

```sql
EXECUTE 'SELECT * FROM pessoas WHERE nome = ' || user_input;
```

Correto ✅ (usando operadores + parâmetros):

```sql
PREPARE stmt(text) AS
SELECT * FROM pessoas WHERE nome = $1;
EXECUTE stmt('Vinicius');
```

---

### 5) Operadores + tuning em EXPLAIN

```sql
EXPLAIN ANALYZE
SELECT * FROM pessoas
WHERE idade BETWEEN 20 AND 30
  AND nome ~ '^A.*';
-- Avaliar custo do operador regex + filtro de intervalo.
```

---

### 6) Reescrevendo operadores para performance

```sql
-- Pesado (regex sem índice)
SELECT * FROM pessoas WHERE nome ~* '.*vale.*';

-- Melhor (índice com ILIKE e prefixo)
SELECT * FROM pessoas WHERE nome ILIKE 'vale%';
```

---

## 🟣 Exercícios (múltipla escolha)

### 1) Índices com LIKE

Qual consulta pode usar índice de prefixo (`text_pattern_ops`)?

A) `SELECT * FROM pessoas WHERE nome LIKE 'A%';`
B) `SELECT * FROM pessoas WHERE nome LIKE '%a';`
C) `SELECT * FROM pessoas WHERE nome ILIKE '%a%';`
D) `SELECT * FROM pessoas WHERE nome ~ 'a$';`

✅ **Resposta:** A

---

### 2) JSONB + GIN

Qual consulta aproveita melhor um índice GIN sobre uma coluna JSONB?

A)

```sql
SELECT * FROM pessoas2
WHERE dados @> '{"cidade":"São Paulo"}';
```

B)

```sql
SELECT dados->>'cidade' FROM pessoas2;
```

C)

```sql
SELECT * FROM pessoas2 WHERE CAST(dados->>'cidade' AS text) = 'São Paulo';
```

D)

```sql
SELECT * FROM pessoas2 WHERE dados = 'São Paulo';
```

✅ **Resposta:** A

---

### 3) Arrays com GIN

Qual operador verifica se dois arrays possuem interseção?

A) `@>`
B) `<@`
C) `&&`
D) `=`

✅ **Resposta:** C

---

### 4) Segurança

Por que evitar concatenar strings para montar consultas?

A) Porque deixa a query mais lenta.
B) Porque pode gerar SQL Injection.
C) Porque impede o uso de índices.
D) Porque o PostgreSQL não permite.

✅ **Resposta:** B

---

### 5) Regex vs ILIKE

Qual opção é mais eficiente para buscar nomes que **começam** com "Vale"?

A) `nome ~* '.*Vale.*'`
B) `nome ILIKE 'Vale%'`
C) `nome LIKE '%Vale%'`
D) `nome REGEXP 'Vale'`

✅ **Resposta:** B

---

### 6) EXPLAIN ANALYZE

Para que serve `EXPLAIN ANALYZE` em queries com operadores?

A) Mostrar apenas os resultados.
B) Explicar a query sem executá-la.
C) Executar e mostrar plano real de execução + tempo/custo.
D) Criar índices automaticamente.

✅ **Resposta:** C

---

## 🛡️ Dicas Finais de Guardião

* Use **índices especializados (GIN, BTREE, text\_pattern\_ops)** para dar poder real aos operadores.
* **Regex e LIKE com `%` no início quebram índices** – prefira prefixos.
* Em JSON/arrays, operadores como `@>`, `<@`, `&&` só brilham de verdade com índices GIN.
* Sempre valide entrada de usuário e use **consultas parametrizadas**.
* Pense como Guardião: não basta saber os operadores — é preciso usá-los de forma **eficiente, segura e escalável**.

---
