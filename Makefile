COMPOSE_FILE = docker-compose.yml

.PHONY: all
all: build

.PHONY: up
up:
	docker-compose -f $(COMPOSE_FILE) up --build -d

.PHONY: up-info
up-info:
	docker-compose -f $(COMPOSE_FILE) up --build

.PHONY: down
down:
	docker-compose -f $(COMPOSE_FILE) down

.PHONY: test-server
test-server:
	docker-compose -f $(COMPOSE_FILE) run --rm server bundle exec rspec

.PHONY: test-app
test-app:
	docker-compose -f $(COMPOSE_FILE) run --rm app bundle exec rspec

.PHONY: test
test: test-server test-app

.PHONY: import
import:
	docker exec exams-server ruby import_from_csv.rb

.PHONY: server-bash
server-bash:
	docker-compose -f $(COMPOSE_FILE) run server /bin/bash

.PHONY: app-bash
app-bash:
	docker-compose -f $(COMPOSE_FILE) run app /bin/bash

.PHONY: sql
sql:
	docker exec -it exams-db psql -U my_user -d my_database

.PHONY: clean
clean:
	docker-compose -f $(COMPOSE_FILE) down -v