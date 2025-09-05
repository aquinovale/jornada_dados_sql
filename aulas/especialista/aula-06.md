No nível **Especialista**, vamos focar no **INSERT em cenários distribuídos, paralelismo, tuning avançado e estratégias em ambientes de alta disponibilidade**. Aqui o objetivo é mostrar como um **Engenheiro de Dados** lida com inserções em escala de produção, Big Data e clusters distribuídos.

---

# Aula 06 - Inserção de Dados (INSERT) - Especialista

Já vimos como inserir dados em cenários básicos, intermediários e avançados.  
Agora, no nível **Especialista**, vamos explorar **estratégias de inserção em larga escala**, pensando em **alta performance, distribuição e arquiteturas de Big Data**.

---

## ⚡ Inserção paralela

Em tabelas muito grandes, um único `INSERT` pode se tornar gargalo.  
Alguns SGBDs e ferramentas permitem **inserções paralelas**:

- **PostgreSQL** → paralelismo pode ser alcançado via **particionamento** e múltiplos processos `COPY` em paralelo.  
- **Spark + JDBC** → escreve em paralelo em múltiplas partições.  

Exemplo com Spark:

```python
df.write \
  .format("jdbc") \
  .option("url", "jdbc:postgresql://localhost:5432/liga_sudoers") \
  .option("dbtable", "clientes") \
  .option("user", "sudoers") \
  .option("password", "password") \
  .mode("append") \
  .save()
```

👉 Aqui cada partição do DataFrame gera inserts em paralelo.  

---

## 🗂️ Inserção em tabelas particionadas

Quando lidamos com milhões/bilhões de registros, o ideal é **particionar** dados por chave lógica (ex: data).  

```sql
CREATE TABLE vendas_2025 PARTITION OF vendas
FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');
```

Depois, o `INSERT` é direcionado automaticamente para a partição correta:

```sql
INSERT INTO vendas (data_venda, cliente_id, valor)
VALUES ('2025-03-01', 101, 500.00);
```

👉 Isso melhora performance de inserção e consultas.  

---

## 🏗️ Inserção em arquiteturas distribuídas

Em cenários de **Big Data**, o `INSERT` pode não ser a melhor opção.  
Usamos **frameworks distribuídos** e **data lakes** para ingestão massiva:

- **Hive / Spark SQL** → `INSERT INTO tabela SELECT ...`  
- **Delta Lake** → inserções otimizadas com ACID.  
- **Kafka Connect** → ingestão contínua em SGBDs.  

Exemplo Spark SQL em Delta Lake:

```sql
INSERT INTO delta.`/mnt/datalake/vendas`
SELECT * FROM staging_vendas WHERE ano = 2025;
```

---

## 🔄 Estratégias de ingestão

Existem diferentes estratégias para inserir dados em produção:

1. **Batch Ingestion (lotes)**  
   - Grandes volumes em horários definidos.  
   - Exemplo: carga diária com `COPY` ou Spark.

2. **Streaming Ingestion (tempo real)**  
   - Dados chegando continuamente.  
   - Exemplo: Kafka → Spark Structured Streaming → PostgreSQL.

3. **Micro-batching**  
   - Combina batch + streaming.  
   - Exemplo: processa dados a cada 1 minuto em mini-lotes.  

---

## 🎯 Tuning de performance em Inserts

- **Batch size** → evite inserir linha a linha, use lotes (`1000+` registros por vez).  
- **Checkpoint / commit interval** → em streaming, define a frequência de escrita.  
- **Write Ahead Logging (WAL)** → configure corretamente no PostgreSQL para balancear performance e durabilidade.  
- **Índices** → em cargas massivas, considere desabilitar/recriar índices após a inserção.  

---

## 🛡️ Alta disponibilidade

Em sistemas críticos, inserções precisam garantir **consistência e durabilidade**:

- **Replicação síncrona** → dados confirmados apenas após escrita em réplica.  
- **Sharding** → divide dados entre múltiplos nós para distribuir carga.  
- **Failover automático** → garante que inserts não parem em caso de queda do nó principal.  

---

## 📌 Exemplo de ingestão distribuída (Kafka → PostgreSQL)

```yaml
# Configuração simplificada Kafka Connect
name=clientes-sink
connector.class=io.confluent.connect.jdbc.JdbcSinkConnector
tasks.max=4
connection.url=jdbc:postgresql://db:5432/liga_sudoers
connection.user=sudoers
connection.password=password
topics=clientes_topic
insert.mode=insert
batch.size=1000
```

👉 Aqui, dados chegam via **Kafka** e são gravados no PostgreSQL em paralelo com **4 tasks**.  

---

## ⚠️ Boas práticas de especialista

- Use **particionamento** para dados grandes.  
- Prefira **inserções em lote** ao invés de linha a linha.  
- Em pipelines críticos, implemente **idempotência** (evitar duplicatas).  
- Monitore métricas de ingestão (latência, throughput, locks).  
- Avalie se o banco relacional é a melhor escolha para o volume — em muitos casos, é melhor usar **Data Lake** + **ETL**.  

---

📺 **Vídeo complementar:**  
[Aula 06 – Inserindo dados no SQL](https://www.youtube.com/watch?v=Hj2rkoiW8WY&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=16)

