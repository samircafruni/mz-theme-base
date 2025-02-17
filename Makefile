# Makefile

# Variáveis
DOCKER_COMPOSE = cd src/docker && docker-compose
CONTAINER_WP = wp_app
CONTAINER_DB = wp_mysql
DUMP_DIR = src/database/dump
MYSQL_USER = wordpress
MYSQL_PASS = wordpress
MYSQL_DB = wordpress

.PHONY: up down shell import-db export-db help

# Comando padrão
default: help

# Inicia os containers
up:
	@echo "Iniciando os containers..."
	@$(DOCKER_COMPOSE) up -d
	@echo "Containers iniciados com sucesso!"

# Para os containers
down:
	@echo "Encerrando os containers..."
	@$(DOCKER_COMPOSE) down
	@echo "Containers encerrados com sucesso!"

# Acessa o shell do container WordPress
shell:
	@echo "Acessando o shell do container WordPress..."
	@docker exec -it $(CONTAINER_WP) bash

# Importa o dump do banco de dados
import-db:
	@echo "Importando dump do banco de dados..."
	@if [ ! -f "$(DUMP_DIR)/dump.sql" ]; then \
		echo "Erro: Arquivo dump.sql não encontrado em $(DUMP_DIR)"; \
		exit 1; \
	fi
	@docker exec -i $(CONTAINER_DB) mysql -u$(MYSQL_USER) -p$(MYSQL_PASS) $(MYSQL_DB) < $(DUMP_DIR)/dump.sql
	@echo "Dump importado com sucesso!"

# Exporta o banco de dados para um arquivo dump
export-db:
	@echo "Exportando banco de dados..."
	@mkdir -p $(DUMP_DIR)
	@docker exec $(CONTAINER_DB) mysqldump -u$(MYSQL_USER) -p$(MYSQL_PASS) $(MYSQL_DB) > $(DUMP_DIR)/dump.sql
	@echo "Banco exportado com sucesso para $(DUMP_DIR)/dump.sql"

# Exibe ajuda
help:
	@echo " make up         - Inicia os containers"
	@echo " make down       - Encerra os containers"
	@echo " make shell      - Acessa o terminal do container WordPress"
	@echo " make import-db  - Importa arquivo dump.sql do diretório $(DUMP_DIR)"
	@echo " make export-db  - Exporta banco de dados para $(DUMP_DIR)/dump.sql"