FROM node:slim as base

ENV NODE_ENV=production
WORKDIR /app

COPY package*.json ./
RUN npm ci --production && npm cache clean --force

COPY dist ./

CMD ["node", "bundle.js"]
