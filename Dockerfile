# Build stage
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build -- --configuration production

# Runtime
FROM nginx:alpine

COPY --from=build /app/dist/Frontend/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
