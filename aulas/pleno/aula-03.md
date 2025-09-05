👉 O foco agora não é só “mostrar a sintaxe”, mas **aplicar em cenários práticos**, usando as tabelas do seu DDL (`pares`, `impares`, `pessoas`, `salarios`).
Vamos explorar:

* `UNION ALL` (com e sem duplicados)
* `INTERSECT` aplicado em tabelas diferentes
* `EXCEPT` para diferenciar conjuntos
* Combinações de operadores (`UNION` + `INTERSECT`)
* Ordem de precedência

---

# Aula 3 – SQL Intermediário (Operadores de Conjuntos)

Banco: **liga_sudoers**  
Tabelas: `pares`, `impares`, `pessoas`, `salarios`

---

## 🔧 Comandos mostrados (comentados)

### 1) UNION vs UNION ALL
```sql
SELECT valor FROM pares
UNION
SELECT valor FROM impares;
-- Une os dois conjuntos SEM duplicados.

SELECT valor FROM pares
UNION ALL
SELECT valor FROM impares;
-- Une mantendo os duplicados.
````

---

### 2) INTERSECT

```sql
SELECT nome FROM pessoas
INTERSECT
SELECT nome FROM pessoas2;
-- Lista apenas os nomes presentes nas duas tabelas.
```

---

### 3) EXCEPT

```sql
SELECT nome FROM pessoas
EXCEPT
SELECT nome FROM pessoas2;
-- Mostra quem está em pessoas mas não está em pessoas2.
```

---

### 4) Combinação de operadores

```sql
SELECT valor FROM pares
UNION
(SELECT valor FROM impares
 INTERSECT
 SELECT valor FROM notas);
-- Primeiro calcula a interseção, depois une com pares.
```

---

### 5) Ordem de precedência

```sql
SELECT valor FROM pares
UNION
SELECT valor FROM impares
INTERSECT
SELECT valor FROM notas;
-- No PostgreSQL: INTERSECT é avaliado antes do UNION.
-- Equivalente a: pares ∪ (impares ∩ notas)
```

---

## 🟡 Exercícios (múltipla escolha)

### 1) Diferença entre UNION e UNION ALL

Qual consulta mantém duplicados?

A)

```sql
SELECT valor FROM pares
UNION
SELECT valor FROM impares;
```

B)

```sql
SELECT valor FROM pares
UNION ALL
SELECT valor FROM impares;
```

C) Ambas mantêm duplicados.
D) Nenhuma mantém duplicados.

✅ **Resposta:** B

---

### 2) Nomes em comum

Como listar nomes que estão em `pessoas` e também em `pessoas2`?

A)

```sql
SELECT nome FROM pessoas
UNION SELECT nome FROM pessoas2;
```

B)

```sql
SELECT nome FROM pessoas
INTERSECT SELECT nome FROM pessoas2;
```

C)

```sql
SELECT nome FROM pessoas
EXCEPT SELECT nome FROM pessoas2;
```

D)

```sql
SELECT nome FROM pessoas
WHERE nome IN (SELECT nome FROM pessoas2);
```

✅ **Resposta:** B
(D também funciona, mas o exercício pede INTERSECT.)

---

### 3) Quem está só em `pessoas`

Como trazer registros de `pessoas` que **não aparecem em `pessoas2`**?

A)

```sql
SELECT nome FROM pessoas
EXCEPT SELECT nome FROM pessoas2;
```

B)

```sql
SELECT nome FROM pessoas
INTERSECT SELECT nome FROM pessoas2;
```

C)

```sql
SELECT nome FROM pessoas
UNION SELECT nome FROM pessoas2;
```

D)

```sql
SELECT nome FROM pessoas
MINUS SELECT nome FROM pessoas2;
```

✅ **Resposta:** A

---

### 4) Ordem de avaliação

O que acontece em:

```sql
SELECT valor FROM pares
UNION
SELECT valor FROM impares
INTERSECT
SELECT valor FROM notas;
```

A) Avalia UNION primeiro, depois INTERSECT.
B) Avalia INTERSECT primeiro, depois UNION.
C) Avalia tudo ao mesmo tempo.
D) O PostgreSQL não permite essa query.

✅ **Resposta:** B

---

### 5) União e interseção combinadas

Qual consulta retorna todos os valores de `pares` e apenas os que estão **em comum** entre `impares` e `notas`?

A)

```sql
SELECT valor FROM pares
UNION
(SELECT valor FROM impares INTERSECT SELECT valor FROM notas);
```

B)

```sql
SELECT valor FROM pares
INTERSECT
SELECT valor FROM impares
UNION
SELECT valor FROM notas;
```

C)

```sql
SELECT valor FROM pares
UNION ALL
SELECT valor FROM impares
UNION ALL
SELECT valor FROM notas;
```

D)

```sql
SELECT valor FROM pares, impares, notas;
```

✅ **Resposta:** A

---

## 💡 Dicas

* Use `UNION` quando quiser eliminar duplicados.
* Use `UNION ALL` quando duplicados importam (performance também é melhor).
* `INTERSECT` encontra o que é comum a dois conjuntos.
* `EXCEPT` encontra o que existe em um conjunto, mas não no outro.
* Lembre-se: no PostgreSQL, **INTERSECT tem precedência sobre UNION**.

---
