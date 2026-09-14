# Signing in with Google

Two symptoms, one cause.

    Error 401: deleted_client
    Request details: flowName=GeneralOAuthLite

is what "Continue with Google" answers in the browser, and the reason the
account picker does not appear instead is the same: **the Firebase project
`kyron-1` has no OAuth clients.** Its `google-services.json` carries no
`oauth_client` entries at all -- not the web client (`client_type: 3`) the ID
token needs an audience from, and not the Android client (`client_type: 1`)
that ties a signing certificate to the package name.

`deleted_client` is Google saying, in its own words, that the client id
Supabase hands it does not exist any more. Supabase's end is fine: Google is
enabled on the project, which you can see without logging in to anything:

```bash
curl -H "apikey: $SUPABASE_ANON_KEY" \
  https://zgzvclssemsyctstwgod.supabase.co/auth/v1/settings
```

`"google": true`. So nothing in this repository can fix it, and nothing in
this repository is what broke it. The four steps below are all in consoles.

## 1. Create the OAuth clients

Google Cloud Console → **APIs & Services → Credentials**, with the project
that backs Firebase `kyron-1` selected.

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
  | release | whatever `ANDROID_KEYSTORE_BASE64` holds |
  | Play Store | the Play App Signing certificate, from Play Console → Setup → App signing |

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

## 3. Re-download `google-services.json`

Firebase console → Project settings → Your apps → Android → download
`google-services.json`. It will now contain the `oauth_client` entries, which
is what `google_sign_in` reads on Android -- with them present, no client id
has to be named in Dart at all.

Put the contents in the `GOOGLE_SERVICES_JSON` repository secret (the file
itself is gitignored; see `docs/PUSH.md`), and drop a copy at
`app/android/app/google-services.json` for local builds.

Check what you downloaded before you trust it:

```bash
python3 -c "import json;d=json.load(open('app/android/app/google-services.json'));\
print([(o['client_type'], o.get('android_info',{}).get('certificate_hash')) \
for c in d['client'] for o in c.get('oauth_client',[])])"
```

An empty list is the state this document exists for.

## 4. Nothing else

`GOOGLE_SERVER_CLIENT_ID` exists as a `--dart-define` for builds where
`google-services.json` is not the source of truth. On Android with a complete
one, leave it unset.

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
| "Google returned no ID token" in the log | no web OAuth client in `google-services.json`. Step 1 and 3. |
| the browser opens at all on a phone | the native path was not taken; the log line says which of the above it was. |
