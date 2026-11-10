# Security Policy

## Supported versions

Only the latest release of the app, and the API as currently deployed, get
security fixes. Kyron is pre-1.0 and ships often; update to the newest
version before reporting.

## Reporting a vulnerability

Report it privately through GitHub:
**Security → Report a vulnerability** on this repository
(<https://github.com/KyronLabs/kyron/security/advisories/new>).

Please do not open a public issue, pull request or discussion for it.

Include what you can of:

- what is affected (app version, platform, API route),
- how to reproduce it,
- what someone could do with it.

We aim to acknowledge a report within three working days and to keep you
told of progress until it is fixed. We will credit you in the advisory
unless you would rather we did not.

## Scope

In scope: this repository's code, the Android and Windows apps built from
it, and the Kyron API. Out of scope: denial of service by volume, reports
that need a rooted or already-compromised device, and findings in
third-party services (Supabase, Render, Google) themselves; report those to
the service.

Please test only against accounts you own, and stop and report as soon as you
can read or change somebody else's data.
