# Aula 06 - Inserção de Dados (INSERT) - Nível Sudoers 🛡️

No nível **Sudoers**, não falamos apenas de comandos SQL.  
Aqui o foco é **como o INSERT se conecta a pipelines de dados complexos**, garantindo **integridade, governança, auditoria, automação e escalabilidade multicloud**.

---

## 🌍 Inserções em ambientes multicloud

Em arquiteturas modernas, os dados não estão em um único lugar.  
O mesmo `INSERT` pode ser orquestrado entre **AWS, Azure, GCP** e Data Lakes.  

Exemplo prático com Databricks (Delta Lake em multicloud):

```sql
INSERT INTO delta.`s3://datalake-sudoers/bronze/clientes`
SELECT * FROM kafka_stream WHERE evento = 'insert';
```

👉 Aqui o evento chega via Kafka e é gravado no **Data Lake (bronze layer)** com consistência ACID.  

---

## 🛠️ DataOps e automação

Em pipelines DataOps, inserções são controladas, auditadas e monitoradas:  

- **CI/CD de dados** → todo script de `INSERT` passa por versionamento (Git).  
- **Automação** → uso de Airflow, dbt, Dagster para orquestrar inserções.  
- **Alertas** → inserções lentas ou com erro geram alertas no Grafana/Prometheus.  

Exemplo de orquestração com Airflow:

```python
insert_task = PostgresOperator(
    task_id="insert_clientes",
    postgres_conn_id="postgres_sudoers",
    sql="sql/insert_clientes.sql"
)
```

---

## 🔍 Auditoria e Linhagem

No nível Sudoers, **cada INSERT precisa ser rastreável**:  
- **Quem inseriu?** (usuário, serviço, pipeline)  
- **Quando?** (timestamp)  
- **De onde vieram os dados?** (linha de origem)  

Exemplo com auditoria automática:

```sql
CREATE TABLE clientes_audit (
    id SERIAL,
    cliente_id INT,
    acao VARCHAR(10),
    origem VARCHAR(50),
    inserido_em TIMESTAMP DEFAULT NOW()
);

-- Trigger que audita inserts
CREATE OR REPLACE FUNCTION log_inserts()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO clientes_audit (cliente_id, acao, origem)
    VALUES (NEW.id, 'INSERT', 'API-SUDOERS');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audit_insert
AFTER INSERT ON clientes
FOR EACH ROW
EXECUTE FUNCTION log_inserts();
```

👉 Assim, cada inserção é registrada para **auditoria e compliance**.  

---

## 🧬 Idempotência e confiabilidade

Em pipelines críticos, **reprocessar não pode gerar duplicatas**.  
Soluções:  
- **Chaves naturais** + `ON CONFLICT DO NOTHING`.  
- **Deduplicação automática** via **MERGE** (Delta Lake, BigQuery).  

Exemplo em Delta Lake:

```sql
MERGE INTO clientes AS destino
USING staging_clientes AS origem
ON destino.email = origem.email
WHEN NOT MATCHED THEN
  INSERT (nome, email, idade) VALUES (origem.nome, origem.email, origem.idade);
```

👉 Garante que cada cliente seja inserido **apenas uma vez**.  

---

## 🤖 Inserções inteligentes (MLOps)

No Sudoers, `INSERT` também alimenta **Modelos de Machine Learning**:  

- **Feature Store** → inserções controladas para alimentar features em produção.  
- **Time Travel** (Delta/BigQuery) → permite reproduzir o estado exato dos dados no passado.  
- **Re-treinamento automático** → cada `INSERT` relevante pode disparar um job de re-treino.  

Exemplo: logando inserções no MLflow para rastrear datasets de treino.

---

## ⚔️ Boas práticas Sudoers

- **Nunca insira sem governança** → todo dado precisa de **linhagem**.  
- **Automatize** → inserts devem rodar em pipelines versionados.  
- **Multicloud ready** → prepare suas inserções para serem independentes de provedor.  
- **Auditoria e compliance** → GDPR, LGPD, PCI.  
- **Pense em escala** → de 100 mil para 1 bilhão de registros, sem reescrever tudo.  

---

📺 **Vídeo complementar:**  
[Aula 06 – Inserindo dados no SQL](https://www.youtube.com/watch?v=Hj2rkoiW8WY&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=16)

