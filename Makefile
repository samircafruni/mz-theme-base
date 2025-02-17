# Makefile

# Variáveis
DOCKER_COMPOSE = cd src/docker && docker-compose
CONTAINER_WP = wp_app
CONTAINER_DB = wp_mysql
DUMP_DIR = src/backup
MYSQL_USER = root
MYSQL_PASS = root
MYSQL_DB = wordpress

# Cores para output
YELLOW := \033[1;33m
GREEN := \033[1;32m
BLUE := \033[1;34m
RED := \033[1;31m
NC := \033[0m # No Color

.PHONY: up down shell import-db export-db help

# Comando padrão
default: help

# Inicia os containers
up:
	@echo "$(GREEN)Iniciando os containers...$(NC)"
	@$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)Containers iniciados com sucesso!$(NC)"

# Para os containers
down:
	@echo "$(YELLOW)Encerrando os containers...$(NC)"
	@$(DOCKER_COMPOSE) down
	@echo "$(GREEN)Containers encerrados com sucesso!$(NC)"

# Acessa o shell do container WordPress
shell:
	@echo "$(BLUE)Acessando o shell do container WordPress...$(NC)"
	@docker exec -it $(CONTAINER_WP) bash

# Importa o dump do banco de dados
import:
	@echo "$(BLUE)Importando dump do banco de dados...$(NC)"
	@if [ ! -f "$(DUMP_DIR)/dump.sql" ]; then \
		echo "$(RED)Erro: Arquivo dump.sql não encontrado em $(DUMP_DIR)$(NC)"; \
		exit 1; \
	fi
	@docker exec -i $(CONTAINER_DB) mysql -u$(MYSQL_USER) -p$(MYSQL_PASS) $(MYSQL_DB) < $(DUMP_DIR)/dump.sql
	@echo "$(GREEN)Dump importado com sucesso!$(NC)"

# Exporta o banco de dados para um arquivo dump
export:
	@echo "$(BLUE)Exportando banco de dados...$(NC)"
	@mkdir -p $(DUMP_DIR)
	@docker exec $(CONTAINER_DB) mysqldump -u$(MYSQL_USER) -p$(MYSQL_PASS) $(MYSQL_DB) > $(DUMP_DIR)/dump.sql
	@echo "$(GREEN)Banco exportado com sucesso para $(DUMP_DIR)/dump.sql$(NC)"

# Exibe ajuda
help:
	@echo "$(BLUE)Comandos disponíveis:$(NC)"
	@echo "$(YELLOW) make up     $(NC)- $(GREEN)Inicia os containers$(NC)"
	@echo "$(YELLOW) make down   $(NC)- $(GREEN)Encerra os containers$(NC)"
	@echo "$(YELLOW) make shell  $(NC)- $(GREEN)Acessa o terminal do container WordPress$(NC)"
	@echo "$(YELLOW) make import $(NC)- $(GREEN)Importa arquivo dump.sql do diretório $(DUMP_DIR)$(NC)"
	@echo "$(YELLOW) make export $(NC)- $(GREEN)Exporta banco de dados para $(DUMP_DIR)/dump.sql$(NC)"