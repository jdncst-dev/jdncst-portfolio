# Stage 1: Builder
FROM node:18-alpine AS builder

# Install dependencies
RUN apk add --no-cache libc6-compat

RUN npm install -g pnpm

WORKDIR /app

COPY package*.json ./
RUN pnpm install

COPY . .

RUN pnpm run build

# Stage 2: Production
FROM node:18-alpine AS production

RUN npm install -g pnpm

WORKDIR /app

# Only copy the built output and production deps
COPY package*.json ./
RUN pnpm install --prod

COPY --from=builder /app/.next .next
COPY --from=builder /app/next.config.ts ./
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000

CMD ["pnpm", "start"]