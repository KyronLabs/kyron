# Why the emails opened localhost

Tapping **Confirm your email** or **Reset password** in a Kyron email opened a
browser at `http://localhost:3000` — a page that cannot load on a phone, on
anyone's phone but a developer's. An account that needed confirming stayed
unconfirmed, and a password that needed resetting stayed unreset.

## What was wrong

Nothing was telling Supabase where to send people. `signUp` was called with no
`emailRedirectTo` and `resetPasswordForEmail` with no `redirectTo`, and when
those are absent Supabase falls back to the project's **Site URL** — which is
whatever it was set to on the day the project was created.

## The code half, which is done

Both calls now pass `SupabaseConfig.authRedirect`:

```
so.kyron.app://auth-callback
```

A custom scheme rather than an `https://` link on purpose. An https link has to
be *proven* to belong to the app — `assetlinks.json` served from the domain on
Android, an associated-domains entitlement on iOS — and when that proof is
missing, stale, or served with the wrong content type, the link silently opens
a browser instead. Which is the failure being fixed. A scheme cannot fail that
way, and using the application id as the scheme means no other app on the
device can claim it.

The device now knows about it too: an intent filter in the Android manifest and
a `CFBundleURLTypes` entry in `Info.plist`, both spelled the same as the
constant.

And the app does something when the link lands. The Supabase SDK completes the
deep link itself and raises a `passwordRecovery` event; nothing was listening,
so a reset link opened the app onto the feed — which reads as the link having
failed. It now opens the screen where a new password is set.

## The half only you can do

**These settings live in the Supabase dashboard and the app cannot change
them.** Until they are set, the redirect above is *ignored* and Supabase falls
back to the Site URL exactly as before — the symptom is identical, which is
what makes it worth writing down.

Go to **Authentication → URL Configuration** in the
[Kyron project](https://supabase.com/dashboard/project/zgzvclssemsyctstwgod/auth/url-configuration):

| Setting | Value |
|:--|:--|
| **Site URL** | `https://kyron.spidroid.com` — the fallback for anything not listed below. It should be somewhere real, not `localhost`. |
| **Redirect URLs** | Add `so.kyron.app://auth-callback` |

Keep `http://localhost:3000` in the Redirect URLs list if you develop against a
local web build; it does no harm there. It is only wrong as the *Site URL*,
because that is the one used when nothing matches.

## Checking it

Trigger a reset for an account you can read the mail of, then look at the link
in the email before tapping it. It should contain

```
redirect_to=so.kyron.app%3A%2F%2Fauth-callback
```

If it says `localhost` instead, the Redirect URLs list has not been updated and
Supabase has quietly fallen back. That is the whole failure mode: it does not
error, it substitutes.

On the device, `adb shell am start -a android.intent.action.VIEW -d
"so.kyron.app://auth-callback"` should open Kyron rather than offering a
browser.

## Still to sort out

The iOS bundle identifier is `com.example.app` — the Flutter template's
default, never changed. The URL scheme added here is `so.kyron.app` and does
not depend on it, so this works either way, but that identifier has to be set
to something real before anything ships to TestFlight, and it is the kind of
thing that is discovered late.
