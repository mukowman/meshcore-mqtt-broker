# Dockerfile for meshcore-mqtt-broker

FROM node:22-alpine

# Build dependencies for better-sqlite3
RUN apk add --no-cache python3 make g++

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy the rest of the source
COPY . .

# Environment defaults – override in Unraid
ENV NODE_ENV=production \
    ABUSE_PERSISTENCE_PATH=/data/abuse-detection.db

# WebSocket MQTT port (from .env.example)
EXPOSE 8883

# Run the broker with the existing start script
CMD ["npm", "start"]
