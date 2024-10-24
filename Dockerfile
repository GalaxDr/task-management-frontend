# Use uma versão mais recente do Debian como base
FROM node:12-bullseye-slim

# Adicionar o repositório de backports para Python 3.10
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository -y 'deb http://deb.debian.org/debian bullseye-backports main' \
    && apt-get update

# Instalar o Python 3.10 e suas dependências
RUN apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o arquivo package.json e yarn.lock para o diretório de trabalho
COPY package.json yarn.lock ./

# Instalar as dependências do projeto usando Yarn
RUN yarn install

# Copiar o restante dos arquivos do projeto para o diretório de trabalho
COPY . .

# Build do projeto
RUN yarn build

# Expor a porta que será usada pelo app
EXPOSE 3001

# Comando para iniciar a aplicação
CMD ["yarn", "start"]
