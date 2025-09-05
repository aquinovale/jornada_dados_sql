# Aula 07 - Atualização de Dados (UPDATE) - Nível Iniciante

O comando `UPDATE` é utilizado para **alterar informações já existentes** em uma tabela.  
É um dos principais comandos do subconjunto **DML (Data Manipulation Language)**.

---

## 📝 Estrutura básica

```sql
UPDATE nome_tabela
SET coluna1 = valor1, coluna2 = valor2, ...
WHERE condição;
```

📌 **Atenção:** se você não usar `WHERE`, **todos os registros da tabela serão atualizados**.

---

## 🚀 Exemplo prático

Suponha a tabela `clientes`:

```sql
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    idade INT
);
```

### Atualizando a idade de um cliente:
```sql
UPDATE clientes
SET idade = 30
WHERE id = 1;
```

👉 Aqui apenas o cliente com `id = 1` terá a idade alterada para 30.

---

## 🔄 Atualizando uma única coluna

```sql
UPDATE clientes
SET nome = 'Maria Souza'
WHERE id = 2;
```

---

## 🧩 Atualizando múltiplas colunas

```sql
UPDATE clientes
SET nome = 'João Pedro',
    email = 'joao.pedro@email.com'
WHERE id = 3;
```

👉 Você pode alterar mais de um campo ao mesmo tempo.

---

## ⚠️ Boas práticas para iniciantes

- Sempre utilize `WHERE` para evitar mudanças acidentais em todos os registros.  
- Antes de atualizar, rode um `SELECT` com a mesma condição para verificar quem será alterado.  
- Atualize registros de teste primeiro, depois aplique em produção.  

---

📺 **Vídeo complementar:**  
[Aula 07 – Atualizando dados no SQL](www.youtube.com/watch?v=u8C4WDZ1y5s&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=17) 
