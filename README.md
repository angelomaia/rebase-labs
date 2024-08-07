# Rebase Labs

Uma app web para listagem de exames médicos.

---

### Tech Stack

* Docker
* Ruby
* PostgreSQL

---

### Dependências

* Docker
* Docker-compose

---

### Como rodar a aplicação

Rode o comando na pasta raiz do projeto para subir a aplicação no Docker:

```docker-compose up --build```

em seguida abra outro terminal e rode o script para importação de dados de exames fictícios para o banco de dados:

```docker exec relabs-server ruby import_from_csv.rb```

o JSON resultante da consulta no banco de dados é disponibilizado pela API na rota:

```http://localhost:3000/tests```
