# Live: the decision before the code

*Lives here until `kyron-live` exists; it belongs in that repository's
`docs/DECISION.md`.*

Nothing is built. This document exists so the first commit is not also the
architecture, because Live is the one part of Kyron where the wrong early
choice costs real money every month rather than a refactor.

Prices below were checked in September 2026 and are list rates. **Re-check them
before committing** — every vendor here has changed pricing within the last
year, and one of them changed it in a way that inverts part of this comparison.

## The question that decides everything else

**Is Kyron Live broadcast or interactive?**

- **Broadcast** — one creator, many watchers. Instagram Live, TikTok Live.
  Viewers can comment but do not appear. HLS is fine; two to five seconds of
  latency is fine, because nobody is having a conversation across it.
- **Interactive** — several people in a room, on camera, talking. Guests
  brought up on stream, co-hosting. This needs WebRTC and sub-second latency,
  because a two-second delay makes conversation impossible.

Everything below follows from that answer, and the two have different vendors,
different costs, and different failure modes. Answer it first.

Note that Kyron already has **Spaces**, built as an audio *recording* rather
than a live room. If Live is interactive, Live and Spaces are the same system
with the camera on or off, and Spaces should be rebuilt on it rather than left
as a separate thing.

## What each option costs

A worked example, so the numbers are comparable rather than abstract: **100
concurrent viewers, one hour a day, thirty days, at 1.5 Mbps.** That is 180,000
delivered minutes and about 1,978 GB of downstream bandwidth a month.

| | Monthly | Latency | You operate |
|:--|--:|:--|:--|
| **Cloudflare Stream** | **~$189** | 2–5s (LL-HLS) | Nothing |
| **Mux** | ~$250–400 | 2–5s (LL-HLS) | Nothing |
| **LiveKit Cloud** | ~$288 + tier ($50 or $500) | sub-second | Nothing |
| **Self-hosted SFU** | ~$40 bandwidth + servers + your time | sub-second | Media servers, in several regions |

Cloudflare: $180 delivery (180,000 min at $1/1,000) plus $9 storage if the
stream is recorded (at $5/1,000 min/month). Ingest and encoding are free.

LiveKit Cloud: $90 in participant minutes (at $0.0005) plus ~$198 bandwidth (at
$0.10/GB downstream; upstream became free in 2026). Then the tier on top.

### The difference that is easy to miss

**Cloudflare charges per delivered minute regardless of resolution. LiveKit
charges per gigabyte.** So a 4K stream costs Cloudflare exactly what a 480p
stream costs, and costs LiveKit roughly nine times more. If Kyron's creators
stream at high quality, that gap widens with every step up in resolution.

Read that the other way before dismissing LiveKit: if streams are mostly
low-bitrate — a phone camera in a dim room — LiveKit's bandwidth line shrinks
and the comparison tightens.

### Self-hosting

The bandwidth is genuinely cheap: ~2 TB of egress is $20–40 on Hetzner or
similar. That is the number that makes self-hosting look attractive, and it is
the wrong number to look at.

An SFU has to be *near* its viewers or latency is bad, so one machine is not an
answer — this is the part of Kyron that breaks the "one machine is enough"
assumption that holds everywhere else. 100 concurrent viewers at 1.5 Mbps is
150 Mbps of sustained egress that something must actually push, in more than
one region, with failover, while the API keeps serving. That is an operations
project, not a deployment.

Self-host when the vendor bill is large enough to pay for somebody to run it.
At $189/month it is not.

## The recommendation

**Cloudflare Stream, for broadcast, and defer interactive until somebody asks
for it.**

- Cheapest of the three managed options at this scale, and the only one whose
  price does not punish quality.
- Ingest and encoding are free, so a stream that nobody watches costs nothing.
- No SFU to run, in any region.
- **The recording lands in a pipeline that already exists.** A finished stream
  is a video file; Kyron already stores those, cuts posters from them, and
  re-encodes them on a queue ([MEDIA_JOBS.md](MEDIA_JOBS.md)). A Live
  recording becoming an ordinary Post is close to free.

Switch to LiveKit the moment the product needs two people on camera at once.
That is a real rewrite of the client, not a config change, which is why the
first question in this document matters.

## What Kyron's API has to expose, either way

The vendor changes; this list does not. Build against this shape and swapping
vendors stays possible.

- **Start a session** — returns ingest credentials (RTMP/SRT URL and key) or a
  room token. Server-issued, never client-derived.
- **End a session.**
- **A viewer token or playback URL**, issued per viewer, so that *who may
  watch* runs through Kyron's existing block and mute rules rather than being
  a public URL anybody can share out of the app.
- **List what is live now**, for the feed and Explore.
- **A webhook receiver** for started, ended, and recording-ready. Recording-ready
  is what turns the stream into a Post.

## The part nobody enjoys planning

**Live video cannot be pre-moderated.** Every other content type in Kyron can
be reviewed after the fact and removed; a live stream is doing its damage while
it is happening. This is the highest-risk surface in the whole product and the
plan for it has to exist *before* launch, not after the first incident.

At minimum, before this ships:

- A way for a viewer to report a stream that reaches somebody in seconds, not
  hours.
- A way to kill a stream immediately, from outside the app.
- A decision about who is allowed to go live at all. "Everybody, immediately"
  is the setting that has gone wrong for every platform that chose it.
- Whether recordings are kept by default, and for how long — this is an
  evidence question as much as a storage one.

Costing this properly probably matters more than the difference between $189
and $288 a month.

## Open, and needing a human

1. Broadcast or interactive? Everything follows from it.
2. Does Live replace Spaces, or sit beside it?
3. Who may go live?
4. Are streams recorded by default?

## Sources

Checked September 2026:

- [Cloudflare Stream pricing](https://developers.cloudflare.com/stream/pricing/)
- [LiveKit pricing](https://livekit.com/pricing)
- [Mux video pricing](https://www.mux.com/docs/pricing/video)
