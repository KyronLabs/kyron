# Google Play internal testing

The _Play internal testing_ workflow (`.github/workflows/play-internal.yml`)
builds a signed App Bundle from whichever branch it is run on and, when it can,
puts it on the Play Console's internal testing track. Run it from the Actions
tab: **Play internal testing → Run workflow**.

## What it needs

| Secret | What it is |
|:--|:--|
| `ANDROID_KEYSTORE_BASE64` | The upload keystore, base64-encoded |
| `ANDROID_KEYSTORE_PASSWORD` | Its store password |
| `ANDROID_KEY_PASSWORD` | The key's password |
| `ANDROID_KEY_ALIAS` | The key's alias |
| `GOOGLE_SERVICES_JSON` | `app/android/app/google-services.json` — see [PUSH.md](PUSH.md) |
| `PLAY_SERVICE_ACCOUNT_JSON` | _Optional._ A service account key that can release to the app |
| `SUPABASE_ANON_KEY`, `GIPHY_API_KEY` | _Optional._ As for every other build |

The build fails, naming what is missing, if any of the first five is absent.
It also fails if the bundle came out signed with anything but the upload key:
the Gradle file falls back to the debug key without `key.properties`, and the
first bundle Play receives decides which upload key it expects from then on.

## The first bundle goes in by hand

Play's API will not accept a bundle for an app that has never had one. So the
first time:

1. Run the workflow. Without `PLAY_SERVICE_ACCOUNT_JSON` it stops after
   building and keeps the bundle as an artifact on the run, for 30 days.
2. Download the artifact and unzip it: inside is `kyron-<version>+<build>.aab`.
3. Play Console → Kyron → **Testing → Internal testing → Create new release**,
   upload the `.aab`, and roll it out.

If the Console asks about Play App Signing, accept it. Google then holds the
key that signs what reaches phones, and the key in these secrets is only the
upload key — which Google can reset if it is ever lost. This is why the keystore
secret should be the one you intend to keep: Play remembers it.

## After that, automatically

1. Google Cloud Console: create a service account in the project linked to
   your Play developer account and download a JSON key for it.
2. Play Console → **Users and permissions → Invite new users**: add the
   service account's email with _Release apps to testing tracks_ for Kyron.
3. Add the JSON file's contents as the `PLAY_SERVICE_ACCOUNT_JSON` secret.

From then on each run uploads to the internal track itself. Choose **draft** for
the status until the app's first release has been rolled out from the
Console; Play refuses a completed release on an app still in draft.

## Version codes

Each run's build number is the run number, so the versionCode is
`100000 + run number` (see `app/android/app/build.gradle.kts`). Play refuses a
versionCode it has already had, so every bundle sent to Play should come from
this workflow — a bundle from the tagged release carries a different sequence
and could collide with one of these.

Testers who sideloaded a development APK have to uninstall it before
installing from Play: the development builds are signed with a different key.
