COMPOSE_FILE = docker-compose.yml

.PHONY: all
all: build

.PHONY: up
up:
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

.PHONY: server-shell
server-shell:
	docker-compose -f $(COMPOSE_FILE) exec server /bin/bash

.PHONY: app-shell
app-shell:
	docker-compose -f $(COMPOSE_FILE) exec app /bin/bash
