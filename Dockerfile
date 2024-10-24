# Use a imagem oficial do Node.js 12 como base
FROM node:12

# Instalar Python 3.10
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Defina o diretório de trabalho
WORKDIR /app

# Copie o arquivo package.json e yarn.lock para o diretório de trabalho
COPY package.json yarn.lock ./

# Instalar as dependências do projeto usando Yarn
RUN yarn install

# Copie o restante dos arquivos do projeto para o diretório de trabalho
COPY . .

# Build do projeto
RUN yarn build

# Expor a porta que será usada pelo app
EXPOSE 3001

# Comando para iniciar a aplicação
CMD ["yarn", "start"]