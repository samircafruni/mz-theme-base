# WordPress Development Environment

Este é um projeto de ambiente de desenvolvimento WordPress utilizando Docker, criado para fins educacionais como parte de um exercício técnico solicitado pela MZ Group.

## Estrutura de Diretórios

```
├── app/
│   └── plugins/       # Diretório wordpress de plugins
│   └── themes/        # Diretório WordPress de temas customizados
│   └── uploads/       # Diretório wordpress de uploads
├── src/
│   ├── conf/          # Arquivos de configuração (php.ini)
│   │── backup/        # Diretório para arquivos de backup do banco
│   ├── database/      # Dados persistentes do MySQL
│   ├── docker/        # Arquivos de configuração Docker
│   ├── logs/          # Logs do PHP, WordPress e Apache
│   └── wordpress/     # Arquivos do WordPress
├── .gitignore
├── Makefile
└── README.md
```

### Detalhamento dos Diretórios

- `app/themes/`: Armazena os temas customizados do WordPress. Os temas padrão são ignorados pelo Git.
- `src/conf/`: Contém arquivos de configuração, como php.ini com configurações otimizadas.
- `src/database/`: Armazena os dados persistentes do MySQL.
- `src/database/dump/`: Diretório específico para arquivos de backup do banco de dados.
- `src/docker/`: Contém o Dockerfile e docker-compose.yml.
- `src/logs/`: Armazena todos os logs gerados pela aplicação.
- `src/wordpress/`: Contém os arquivos core do WordPress.

## Comandos Make Disponíveis

O projeto inclui diversos comandos make para facilitar o desenvolvimento:

- `make up`: Inicia os containers Docker
- `make down`: Encerra os containers Docker
- `make shell`: Acessa o terminal do container WordPress
- `make import`: Importa um arquivo dump.sql localizado em src/database/dump/
- `make export`: Exporta o banco atual para src/database/dump/dump.sql

## Acessos

- WordPress: http://localhost
- phpMyAdmin: http://localhost:8080
- MySQL: localhost:3306

## Recursos Instalados

O ambiente inclui:
- WordPress
- PHP com extensões recomendadas
- Composer
- Node.js (via NVM)
- Yarn
- Corepack

## Considerações de Uso

- Os temas padrão do WordPress são ignorados no controle de versão
- Configurações do PHP podem ser ajustadas em src/conf/php.ini
- Logs são automaticamente direcionados para src/logs/
- Os dados do banco são persistentes em src/database/