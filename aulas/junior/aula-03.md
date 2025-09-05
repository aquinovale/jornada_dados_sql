# Aula 3 – Teoria dos Conjuntos no SQL

Banco: **liga_sudoers**  

---

## 📚 Introdução
A **Teoria dos Conjuntos** é um ramo da matemática que estuda **coleções de elementos**.  
No SQL, muitos operadores seguem exatamente esses princípios, permitindo trabalhar com dados como se fossem conjuntos.

- **Pertinência (∈)**: se um objeto pertence a um conjunto.  
- **Subconjunto (⊆)**: se todos os elementos de A estão em B, então A é subconjunto de B.  
- **Operações de conjuntos**: união, interseção e diferença.

No SQL, traduzimos esses conceitos com os comandos: **UNION, INTERSECT e EXCEPT**.

---

## 🧩 Conceitos Básicos

- **União (A ∪ B)**  
  Conjunto de todos os elementos que pertencem a A ou a B (ou a ambos).  
  No SQL: `UNION`.

  Exemplo matemático:  
  {1,2,3} ∪ {2,3,4} = {1,2,3,4}

---

- **Interseção (A ∩ B)**  
  Conjunto de todos os elementos que pertencem a A e a B ao mesmo tempo.  
  No SQL: `INTERSECT`.

  Exemplo matemático:  
  {1,2,3} ∩ {2,3,4} = {2,3}

---

- **Diferença (A – B)**  
  Conjunto de elementos que estão em A, mas não em B.  
  No SQL: `EXCEPT`.

  Exemplo matemático:  
  {1,2,3} – {2,3,4} = {1}

---

## 🛠️ Sintaxe no SQL

### UNION
```sql
SELECT ... 
UNION [ALL] 
SELECT ...
````

* Une os resultados de dois SELECTs.
* Remove duplicados por padrão.
* Use `ALL` para manter duplicados.

---

### INTERSECT

```sql
SELECT ... 
INTERSECT [ALL] 
SELECT ...
```

* Retorna apenas os registros que aparecem em **ambos os SELECTs**.
* Remove duplicados por padrão.
* `ALL` mantém repetições.
* Obs.: no PostgreSQL funciona nativamente; no MySQL não é suportado.

---

### EXCEPT

```sql
SELECT ... 
EXCEPT [ALL] 
SELECT ...
```

* Retorna as linhas que estão no SELECT da esquerda **mas não no da direita**.
* Remove duplicados por padrão.
* Com `ALL`, considera multiplicidade (aparece `max(m-n,0)` vezes).
* Obs.: não é implementado no MySQL.

---

## 💡 Observações Importantes

* Todos os SELECTs usados em `UNION`, `INTERSECT` e `EXCEPT` devem ter:

  * o **mesmo número de colunas**
  * colunas com **tipos de dados compatíveis**
* É possível usar `ORDER BY` e `LIMIT`, mas se aplicam ao conjunto final, a menos que cada SELECT seja colocado entre parênteses.

---

## 🔎 Resumindo

* **UNION** = pega tudo (sem duplicar).
* **INTERSECT** = pega apenas o que é comum.
* **EXCEPT** = pega o que sobra de A quando tiramos o que existe em B.

---