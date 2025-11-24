# ===============================================
# Kyron API Docker + Prisma Setup Script (Windows)
# ===============================================

# Step 1: Set environment variables
$env:DATABASE_URL="postgresql://kyron:kyronpass@host.docker.internal:5432/kyron_db?schema=public"
$env:JWT_SECRET="replace_this_with_a_strong_secret"
$env:JWT_EXPIRES="15m"
$env:JWT_REFRESH_EXPIRES="7d"
$env:REDIS_HOST="localhost"
$env:REDIS_PORT="6379"
$env:PORT="3000"
$env:RATE_LIMIT_MAX="200"

Write-Host "✅ Environment variables loaded"

# Step 2: Stop & remove existing containers and volumes
Write-Host "🛑 Stopping and removing existing Docker containers..."
docker compose down -v

# Step 3: Start fresh containers
Write-Host "🚀 Starting Docker containers..."
docker compose up -d

# Step 4: Wait until Postgres is ready
Write-Host "⏳ Waiting for Postgres to become ready..."
$maxRetries = 15
$retry = 0
$pgReady = $false

while (-not $pgReady -and $retry -lt $maxRetries) {
    Start-Sleep -Seconds 3
    try {
        docker exec -it kyron_postgres psql -U kyron -d kyron_db -c "SELECT 1;" | Out-Null
        $pgReady = $true
    } catch {
        Write-Host "Waiting for Postgres... retry $($retry+1)"
        $retry++
    }
}

if (-not $pgReady) {
    Write-Error "❌ Postgres did not become ready in time. Check your Docker containers."
    exit 1
}

Write-Host "✅ Postgres is ready"

# Step 5: Generate Prisma client
Write-Host "🔧 Generating Prisma client..."
npx prisma generate

# Step 6: Run migrations
Write-Host "📦 Running Prisma migrations..."
npx prisma migrate dev --name init --skip-seed

# Step 7: Seed database
Write-Host "🌱 Seeding database..."
npx ts-node prisma/seed.ts

# Step 8: Start NestJS dev server
Write-Host "⚡ Starting Kyron dev server..."
npm run start:dev
