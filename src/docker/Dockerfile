# ./src/docker/Dockerfile
FROM wordpress:latest

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    unzip \
    git \
    curl \
    nodejs \
    npm

# Instalar extensões PHP recomendadas
RUN docker-php-ext-install \
    pdo_mysql \
    mysqli \
    zip \
    exif \
    intl \
    opcache

# Configurar e instalar GD com suporte a WebP
RUN docker-php-ext-configure gd --with-jpeg --with-webp && \
    docker-php-ext-install gd

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar NVM
ENV NVM_DIR /usr/local/nvm
RUN mkdir -p $NVM_DIR && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Adicionar NVM ao PATH
ENV NODE_VERSION 18
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Instalar Node.js usando NVM
RUN . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# Remover instalações existentes do Yarn
RUN rm -rf /usr/local/bin/yarn /usr/local/bin/yarnpkg && \
    npm uninstall -g yarn

# Instalar Yarn e Corepack
RUN npm install -g yarn@latest && \
    npm install -g corepack && \
    corepack enable && \
    corepack prepare yarn@stable --activate && \
    yarn --version || true

# Instalar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp --info

# Configurar permissões
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html