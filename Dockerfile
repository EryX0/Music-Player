FROM node:slim as base

ENV NODE_ENV=production
WORKDIR /app

COPY package*.json ./
RUN npm ci --production && npm cache clean --force

COPY . .

# Build stage
FROM base as build
WORKDIR /app
RUN npm install
RUN npm install -D webpack webpack-cli
RUN npm run build

# Production stage
FROM base as prod
WORKDIR /app
COPY --from=build /app/dist ./dist

CMD ["node", "dist/bundle.js"]
