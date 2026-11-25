# Official development signing

The previous development signing certificate is retired. Its public
certificate and fingerprint remain as parser test fixtures and as a deny
list entry. No private keystore belongs in source control.

If Development Build reports missing signing settings, provision them before
rerunning it. Generate a **new** private key on a trusted device if you have
not already created one. If a replacement key is already in use, keep the
same key and certificate to preserve app upgrades. Do not reuse the previous development key or the Play
upload key. Back up the new keystore securely outside this repository.

```bash
umask 077
keytool -genkeypair -storetype JKS -keystore kyron-development-new.jks \
  -alias kyron-dev -keyalg RSA -keysize 4096 -validity 10950 \
  -dname "CN=Kyron Development Build, O=KyronLabs"
keytool -exportcert -keystore kyron-development-new.jks -alias kyron-dev \
  | sha256sum
```

Use strong passwords of 6-128 ASCII letters, digits, underscores or hyphens
(at least 24 randomly generated characters recommended). Keytool prompts
for the passwords. Configure the four repository secrets directly through
GitHub Settings > Secrets and variables > Actions, not through a message,
issue, commit, public log or paste site.

- `ANDROID_DEV_KEYSTORE_BASE64`: base64 of the new private keystore.
- `ANDROID_DEV_KEYSTORE_PASSWORD`: store password.
- `ANDROID_DEV_KEY_PASSWORD`: private-key password.
- `ANDROID_DEV_KEY_ALIAS`: key alias.
- Repository **Actions variable** `ANDROID_DEV_CERT_SHA256`: lowercase SHA-256 of the
  new public DER certificate (the first field printed by sha256sum).

Add these at repository scope. The Development Build job does not select a
GitHub environment, so environment-scoped values are unavailable. The preflight
reports missing names without printing their values.

Use a trusted password manager or local protected files when provisioning
secrets. Do not print the base64 in shared terminal logs. For example with
an authenticated GitHub CLI, feed the encoded file directly via stdin:

```bash
base64 -w0 kyron-development-new.jks | gh secret set ANDROID_DEV_KEYSTORE_BASE64 --repo KyronLabs/kyron
```

Do not rotate the Play app-signing or upload key merely because development
signing changes. Official development builds require the new certificate,
run only on main, publish four validated APKs, and do not access the Play
upload key. Versioned releases alone produce the Play bundle. Forks can
run tests or use their own locally managed keys.

Existing users of the retired development certificate must uninstall
that development app once and reinstall from an official release. Warn
them about any local-only data before uninstalling. Play Store users should
update through Play; this is not a Play Store signing migration.

Removing the old keystore from the current tree is not removal from Git
history. Do not change repository visibility until historical exposure
and provider-side revocation have been reviewed separately.
