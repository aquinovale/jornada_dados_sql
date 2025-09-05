# Aula 08 - Remoção de Dados (DELETE) - Nível Intermediário

No nível iniciante vimos como remover registros simples.  
Agora, no nível **Intermediário**, vamos aprender a aplicar o `DELETE` de forma mais precisa, usando **condições lógicas, múltiplos filtros e relações entre tabelas**.

---

## 🔄 Removendo com múltiplas condições

Você pode combinar operadores lógicos (`AND`, `OR`, `NOT`) para filtrar melhor os registros a serem removidos:

```sql
DELETE FROM clientes
WHERE idade > 40 AND ativo = FALSE;
```

👉 Remove todos os clientes **inativos** com mais de 40 anos.

---

## 🧩 Removendo com operadores relacionais

```sql
DELETE FROM pedidos
WHERE valor < 10 OR status = 'CANCELADO';
```

👉 Remove todos os pedidos com valor menor que 10 **ou** que já foram cancelados.

---

## 🔗 Remoção baseada em outra tabela (subconsulta)

É possível usar subqueries para decidir quais registros serão apagados:

```sql
DELETE FROM clientes
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM pedidos);
```

👉 Remove todos os clientes que **nunca realizaram pedidos**.

---

## ⚠️ Boas práticas intermediárias

- Sempre valide sua condição com `SELECT` antes de executar o `DELETE`.  
- Prefira subconsultas ao invés de apagar manualmente linha a linha.  
- Se houver relacionamentos, **verifique constraints de chave estrangeira** — alguns SGBDs bloqueiam remoção se houver dependências.  
- Considere usar **DELETE lógico** (ex.: `UPDATE ativo = FALSE`) em sistemas que precisam manter histórico.  

---

📺 **Vídeo complementar:**  
[Aula 08 – Removendo dados no SQL](www.youtube.com/watch?v=u8C4WDZ1y5s&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=18) 
