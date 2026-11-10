# syntax = docker/dockerfile:1

# Adjust NODE_VERSION as desired
ARG NODE_VERSION=22.21.1
FROM node:${NODE_VERSION}-slim AS base

# NestJS/Prisma app lives here
WORKDIR /app

# Set production environment
ENV NODE_ENV="production"


# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential node-gyp openssl pkg-config python-is-python3

# Install node modules
COPY package-lock.json package.json ./
RUN npm ci --include=dev

# Generate Prisma Client
COPY prisma .
RUN npx prisma generate

# Copy application code
COPY . .

# Build application
RUN npm run build

# What runs needs no compiler, test runner or linter. Pruned here, in the
# stage that is thrown away, so the final image never holds them. The Prisma
# CLI is a production dependency: scripts/start.sh migrates with it.
RUN npm prune --omit=dev


# Final stage for app image
FROM base

# Install packages needed for deployment
RUN apt-get update -qq && \
    # ffmpeg normalises uploaded clips and cuts their posters. Without
    # it the API still runs and clips are stored exactly as they
    # arrive -- TranscodeService says so at boot rather than failing.
    apt-get install --no-install-recommends -y openssl ffmpeg && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Only what runs: the compiled server, its dependencies, the schema and
# migrations, and the start script. Not the source, not the tests, not a .env
# that happened to be in the build context.
COPY --from=build --chown=node:node /app/dist ./dist
COPY --from=build --chown=node:node /app/node_modules ./node_modules
COPY --from=build --chown=node:node /app/prisma ./prisma
COPY --from=build --chown=node:node /app/scripts ./scripts
COPY --from=build --chown=node:node /app/package.json ./package.json

# Not root. ffmpeg parses files strangers send; whatever a bug in it could
# do, it does as an account that owns nothing but /app.
USER node

# Start the server by default, this can be overwritten at runtime
EXPOSE 8080
CMD [ "npm", "run", "start" ]
