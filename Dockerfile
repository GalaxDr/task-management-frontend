# Use a imagem oficial do Node.js 14 como base
FROM node:14

# Defina o diretório de trabalho
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
