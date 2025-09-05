# Aula 07 - Atualização de Dados (UPDATE) - Nível Avançado

Nos níveis iniciante e intermediário aprendemos a atualizar registros simples e condicionais.  
Agora, no nível **Avançado**, vamos explorar técnicas que envolvem **subconsultas, CTEs, CASE e manipulação de múltiplas tabelas**.

---

## 🔎 Atualizando com subconsulta

É possível usar os resultados de outra tabela para atualizar dados:

```sql
UPDATE clientes
SET email = (
    SELECT novo_email
    FROM atualizacoes
    WHERE atualizacoes.id_cliente = clientes.id
)
WHERE id IN (SELECT id_cliente FROM atualizacoes);
```

👉 Aqui os emails da tabela `clientes` são atualizados com os novos valores vindos de `atualizacoes`.

---

## 🧮 Atualizando com CASE

O `CASE` permite aplicar regras diferentes na mesma atualização:

```sql
UPDATE clientes
SET categoria = CASE
    WHEN idade < 18 THEN 'Jovem'
    WHEN idade BETWEEN 18 AND 59 THEN 'Adulto'
    ELSE 'Sênior'
END;
```

👉 Classifica clientes em faixas etárias sem precisar de múltiplos `UPDATE`.

---

## 📊 Atualização com CTE (Common Table Expression)

CTEs ajudam a organizar atualizações mais complexas:

```sql
WITH novos_precos AS (
    SELECT id, preco * 1.1 AS preco_corrigido
    FROM produtos
    WHERE categoria = 'Eletrônicos'
)
UPDATE produtos p
SET preco = np.preco_corrigido
FROM novos_precos np
WHERE p.id = np.id;
```

👉 A lógica de cálculo fica isolada no `WITH`, deixando o código mais claro e reutilizável.

---

## 🔗 Atualizando com JOIN (dependendo do SGBD)

Alguns SGBDs permitem `UPDATE` com `JOIN` diretamente:

```sql
UPDATE pedidos p
SET status = 'ENTREGUE'
FROM entregas e
WHERE p.id = e.id_pedido
AND e.data_entrega IS NOT NULL;
```

👉 Atualiza o status dos pedidos com base na tabela `entregas`.

---

## ⚠️ Boas práticas avançadas

- Prefira **CTEs** para deixar atualizações complexas mais legíveis.  
- Sempre valide o resultado com um `SELECT` antes de aplicar.  
- Em atualizações pesadas, rode em **transações** para permitir `ROLLBACK`.  
- Para múltiplas tabelas, documente bem a lógica de dependência.  

---

📺 **Vídeo complementar:**  
[Aula 07 – Atualizando dados no SQL](www.youtube.com/watch?v=u8C4WDZ1y5s&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=17) 
