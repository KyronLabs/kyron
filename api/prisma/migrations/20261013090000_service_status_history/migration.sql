-- The service's record of its own health, for the status screen's uptime
-- history.
--
-- ServiceDay counts one component's self-checks per day rather than storing
-- each one: three components checked every five minutes is under a thousand
-- rows a year. ServiceIncident is a stretch of failing checks, opened by the
-- first failure and closed by the first pass.
--
-- Additive only: two new tables, nothing existing touched.

CREATE TABLE "ServiceDay" (
    "day" DATE NOT NULL,
    "component" TEXT NOT NULL,
    "checks" INTEGER NOT NULL DEFAULT 0,
    "failures" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ServiceDay_pkey" PRIMARY KEY ("day","component")
);

CREATE TABLE "ServiceIncident" (
    "id" UUID NOT NULL,
    "component" TEXT NOT NULL,
    "startedAt" TIMESTAMPTZ NOT NULL,
    "endedAt" TIMESTAMPTZ,
    "detail" TEXT,

    CONSTRAINT "ServiceIncident_pkey" PRIMARY KEY ("id")
);

-- The status screen reads recent incidents, newest first.
CREATE INDEX "ServiceIncident_startedAt_idx" ON "ServiceIncident"("startedAt");

-- Each check looks for the component's open incident.
CREATE INDEX "ServiceIncident_component_endedAt_idx" ON "ServiceIncident"("component", "endedAt");

-- Shut to the anon key, like every other table the API owns. The history is
-- public through GET /health/history, which reads it with the API's own
-- connection.
REVOKE ALL ON TABLE "ServiceDay" FROM anon, authenticated;
ALTER TABLE "ServiceDay" ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE "ServiceIncident" FROM anon, authenticated;
ALTER TABLE "ServiceIncident" ENABLE ROW LEVEL SECURITY;
