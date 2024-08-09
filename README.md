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

Execute o seguinte comando na pasta raiz do projeto para rodar a aplicação via Docker:

```
docker-compose up --build
```

em seguida abra outro terminal e rode o script para importação de dados de exames fictícios para o banco de dados:

```
docker exec exams-server ruby import_from_csv.rb
```

Agora o JSON resultante da consulta no banco de dados é disponibilizado pela API na rota ```http://localhost:3000/tests```.

---

### Testes (RSpec)

Para rodar os testes, execute o comando a seguir com os containers do projeto rodando:

```
docker exec exams-server rspec
```

### Queries

Para fazer queries diretamente no DB, execute o comando a seguir com os containers do projeto rodando:

```
docker exec -it exams-db psql -U my_user -d my_database
```

