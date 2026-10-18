# Signing in with Google

"Continue with Google" has two ways through, and the app tries them in order:

1. **The account sheet.** Android's Credential Manager slides up over Kyron
   with the accounts already on the phone. One tap, no browser. It hands back
   a Google ID token, which Supabase exchanges for a session.
2. **The browser.** Supabase's OAuth redirect, in a Custom Tab, coming back
   through `so.kyron.app://`. Used where there is no sheet (Windows, the web)
   and whenever the sheet cannot be used, with the reason in the app's log.

## Where things stand (October 2026)

- **The browser flow works.** The web OAuth client exists and Supabase holds
  its id and secret.
- **The sheet never appeared.** The app left the web client id for the plugin
  to find in `google-services.json`, and it is not there: that file is
  Firebase's, from project `kyron-1` (number `47436640364`), while the web
  client lives in Google Cloud project number `601078807832`. With no client
  id, Android refuses before a sheet can open ("serverClientId must be
  provided"), and the app went to the browser every time. Build 115's APK
  carries no `default_web_client_id` at all, which is how this was confirmed.
- **Fixed in code:** `lib/services/google_sign_in_service.dart` now names the
  web client itself:
  `601078807832-b3n2mcc7h16fjvvom372for7id18cdpj.apps.googleusercontent.com`.
  A client id is not a secret -- it is in the address bar of every Google
  consent screen -- and you can read it back any time:

  ```bash
  curl -s -o /dev/null -D - \
    "https://zgzvclssemsyctstwgod.supabase.co/auth/v1/authorize?provider=google" \
    | grep -i '^location' | grep -o 'client_id=[^&]*'
  ```

- **Still needed in a console, if it is not there yet:** an **Android** OAuth
  client in that same project, `601078807832`. Credential Manager will only
  mint a token for a web client when the app asking is registered beside it,
  by package name and signing certificate. Without it the sheet fails and the
  app falls back to the browser, as before. Some phones report that failure
  as the reader dismissing the sheet; the app treats a "dismissal" faster
  than a person could manage as the failure it is and goes to the browser
  too. Step 1 below, Android part only, with the development SHA-1
  `AE:03:5B:A3:CA:98:83:04:CB:8E:E5:CD:A1:1B:DE:94:1A:EF:A5:BF` (read back
  out of build 115's APK).

- **On Play installs the sheet is refused; the browser signs in.** Seen on
  the first Play internal-testing builds (0.1.1+647 onwards). Every sign-in
  from them reached Supabase through `/authorize` and `/callback` -- the
  browser -- and none as an ID token, so the sheet failed on the phone,
  before Google minted anything. A Play install is signed with Google's
  **app signing** certificate, not the upload key and not the development
  key, and Credential Manager only trusts a certificate registered as an
  Android client beside the web client. The development key is registered,
  which is why sideloaded builds get the sheet. To fix it, add an Android
  client to project `601078807832` with the **app signing key certificate**
  SHA-1 from Play Console → Test and release → App integrity → App signing
  (step 1 below). The app's System log (Settings → About → System log) now
  carries Google's own words when the sheet fails: `[16] Account reauth
  failed` or `[10] Developer console is not set up correctly` both mean this.

The rest of this document is the full setup, for a new project or a new
signing key.

## 1. Create the OAuth clients

Google Cloud Console → **APIs & Services → Credentials**, with the project
that owns the web client selected -- for Kyron that is project number
`601078807832`, **not** the one behind Firebase `kyron-1`. The Android client
has to sit in the same project as the web client, or Credential Manager will
not tie them together.

**A web client**, which is what the ID token is minted for and what Supabase
authenticates as:

- Create credentials → OAuth client ID → **Web application**
- Authorised redirect URI:
  `https://zgzvclssemsyctstwgod.supabase.co/auth/v1/callback`
- Keep the client ID and client secret for step 2.

**An Android client**, which is what lets Credential Manager trust the app:

- Create credentials → OAuth client ID → **Android**
- Package name: `so.kyron.app`
- SHA-1 certificate fingerprint -- one client per signing key, and a build
  signed with a key Google does not know is the single most common cause of a
  sheet that opens and closes with nothing:

  | build | SHA-1 |
  |:--|:--|
  | development (`app/android/dev-signing/kyron-dev.jks`) | `AE:03:5B:A3:CA:98:83:04:CB:8E:E5:CD:A1:1B:DE:94:1A:EF:A5:BF` |
  | release APKs on GitHub (the upload key, `ANDROID_KEYSTORE_BASE64`) | `4E:B5:E8:BE:91:64:89:07:70:5E:FF:01:F6:53:45:5A:9D:CB:9C:7B` |
  | Play Store | the **app signing key certificate**, from Play Console → Test and release → App integrity → App signing. Not the upload key's, which is listed on the same page |

  A package name and SHA-1 pair can belong to one Cloud project only. If
  Google answers "already in use" when you add one, it is registered
  somewhere else -- often the Firebase project, `kyron-1`, which makes an
  Android client of its own for every fingerprint added under its project
  settings. That one does not count: it is not beside the web client.
  Remove the fingerprint there, then add it here.

  Read a keystore's own with:

  ```bash
  keytool -list -v -keystore app/android/dev-signing/kyron-dev.jks \
    -storepass kyron-development -alias kyron-dev | grep SHA1
  ```

  or read it back out of an APK that already exists, which is the one that
  cannot be wrong:

  ```bash
  apksigner verify --print-certs kyron-0.1.0+80-dev-arm64-v8a.apk
  ```

An app signed by Play App Signing is **not** signed with the key you
uploaded, so the fingerprint from your keystore is the wrong one there. Both
belong in the list.

## 2. Give Supabase the web client

Supabase dashboard → **Authentication → Providers → Google**:

- Client ID: the **web** client from step 1.
- Client secret: its secret.
- Under *Authorized Client IDs*, add the **Android** client ID as well. The
  native sheet mints a token whose audience is the web client, but adding the
  Android one costs nothing and covers the flows that do not.

## 3. The web client id in the app

`GoogleSignInService.serverClientId` carries it, with a
`--dart-define=GOOGLE_SERVER_CLIENT_ID=...` override for a build that should
point elsewhere. If the web client is ever replaced, change it there.

`google-services.json` is not involved in signing in: it only carries Kyron's
OAuth clients when the clients are in the Firebase project, and Kyron's are
not. It is still what push notifications need (see `docs/PUSH.md`).

## How the app uses it

`lib/services/google_sign_in_service.dart`. The native sheet first --
Credential Manager on Android, which lists the accounts already on the device
and returns a Google **ID token**. Supabase exchanges that for a session
directly (`signInWithIdToken`), so no redirect is involved and nothing depends
on `so.kyron.app://` being registered.

A nonce binds the token to the attempt that asked for it: Google is given the
SHA-256, Supabase the original, so the value being committed to never crosses
the network.

When there is no sheet -- Windows, the web -- or when Google refuses for a
configuration reason, the service answers `useBrowser` and the welcome screen
falls back to the OAuth flow it always had, with the reason in the log. That
is deliberate: the browser at least ends on Google's own error page, which
says something, rather than a sheet that closes and leaves the reader with
nothing to report.

## Telling the failures apart

| what you see | what it is |
|:--|:--|
| `Error 401: deleted_client` in a browser tab | Supabase holds a client id Google no longer has. Step 1 and 2. |
| the sheet opens, you pick an account, nothing happens | almost always a missing or wrong SHA-1 for *this* build's signing key. Android's Credential Manager reports several configuration errors as "cancelled" and the plugin cannot tell them from a real dismissal. |
| the sheet opens, you pick an account, and the browser opens instead | the same thing, on a build that falls back (0.1.3 onwards). The System log has Google's words: `[16] Account reauth failed` or `[10] Developer console is not set up correctly` mean the certificate that signed this install is not registered. On a Play install that is the app signing key, never the upload key. |
| "serverClientId must be provided" in the log | the build has no web client id. Step 3. |
| "Google returned no ID token" in the log | the web client id is wrong for this project. Step 3. |
| the browser opens at all on a phone | the native path was not taken; the log line says which of the above it was. |
