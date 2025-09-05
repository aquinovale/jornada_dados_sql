# Aula 07 - Atualização de Dados (UPDATE) - Nível Sudoers 🛡️

No nível **Sudoers**, o `UPDATE` deixa de ser apenas um comando de modificação de registros.  
Ele passa a ser uma ferramenta estratégica para **governança, auditoria, compliance, pipelines distribuídos e automação DataOps/MLOps**.

---

## 🔍 Auditoria e compliance

Cada atualização precisa ser rastreável para atender legislações como **LGPD** e **GDPR**.  

```sql
CREATE TABLE clientes_audit (
    id SERIAL,
    cliente_id INT,
    coluna_modificada TEXT,
    valor_antigo TEXT,
    valor_novo TEXT,
    atualizado_em TIMESTAMP DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION log_updates()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO clientes_audit (cliente_id, coluna_modificada, valor_antigo, valor_novo)
    VALUES (OLD.id, 'email', OLD.email, NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audit_update
AFTER UPDATE OF email ON clientes
FOR EACH ROW
EXECUTE FUNCTION log_updates();
```

👉 Assim, toda alteração de email fica registrada automaticamente.

---

## 🌍 Atualizações em ambientes distribuídos

Em arquiteturas de **Big Data e Multicloud**, o `UPDATE` pode envolver múltiplos sistemas:  

- **Delta Lake** → `UPDATE` ACID em Data Lakehouse.  
- **BigQuery** → atualizações eficientes em tabelas particionadas.  
- **Sharding** → distribui updates em nós diferentes.  

Exemplo Delta Lake:

```sql
UPDATE delta.`/mnt/datalake/clientes`
SET ativo = FALSE
WHERE ultima_compra < '2023-01-01';
```

---

## 🤖 DataOps e automação

No nível Sudoers, cada `UPDATE` faz parte de um pipeline automatizado:  

- **Airflow/Dagster/dbt** → orquestram atualizações em jobs versionados.  
- **CI/CD de dados** → scripts de `UPDATE` passam por versionamento e testes.  
- **Alertas em tempo real** → atualizações críticas disparam eventos em Grafana/Prometheus.  

Exemplo Airflow:

```python
update_task = PostgresOperator(
    task_id="desativar_clientes",
    postgres_conn_id="postgres_sudoers",
    sql="sql/update_desativar_clientes.sql"
)
```

---

## 🧬 MLOps e Feature Store

Atualizações também alimentam **pipelines de machine learning**:  

- **Atualização de features**: recalcular métricas usadas em modelos.  
- **Triggers inteligentes**: certos updates podem disparar re-treinos automáticos.  
- **Time Travel**: reproduzir versões anteriores dos dados para auditoria de modelos.  

Exemplo Delta Lake com Time Travel:

```sql
UPDATE features_churn
SET score_risco = novo_score
WHERE cliente_id = 123;
```

---

## 🛡️ Boas práticas Sudoers

- 🔑 **Auditabilidade** → todo update deve gerar histórico.  
- 🌐 **Multicloud ready** → updates desenhados para rodar em qualquer provedor.  
- 📊 **Idempotência** → updates reexecutáveis sem gerar inconsistência.  
- 🚨 **Monitoramento** → acompanhar locks, latência e impacto em pipelines.  
- 📑 **Governança de dados** → alinhar updates com catálogo e linhagem de dados.  

---

📺 **Vídeo complementar:**  
[Aula 07 – Atualizando dados no SQL](www.youtube.com/watch?v=u8C4WDZ1y5s&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=17) 
