# Rebase Labs

Uma app web para listagem de exames médicos.

## Índice

- [Tech Stack](#tech-stack)
- [Dependências](#dependências)
- [Rodando a aplicação](#rodando-a-aplicação)
- [Testes (RSpec)](#testes-rspec)
- [Queries](#queries)
- [Desligando a Aplicação](#desligando-a-aplicação)
- [API](#api)
  - [GET /tests](#get-tests)
  - [GET /test/:token](#get-teststoken)
  - [POST /import](#post-import)
- [Prints da App](#imagens)


## Tech Stack

* Docker
* Ruby
* Sinatra
* PostgreSQL
* RSpec
* Sidekiq
* Redis

## Dependências

* Docker


## Rodando a aplicação

Execute o seguinte comando na pasta raiz do projeto para rodar a aplicação via Docker:

```
make up
```

Caso queira rodar a aplicação mantendo o log dos servidores visível no terminal, execute:

```
make up-info
```

para popular o banco de dados com uma lista de exames, execute:

```
make import
```


## Testes (RSpec)

Para rodar os testes, execute o comando a seguir após ter rodado a aplicação pelo menos uma vez (para montar os containers):

```
make test
```

Os testes também podem rodar individualmente para o server (```make test-server```) e para a app front-end (```make test-app```)


## Queries

Para fazer queries diretamente no Banco de Dados, execute o comando a seguir com a aplicação rodando:

```
make sql
```


## Desligando a aplicação

Para derrubar os containers da aplicação, execute o comando:

```
make down
```

Para apagar todos os containers e volumes do projeto na sua máquina, execute:

```
make clean
```


## API

O back-end da aplicação é o ```service``` chamado ```server``` no docker-compose.yml, que tem o container_name de ```exams-server```. Com a aplicação rodando, o ```server``` disponibiliza três endpoints:

### ```GET /tests```

Retorna um JSON com todos os exames resultantes de uma Query no banco de dados, como no exemplo:

```json
[
  {
    "result_token": "IQCZ17",
    "result_date": "2021-08-05",
    "cpf": "048.973.170-88",
    "name": "Emilly Batista Neto",
    "email": "gerald.crona@ebert-quigley.com",
    "birthday": "2001-03-11",
    "doctor": {
      "crm": "B000BJ20J4",
      "crm_state": "PI",
      "name": "Maria Luiza Pires"
    },
    "tests": [
      {
        "type": "hemácias",
        "limits": "45-52",
        "result": "97"
      },
      {
        "type": "leucócitos",
        "limits": "9-61",
        "result": "89"
      }
    ]
  },
  {
    "result_token": "0W9I67",
    "result_date": "2021-07-09",
    "cpf": "048.108.026-04",
    "name": "Juliana dos Reis Filho",
    "email": "mariana_crist@kutch-torp.com",
    "birthday": "1995-07-03",
    "doctor": {
      "crm": "B0002IQM66",
      "crm_state": "SC",
      "name": "Maria Helena Ramalho"
    },
    "tests": [
      {
        "type": "plaquetas",
        "limits": "11-93",
        "result": "18"
      },
      {
        "type": "glicemia",
        "limits": "25-83",
        "result": "6"
      }
    ]
  }
]
```

### ```GET /tests/:token```

A partir de um params[:token], retorna um JSON com o exame que tem seu token rastreado a partir uma Query no banco de dados, como no exemplo:

```
GET tests/2VPICQ

[
  {
    "result_token": "2VPICQ",
    "result_date": "2021-04-23",
    "cpf": "077.411.587-40",
    "name": "Ígor Moura",
    "email": "edelmira.stanton@lowe-blick.io",
    "birthday": "1991-02-27",
    "doctor": {
      "crm": "B000BJ20J4",
      "crm_state": "PI",
      "name": "Maria Luiza Pires"
    },
    "tests": [
      {
        "type": "hemácias",
        "limits": "45-52",
        "result": "81"
      },
      {
        "type": "leucócitos",
        "limits": "9-61",
        "result": "61"
      },
      {
        "type": "plaquetas",
        "limits": "11-93",
        "result": "77"
      }
    ]
  }
]
```

### ```POST /import```

A partir de um arquivo CSV recebido como ```params[:file]```, executa uma operação lógica em que, caso o CSV seja um arquivo válido, executa um ```ImportJob``` para importação dos dados para serem armazenados no banco de dados.

As respostas podem ser:

```
  response.status = 200
  response.body = { success: true }
```

ou:

```
  response.status = 400
  response.body = { success: false, error: 'Descrição do erro' }
```

## Prints da App

![vazio.jpg](https://raw.githubusercontent.com/angelomaia/angelomaia.github.io/master/images/Screenshot%20from%202024-08-14%2021-43-55.png)


![populado.jpg](https://raw.githubusercontent.com/angelomaia/angelomaia.github.io/master/images/Screenshot%20from%202024-08-14%2021-44-06.png)