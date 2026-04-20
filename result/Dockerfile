FROM node:18-slim

# Create non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

WORKDIR /app

# Copy package files first for better caching
COPY package*.json .
RUN npm install --omit=dev

# Copy app code
COPY . .

# Switch to non-root user
USER appuser

EXPOSE 4000

CMD ["node", "server.js"]

