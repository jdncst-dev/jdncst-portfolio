# Install dependencies only when needed
FROM node:20-alpine AS deps
WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy package files and install dependencies
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# Rebuild the source code only when needed
FROM node:20-alpine AS builder
WORKDIR /app

# Install pnpm in this stage too!
RUN npm install -g pnpm

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN pnpm build

# Production image, copy only necessary files
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Install pnpm in runner if you use it (for 'pnpm start')
RUN npm install -g pnpm

# Copy built app and node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/src ./src

EXPOSE 3000

CMD ["pnpm", "start"]
