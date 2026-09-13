# The development signing key

`kyron-dev.jks` signs the APKs the Development Build workflow publishes. It is
committed on purpose, and this file is why.

## What it fixes

Without it, `app/build.gradle.kts` falls back to `signingConfigs.debug`, and on
a CI runner there is no `~/.android/debug.keystore` — so Gradle mints one. Four
development builds, four certificates, each created minutes before it signed
its own APK:

    build 74   CN=Android Debug   c718ffd874…   notBefore 12:48:15
    build 75   CN=Android Debug   d7c5155197…   notBefore 18:12:08
    build 76   CN=Android Debug   e44a62f0f6…   notBefore 19:14:26

Android refuses to install a package whose signature does not match the one
already on the phone — `INSTALL_FAILED_UPDATE_INCOMPATIBLE` — and OEM
installers report that as **"App not installed as package appears to be
invalid"**. So every development build after the first would not install, and
uninstalling first was the only way through.

One key, in the repository, ends that.

## Is committing a signing key safe?

For *this* key, yes, and the reasoning matters because it does not generalise.

- Its password is in this file: **`kyron-development`**, alias `kyron-dev`. It
  is not a secret and is not treated as one.
- It signs development builds only. The release workflow
  (`.github/workflows/flutter-release.yml`) requires `ANDROID_KEYSTORE_BASE64`
  and **fails without it**, so nothing published to a store can ever be signed
  with this.
- It is no more exposed than what it replaces. Android's own debug keystore has
  the password `android` and is on every machine with the SDK installed; every
  debug build in the world is signed with a key anybody can produce.

What it does mean: somebody could build an APK signed with this key that
Android would accept as an update to an installed *development* build. That is
a sideload attack on a developer's own phone, and it is the price of the builds
installing at all.

If that price is too high, the workflow prefers a secret when one exists —
see below — and this file becomes dead weight rather than a hole.

## Using a secret instead

The workflow takes the first of these that is set:

1. `ANDROID_DEV_KEYSTORE_BASE64` + `ANDROID_DEV_KEYSTORE_PASSWORD` +
   `ANDROID_DEV_KEY_PASSWORD` + `ANDROID_DEV_KEY_ALIAS`
2. `ANDROID_KEYSTORE_BASE64` + the matching release passwords and alias
3. this keystore

To move to 1:

```bash
keytool -genkeypair -keystore kyron-dev.jks \
  -storepass '<pick one>' -keypass '<pick one>' \
  -alias kyron-dev -keyalg RSA -keysize 4096 -validity 10950 \
  -dname "CN=Kyron Development Build, O=KyronLabs, C=GB"

base64 -w0 kyron-dev.jks    # paste into the repository secret
```

Then delete this directory and the `!` lines in the two `.gitignore` files.

**Whichever key you switch to, everybody who has a development build installed
has to uninstall it once.** A different key is a different app as far as
Android is concerned. There is no way around that and no way to do it twice.

## fingerprint.txt

The SHA-256 of the certificate in this keystore. The Development Build
workflow's installability check compares every APK it produced against it and
fails on a mismatch — so if this keystore is ever replaced without the
fingerprint being updated, or the signing config silently stops taking effect,
the build says so instead of publishing something nobody can install.

Regenerate it with:

```bash
keytool -list -v -keystore kyron-dev.jks -storepass kyron-development \
  -alias kyron-dev | sed -n 's/.*SHA256: *//p' | tr -d ': ' | tr 'A-F' 'a-f'
```
