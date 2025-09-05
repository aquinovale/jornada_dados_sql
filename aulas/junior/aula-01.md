# Aula 1 – SQL Iniciante (DDL da Jornada de Dados)

Banco: **liga_sudoers**  
Tabelas: `a`, `b`, `datas`, `impares`, `notas`, `pares`, `pessoas`, `pessoas2`, `salarios`

> Esta aula acompanha o vídeo da Jornada de Dados.  
> Objetivo: praticar SELECT, filtros básicos, ordenação, limites e valores únicos.

---

## 🔧 Comandos mostrados (comentados)

> Copie e cole no `psql`. Onde houver `<coluna>` substitua pelo nome real, se necessário.

### 1) Ver tudo de uma tabela
Mostra todas as colunas e linhas (útil para “enxergar” a tabela).

```sql
SELECT * FROM pessoas;
-- Dica: comece por SELECT * em qualquer tabela para entender a estrutura.
````

### 2) Selecionar colunas específicas

Traz apenas os campos que interessam (melhora leitura e performance).

```sql
SELECT nome, idade FROM pessoas;
-- Mostra só nome e idade (evita ruído do SELECT *).
```

### 3) Filtrar linhas (WHERE)

Restringe o resultado a um conjunto que atende a uma condição.

```sql
SELECT * 
FROM pessoas 
WHERE idade > 30;
-- Só pessoas com idade acima de 30.
```

### 4) Ordenar resultados (ORDER BY)

Controla a ordem da saída (ASC = crescente, DESC = decrescente).

```sql
SELECT * 
FROM salarios 
ORDER BY salario DESC;
-- Maiores salários primeiro.
```

### 5) Limitar quantidade (LIMIT)

Ótimo para amostras rápidas sem “inundar” a tela.

```sql
SELECT * 
FROM pares 
LIMIT 10;
-- Mostra apenas 10 linhas.
```

### 6) Valores distintos (DISTINCT)

Remove duplicatas na projeção selecionada.

```sql
SELECT DISTINCT valor 
FROM impares;
-- Lista valores únicos de 'valor' (sem repetição).
```

### 7) Filtros por faixa (BETWEEN)

Filtra por intervalo inclusivo (extremos entram).

```sql
SELECT * 
FROM salarios 
WHERE salario BETWEEN 2000 AND 5000;
-- Salários de 2000 a 5000 (incluindo 2000 e 5000).
```

### 8) Filtros por conjunto (IN)

Checa se o valor pertence a uma lista de opções.

```sql
SELECT * 
FROM pessoas 
WHERE nome IN ('Ana','Bruno','Carla');
-- Somente os nomes indicados.
```

### 9) Filtros de texto (LIKE)

Busca por “padrões” (usa % como coringa).

```sql
SELECT * 
FROM pessoas 
WHERE nome LIKE 'A%';
-- Nomes que começam com 'A' (Ana, Arthur, etc.).
```

### 10) Datas: truncar/ordenar (básico)

Exemplos simples para trabalhar com datas (ajuste o nome da coluna real).

```sql
SELECT * 
FROM datas 
ORDER BY data DESC 
LIMIT 5;
-- Últimas 5 linhas pela coluna 'data' (mais recentes primeiro).
```

---

## 🟢 Exercícios (múltipla escolha)

Cada questão tem **1 alternativa correta**.
(Sugestão: rode os comandos e observe os resultados antes de marcar.)

### 1) Ver todas as pessoas

Qual comando retorna **todos os registros** da tabela `pessoas`?

A) `SELECT pessoas;`
B) `SELECT * FROM pessoas;`
C) `SHOW pessoas;`
D) `GET ALL FROM pessoas;`

✅ **Resposta:** B

---

### 2) Somente nome e idade

Como trazer apenas as colunas `nome` e `idade` de `pessoas`?

A) `SELECT * FROM nome, idade;`
B) `SELECT pessoas.nome, pessoas.idade;`
C) `SELECT nome, idade FROM pessoas;`
D) `SHOW nome, idade FROM pessoas;`

✅ **Resposta:** C

> *Nota:* B está quase correta, mas sem o `FROM pessoas` a consulta não é válida.

---

### 3) Pessoas com idade maior que 30

Qual comando lista as pessoas com **idade acima de 30**?

A) `SELECT * FROM pessoas HAVING idade > 30;`
B) `SELECT idade > 30 FROM pessoas;`
C) `SELECT * FROM pessoas WHERE idade > 30;`
D) `FILTER pessoas WHERE idade > 30;`

✅ **Resposta:** C

---

### 4) Ordenar salários do maior para o menor

Como retornar os salários em **ordem decrescente**?

A) `SELECT * FROM salarios ORDER BY salario DESC;`
B) `SELECT * FROM salarios ORDER BY salario ASC;`
C) `SELECT * FROM salarios GROUP BY salario DESC;`
D) `SELECT salario FROM salarios DESC;`

✅ **Resposta:** A

---

### 5) Trazer só 10 valores da tabela `pares`

Qual consulta devolve **apenas 10 linhas**?

A) `SELECT TOP 10 * FROM pares;`
B) `SELECT * FROM pares LIMIT 10;`
C) `SELECT * FROM pares WHERE ROWNUM <= 10;`
D) `SELECT * FROM pares SAMPLE 10;`

✅ **Resposta:** B

> *Nota:* `TOP` e `ROWNUM` não são do PostgreSQL.

---

### 6) Valores únicos em `impares`

Como listar apenas os **valores distintos** da coluna `valor`?

A) `SELECT valor FROM impares;`
B) `SELECT UNIQUE valor FROM impares;`
C) `SELECT DISTINCT valor FROM impares;`
D) `SELECT valor FROM impares GROUP BY DISTINCT valor;`

✅ **Resposta:** C

---

### 7) Filtrar faixa de salários (2.000 a 5.000)

Qual consulta usa **intervalo inclusivo**?

A) `SELECT * FROM salarios WHERE salario IN (2000, 5000);`
B) `SELECT * FROM salarios WHERE salario BETWEEN 2000 AND 5000;`
C) `SELECT * FROM salarios WHERE salario >= 2000 OR salario <= 5000;`
D) `SELECT * FROM salarios WHERE salario > 2000 AND salario < 5000;`

✅ **Resposta:** B

> *Nota:* `BETWEEN` inclui os extremos (2000 e 5000).

---

### 8) Nomes que começam com “A”

Qual consulta usa **LIKE** corretamente?

A) `SELECT * FROM pessoas WHERE nome LIKE '%A';`
B) `SELECT * FROM pessoas WHERE nome LIKE 'A%';`
C) `SELECT * FROM pessoas WHERE nome LIKE '%A%';`
D) `SELECT * FROM pessoas WHERE nome = 'A%';`

✅ **Resposta:** B

> *Dica:* `'A%'` = começa com A; `'%A'` = termina com A; `'%A%'` = contém A.

---

### 9) Ver as 5 datas mais recentes

Qual comando traz **as 5 últimas** linhas ordenadas pela coluna `data`?

A)

```sql
SELECT * FROM datas ORDER BY data ASC LIMIT 5;
```

B)

```sql
SELECT * FROM datas ORDER BY data DESC LIMIT 5;
```

C)

```sql
SELECT TOP 5 * FROM datas ORDER BY data DESC;
```

D)

```sql
SELECT * FROM datas WHERE data IN (5) ORDER BY data DESC;
```

✅ **Resposta:** B

---

## 💡 Dicas finais

* Prefira começar por `SELECT *` para reconhecer a estrutura e, depois, **selecione colunas específicas**.
* Use `ORDER BY` e `LIMIT` para inspecionar **amostras úteis**.
* Em filtros, confirme se o tipo da coluna bate com o valor filtrado (texto vs número vs data).

---

## ✅ Próximo passo

Quando finalizar o **iniciante**, vamos para o **intermediário**, ainda com base nas mesmas tabelas do seu DDL.
