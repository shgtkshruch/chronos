FROM node:16-alpine AS build

WORKDIR /app

COPY . .
RUN npm install
RUN npm run generate

FROM nginx:stable-alpine AS main

COPY --from=build /app/dist /usr/share/nginx/html
