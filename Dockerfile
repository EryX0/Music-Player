FROM node:slim as base

ENV NODE_ENV=production
WORKDIR /app

COPY package*.json ./
RUN npm ci --production && npm cache clean --force

COPY . .

RUN npm install --only=development
RUN npm run build

CMD ["node", "dist/bundle.js"]
