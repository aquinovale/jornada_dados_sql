# Jornada Engenharia de dados
Bem-vindo ao Mapa do Engenheiro de Dados, um programa prático e desafiador que recria situações reais enfrentadas por profissionais da área de dados. Neste módulo, você será guiado no aprendizado do SQL.

Ao longo do curso, você aprenderá os fundamentos e aplicará técnicas avançadas de SQL, desenvolvendo consultas transacionais e analíticas em SQL, alcançando um nível de maestria.

# Liga Sudoers - Treinamento SQL

Este repositório visa possui uma estrutura para aprendizado do SQL
  * 1 ambiente PostgreSQL 
    
  [Curso SQL](https://www.youtube.com/watch?v=aQd5_vcn18U&list=PLD3-a_5KsN3nuXukrq8kCYtxnZR4FD2nJ)

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

## Pré-requisitos

- Python 3.x
- Docker e Docker Compose


### Instalação do Docker Compose
```bash
sudo apt update
sudo apt install docker-compose-plugin
```

### Verificação da Versão (opcional)
```bash
docker compose version
```

### Parar o PostgreSQL se estiver usando na máquina local (opcional)
```bash
sudo systemctl stop postgresql
```


## Como Executar

### Iniciar Docker pela primeira vez (somente a primeira vez que rodar o processo)
```bash
docker compose up --build
```

### Iniciar Docker pela segunda vez
```bash
docker compose up 
```

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

