# Signing in with Google

The app half is finished. Google sign-in works the moment the provider is
switched on in the Supabase dashboard; nothing else in the repository has to
change, and no Firebase project is involved.

## How it runs

```
 welcome screen        TermsGate.require        the browser
      │                        │                      │
      ├─ Continue with Google ─┤                      │
      │                   agreed?                     │
      │                        └──── yes ──── signInWithOAuth(google) ──┐
      │                                                                 │
      │                                            Google consent screen │
      │                                                                 │
      │                          so.kyron.app://auth-callback ◄──────────┘
      │                                    │
      │                          AuthChangeEvent.signedIn
      │                                    │
      │                      main.dart → adoptExternalSession()
      │                                    │
      └──────────────────────────► RootScreen (onboarding, or the app)
```

| Piece | Where |
|:--|:--|
| The button, drawn to Google's spec | `lib/widgets/google_button.dart` |
| The consent gate in front of it | `lib/widgets/terms_gate.dart` |
| Handing the flow to the browser | `AuthRepository.startGoogleSignIn` |
| Catching the session on the way back | `_watchForExternalSessions` in `lib/main.dart` |
| Adopting it | `AuthNotifier.adoptExternalSession` |

The session is picked up in `main.dart` rather than on the screen that started
it, because by the time it arrives that screen may not exist: Android is free
to kill the process while the browser is in front.

## Turning it on

**1. Google Cloud.** Make an OAuth 2.0 client (APIs & Services → Credentials)
of type **Web application**. Add this as an authorised redirect URI, with the
project ref that is in `SupabaseConfig.url`:

```
https://zgzvclssemsyctstwgod.supabase.co/auth/v1/callback
```

Web, not Android: the flow goes Google → Supabase → Kyron, so the client
Google is talking to is Supabase.

**2. Supabase.** Authentication → Providers → Google. Switch it on, paste the
client ID and client secret from step 1, and save.

**3. Supabase redirect URLs.** Authentication → URL Configuration → Redirect
URLs must list:

```
so.kyron.app://auth-callback
```

Supabase silently falls back to the project's Site URL for any redirect not on
that list, and the Site URL is a developer's localhost — so without this, a
finished sign-in opens a browser tab that cannot connect to anything. Same
list, same reason, as the mail links in `AUTH_EMAILS.md`.

There is no step 4. The app already asks for the right thing.

## Why the system browser and not Kyron's own

Every other link in Kyron opens in the in-app browser, deliberately. This one
does not, and must not: Google rejects OAuth inside an embedded web view with
`disallowed_useragent`, precisely so that the host app cannot read what is
typed into it. A Custom Tab on Android and an `ASWebAuthenticationSession` on
iOS also carry whatever Google session the device already holds, which is what
makes this one tap rather than a password.

## Where it is not offered

`PlatformSupport.authRedirect` is true only on Android and iOS, because those
are the only two builds in this repository that register `so.kyron.app://` —
the intent filter in `AndroidManifest.xml` and `CFBundleURLTypes` in
`Info.plist`. On Windows, Linux, macOS and the web the button explains that
rather than opening a consent screen whose answer has nowhere to go, and
points at the way through that does work: sign in by email, using the address
on the Google account, and set a password from the reset mail.

Adding Windows would mean a redirect Windows can answer — a loopback
`http://127.0.0.1:<port>` listener, or a registered URI scheme in the
installer — plus that URL on the list in step 3.

## What a Google account looks like afterwards

The same as any other. Supabase creates one account per address, so signing up
with Google and later setting a password gives one account with two ways in,
not two accounts. `AuthRepository._toUser` reads `full_name` and
`preferred_username` out of the Google profile, so onboarding opens with the
name already filled in — but the account still goes through onboarding,
because it has no Kyron profile row yet. That is why the redirect routes to
`Routes.home` (which is `RootScreen`) and never straight to the feed.
