#stage 1
FROM node:16-alpine3.15 as builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build


#stage 2
FROM nginx:alpine

WORKDIR /app
COPY --from=builder /app/dist/ng-test /app
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

ENTRYPOINT ["nginx","-g","daemon off;"]