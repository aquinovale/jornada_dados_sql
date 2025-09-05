# Aula 06 - Inserção de Dados (INSERT) - Intermediário

No nível iniciante vimos como inserir registros simples e múltiplos.  
Agora vamos evoluir para técnicas intermediárias que já são usadas no dia a dia de quem trabalha com **bancos de dados relacionais**.

---

## 🔄 Inserindo valores padrão

Às vezes queremos usar o valor **default** definido na criação da tabela.  

```sql
INSERT INTO clientes (nome, email, idade, ativo)
VALUES ('Carlos Silva', 'carlos@email.com', DEFAULT, DEFAULT);
```

👉 Aqui `idade` e `ativo` assumem os valores definidos na tabela (`NULL` ou `DEFAULT`).  

---

## 📋 Inserindo apenas em algumas colunas

Não é obrigatório preencher todas as colunas, desde que as demais tenham valores `DEFAULT` ou permitam `NULL`:  

```sql
INSERT INTO clientes (nome, email)
VALUES ('Juliana Prado', 'juliana@email.com');
```

---

## 📊 Inserindo várias linhas de SELECT

O comando `INSERT ... SELECT` permite inserir dados de outra tabela.  

```sql
INSERT INTO clientes_backup (nome, email, idade)
SELECT nome, email, idade
FROM clientes
WHERE ativo = TRUE;
```

👉 Muito usado em **cópias de segurança** ou migrações de dados.  

---

## 🧩 Inserindo com funções

É possível gerar valores dinamicamente no momento da inserção:  

```sql
INSERT INTO clientes (nome, email, idade, ativo)
VALUES (
  INITCAP('paulo almeida'),   -- primeira letra maiúscula
  LOWER('PAULO@EMAIL.COM'),  -- email em minúsculo
  EXTRACT(YEAR FROM AGE('1990-05-10')), -- idade calculada
  TRUE
);
```

---

## 🚀 Inserindo com conflito (UPSERT)

Em alguns SGBDs, como o PostgreSQL, é possível inserir e tratar duplicatas com `ON CONFLICT`:  

```sql
INSERT INTO clientes (id, nome, email, idade)
VALUES (1, 'Novo Nome', 'novo@email.com', 30)
ON CONFLICT (id)
DO UPDATE SET
  nome = EXCLUDED.nome,
  email = EXCLUDED.email,
  idade = EXCLUDED.idade;
```

👉 Se o `id = 1` já existir, em vez de erro, o registro será **atualizado**.  

---

## ⚠️ Boas práticas

- Prefira sempre explicitar as colunas do `INSERT`.  
- Use `DEFAULT` para colunas com auto incremento (`SERIAL`, `BIGSERIAL`).  
- Em cargas de dados grandes, prefira **`INSERT ... SELECT`** ao invés de vários `VALUES`.  
- Em integrações de sistemas, avalie o uso de **UPSERT** para evitar registros duplicados.  

---

📺 **Vídeo complementar:**  
[Aula 06 – Inserindo dados no SQL](https://www.youtube.com/watch?v=Hj2rkoiW8WY&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=16)

