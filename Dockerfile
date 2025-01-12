FROM node:18.17.1-alpine3.18 AS builder
RUN mkdir /app/
COPY ./package.json ./package-lock.json ./tsconfig.json ./webpack.config.js /app/
RUN ls
WORKDIR /app/
RUN yarn install
COPY ./* /app/
RUN yarn add typescript
RUN yarn build
RUN ls

FROM nginx:1.25.2-alpine as production
COPY --from=builder /app/build /music-player
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
