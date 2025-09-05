# Aula 08 - Remoção de Dados (DELETE) - Nível Iniciante

O comando `DELETE` é utilizado para **remover registros de uma tabela**.  
Assim como o `UPDATE`, ele faz parte do subconjunto **DML (Data Manipulation Language)**.

---

## 📝 Estrutura básica

```sql
DELETE FROM nome_tabela
WHERE condição;
```

📌 Sem o `WHERE`, **todos os registros da tabela serão apagados**.  
⚠️ Use sempre com cuidado.

---

## 🚀 Exemplo prático

Suponha a tabela `clientes`:

```sql
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    idade INT,
    ativo BOOLEAN
);
```

### Removendo um cliente específico
```sql
DELETE FROM clientes
WHERE id = 1;
```

👉 Remove apenas o cliente cujo `id` é igual a 1.

---

## 🔄 Removendo com base em condições

```sql
DELETE FROM clientes
WHERE ativo = FALSE;
```

👉 Remove todos os clientes que não estão mais ativos.

---

## ⚠️ Boas práticas para iniciantes

- Sempre use `WHERE` para evitar apagar todos os registros acidentalmente.  
- Teste sua condição primeiro com um `SELECT`:
  ```sql
  SELECT * FROM clientes WHERE ativo = FALSE;
  ```
- Evite rodar `DELETE` direto em produção sem verificar antes.  
- Para ambientes críticos, prefira **inativar** registros com `UPDATE ativo = FALSE` ao invés de remover fisicamente.  

---

📺 **Vídeo complementar:**  
[Aula 08 – Removendo dados no SQL](www.youtube.com/watch?v=u8C4WDZ1y5s&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=18) 
