# Aula 08 - Remoção de Dados (DELETE) - Nível Especialista

Até aqui vimos como usar o `DELETE` em situações simples, intermediárias e avançadas.  
No nível **Especialista**, o objetivo é entender como lidar com **grandes volumes de dados, tuning de performance e governança em ambientes de produção**.

---

## 🔒 Remoções com transações

Sempre que múltiplos deletes forem executados em conjunto, use **transações** para garantir atomicidade:

```sql
BEGIN;

DELETE FROM pedidos
WHERE data_pedido < '2024-01-01';

DELETE FROM clientes
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM pedidos);

COMMIT;
```

👉 Se algo falhar, é possível usar `ROLLBACK` para desfazer tudo.

---

## 📊 Estratégias para grandes volumes

1. **Rodar em lotes (batch delete)**  
   ```sql
   DELETE FROM logs
   WHERE data_registro < '2024-01-01'
   LIMIT 10000;
   ```
   👉 Evita bloqueios longos e melhora a performance.  

2. **Particionamento de tabelas**  
   Em tabelas gigantes, particionar por data facilita a limpeza:  
   ```sql
   DROP TABLE logs_2023; -- remove toda a partição de uma vez
   ```

3. **Truncate em staging tables**  
   Se a ideia é apagar **todos os registros**, prefira `TRUNCATE` (mais rápido que `DELETE`):  
   ```sql
   TRUNCATE TABLE staging_clientes;
   ```

---

## 🧩 Remoções com CTEs para maior clareza

```sql
WITH pedidos_antigos AS (
    SELECT id FROM pedidos WHERE status = 'CANCELADO'
)
DELETE FROM pedidos
WHERE id IN (SELECT id FROM pedidos_antigos);
```

👉 Deixa claro quais registros serão removidos antes da execução.

---

## ⚡ Tuning e performance

- **Desabilitar índices temporariamente** durante exclusões massivas pode acelerar o processo.  
- **Executar VACUUM/ANALYZE (PostgreSQL)** para liberar espaço após deletes.  
- **Monitorar locks e deadlocks** — deletes grandes podem travar a tabela inteira.  
- **Separar deletes em janelas de manutenção** para não impactar usuários.  

---

## 🛡️ Governança e boas práticas de especialista

- Prefira **soft delete** (marcar registros como inativos) quando for necessário manter histórico.  
- Documente todas as remoções críticas (auditoria).  
- Em sistemas financeiros ou regulados, **DELETE físico pode ser proibido**.  
- Avalie sempre se não é melhor arquivar (mover para uma tabela de histórico) ao invés de apagar.  

---

📺 **Vídeo complementar:**  
[Aula 08 – Removendo dados no SQL](www.youtube.com/watch?v=u8C4WDZ1y5s&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=18) 
