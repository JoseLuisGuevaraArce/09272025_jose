# Etapa 1: Compilación de Angular
FROM node:18 AS build

WORKDIR /app

# Copiar dependencias y paquetes
COPY package*.json ./
RUN npm install

# Copiar el código fuente
COPY . .

# Generar la build de Angular
RUN npm run build --prod

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Elimina la configuración default de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia la build de Angular a la carpeta de Nginx
COPY --from=build /app/dist/angularbasic /usr/share/nginx/html

# Copia un archivo de configuración de Nginx (opcional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
