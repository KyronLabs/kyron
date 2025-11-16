# Kyron Repository Folder Structure


kyron/                          # repository root
│
├── app/                        # Flutter cross-platform client
│   ├── lib/
│   │   ├── core/               # DI, constants, utilities
│   │   ├── features/           # feed, camera, auth, profile widgets
│   │   └── l10n/               # localization (.arb files)
│   ├── test/                   # unit & widget tests
│   ├── integration_test/       # e2e flutter_driver tests
│   └── pubspec.yaml            # Flutter dependencies
│
├── api/                        # NestJS backend monorepo
│   ├── src/
│   │   ├── gateway/            # GraphQL / WebSocket entry
│   │   ├── feed/               # vector ranking service
│   │   ├── media/              # upload & transcode endpoints
│   │   ├── identity/           # DID / AT-Protocol logic
│   │   └── common/             # shared DTOs, guards, filters
│   ├── test/                   # Jest unit & integration tests
│   └── package.json            # Node dependencies & scripts
│
├── media/                      # stand-alone media micro-services
│   ├── Dockerfile              # GStreamer + Rust caption pipeline
│   └── src/                    # Rust or Go caption / thumbnail workers
│
├── identity/                   # AT-Protocol node implementation
│   ├── plc/                    # DID registry logic
│   ├── repo/                   # repo signing & storage
│   └── Dockerfile
│
├── infra/                      # infrastructure-as-code
│   ├── docker-compose.dev.yml  # local Postgres, Redis, Pinecone-mock
│   ├── k8s/                    # staging / prod manifests (WIP)
│   └── terraform/              # cloud resource definitions (WIP)
│
├── docs/                       # extra documentation
│   ├── architecture.png        # drawio / png diagram
│   └── investor_one_pager.md   # 1-page pitch sheet
│
├── scripts/                    # dev & ops helper scripts
│   ├── seed.js                 # populate local db
│   ├── migrate.sh              # run DB migrations
│   └── dev.sh                  # boot entire stack with one command
│
└── tests/                      # cross-service e2e tests
├── playwright/             # web e2e specs
└── postman_collections/    # API smoke tests

```