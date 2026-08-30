# Dockerfile for Flutter web app deployment
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    xz-utils \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
ENV FLUTTER_VERSION=3.19.5
RUN curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar xf flutter.tar.xz -C /opt \
    && rm flutter.tar.xz

ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:$PATH"

# Enable Flutter web
RUN flutter config --enable-web

# Install project dependencies
WORKDIR /app
COPY . .
RUN flutter pub get

# Build the web app
RUN flutter build web --release --web-renderer canvaskit

# Serve the app
EXPOSE 8080
CMD ["sh", "-c", "cd /app/build/web && python3 -m http.server 8080 --bind 0.0.0.0"]
