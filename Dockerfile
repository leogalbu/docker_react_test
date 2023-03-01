# Definisco il nome di questa fase come builder, è la base infatit di building, separata da quella di run
FROM node:16-alpine as builder

# Avrò un cartella del tipo /app/build
WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# Seconda fase, quella di run
FROM nginx

# Copio la build folder creata nella base builder (npm run build)
# Copia dalla fase precedente (builder) la cartella /app/build dentro /usr/share/nginx/html => questod deriva dalla documentazione di nginx
COPY --from=builder /app/build /usr/share/nginx/html

# docker build . creo l'immagine
# docker run -p 8080:80 id_image mappo la porta 8080 della mia macchina a quella 80 del container, che è quella di nginx di defULT