# Kyron Architecture

## Overview
Kyron uses a micro-service pattern with a GraphQL/WS gateway and AT-Protocol for portable identity.

## Core Components

| Service | Tech | Responsibility |
| ------- | ---- | -------------- |
| Client | Flutter | UI, AR, offline cache |
| Gateway | NestJS | Auth, routing, rate-limit |
| Feed Svc | NestJS | Embeddings, ranking, Redis Streams |
| Media Svc | GStreamer + Rust | Transcode, caption, thumbnail |
| Identity Node | TypeScript | DID, repo signing, PLC registry |
| Infra | Postgres, Redis, Pinecone, S3-compatible |

## Sequence: Post Upload
1. Client → Gateway (JWT)
2. Gateway → Media Svc (signed URL)
3. Media Svc → S3 + transcode + AI caption
4. Media Svc → Feed Svc (embeddings)
5. Feed Svc → Redis Stream (fan-out)
6. Followers receive WebSocket push

## Diagram
(Place `docs/architecture.png` here or use ASCII below)
```
┌─Flutter(iOS/Android/Web)──┐
│  AR+Camera │  GraphQL/WS  │
└─────▲───────────▲─────────┘
       │             │
┌─────┴───────────┴─────────┐
│       NestJS Gateway           │
└─────▲─────────▲───────────┘
      │gRPC      │GraphQL
┌─────┴────┐ ┌────┴──────────┐
│Feed Svc    │ │  Media Svc      │
└────▲─────┘ └────▲──────────┘
      │Redis         │S3
┌────┴────────────┴────────┐
│  Postgres  │  Pinecone       │
└──────────────────────────┘
```