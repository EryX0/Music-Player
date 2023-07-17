# Stage 1: Build the application
FROM node:slim as build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci --production=false

# Copy the source code
COPY . .

# Build the TypeScript code
RUN npm run build

# Stage 2: Create the production image
FROM node:slim as production

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install only production dependencies
RUN npm ci --production

# Copy the built files from the build stage
COPY --from=build /app/dist ./dist

# Expose the port your application listens on (if applicable)
# EXPOSE 3000

# Set the command to run your application
CMD ["node", "dist/bundle.js"]
