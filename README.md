# Jornada Engenharia de dados
Bem-vindo ao Mapa do Engenheiro de Dados, um programa prático e desafiador que recria situações reais enfrentadas por profissionais da área de dados. Neste módulo, você será guiado no aprendizado do SQL.

Ao longo do curso, você aprenderá os fundamentos e aplicará técnicas avançadas de SQL, desenvolvendo consultas transacionais e analíticas em SQL, alcançando um nível de maestria.

# Liga Sudoers - Treinamento SQL

Este repositório visa possui uma estrutura para aprendizado do SQL
  * 1 ambiente PostgreSQL 
    
  [Curso SQL](https://www.youtube.com/watch?v=aQd5_vcn18U&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ)

  [Aula 01](https://www.youtube.com/watch?v=Y6LnIujlbhc&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ&index=10)

## Perfil e responsabilidades

Perfis de profissionais e suas responsabilidades no dia a dia dos processos mostrados.  
 - Data Analyst ou Business Intelligence (BI) Analyst

### Data Analyst ou Business Intelligence (BI) Analyst
Criação de Dashboards

    Profissional: Data Analyst ou Business Intelligence (BI) Analyst
        Responsabilidades:
            Criar visualizações e relatórios interativos para tomada de decisão.
            Utilizar ferramentas de BI como Power BI, Tableau, Looker ou Metabase.
            Definir métricas e KPIs com base nos requisitos de negócios.
            Trabalhar diretamente com as partes interessadas para transformar dados em insights acionáveis.


## 🎯 Objetivo
Em **2 passos** você terá o banco PostgreSQL rodando localmente com tabelas e dados de exemplo prontos para praticar.  
Não precisa instalar PostgreSQL local nem configurar nada complicado.

---

## 📦 Pré-requisitos
- [Docker Desktop](https://www.docker.com/products/docker-desktop) (Windows/Mac) ou Docker Engine (Linux)  
- Docker Compose (já incluso no Docker Desktop)  
- ~2 GB livres em disco  



## 🚀 Como começar

```bash
# 1. Clone este repositório
git clone https://github.com/aquinovale/jornada_dados_sql
cd jornada_dados_sql

# 2. Suba o container (executa o DDL automaticamente na 1ª vez)
docker compose up -d --build


### Parar o Docker Compose caso esteja rodando
```bash
docker compose stop
```


## Acessar PostgreSQL
```bash
docker exec -it postgres_liga_sudoers_sql bash 
psql -U sudoers -d liga_sudoers -h postgres_liga_sudoers
```

Senha: password

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

## Licença

Este projeto está licenciado sob a Licença SUDOERS.

