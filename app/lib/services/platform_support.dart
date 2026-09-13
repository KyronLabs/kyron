// lib/services/platform_support.dart
import 'package:flutter/foundation.dart';

/// What the plugins behind Kyron's native features can do on the platform this
/// build is running on.
///
/// Six of Kyron's features are somebody else's native code rather than Dart,
/// and none of the six covers every platform Flutter builds for. The Windows
/// build made that visible: `webview_flutter` ships android, ios and macos and
/// nothing else, so the browser every link in the app now goes through would
/// have asserted on the first tap; `sqflite` is the same three, and the draft
/// database was opened with an await in front of it during startup, so on
/// Windows the app hung on its own loading spinner and never reached a screen.
///
/// Written down here, once, rather than asked as `Platform.isWindows` wherever
/// somebody remembered to ask. A platform gets added to a list below when the
/// plugin gains it, and everything that depends on it follows.
///
/// The lists are each plugin's own `platforms:` key, read from the resolved
/// package rather than remembered:
///
///   webview_flutter        android, ios, macos
///   video_player           android, ios, macos, web
///   just_audio             android, ios, macos, web
///   camera                 android, ios, web
///   sqflite                android, ios, macos
///   get_thumbnail_video    android, ios, web
@immutable
class PlatformSupport {
  /// The in-app browser. Without it a link has to leave for the system
  /// browser, which on a desktop is what a reader expects anyway.
  final bool webView;

  /// Playing a clip in the feed, the viewer and the video feed.
  final bool video;

  /// Playing a voice post.
  final bool audio;

  /// The camera, and with it the AR lens screen.
  final bool camera;

  /// Cutting a still out of a clip the composer is about to upload.
  final bool videoStills;

  /// The on-device database the composer's drafts live in.
  final bool localDatabase;

  /// Whether `so.kyron.app://auth-callback` finds its way back into the app.
  ///
  /// Android declares the intent filter and iOS the URL type; nothing else
  /// does. It matters for anything that leaves for a browser and expects to
  /// be returned -- signing in with Google, and the links in Supabase's
  /// confirmation and password-reset mail. Where this is false, sending
  /// somebody to Google opens a browser that then has nowhere to put the
  /// session, and they are stranded on a page that cannot say so.
  final bool authRedirect;

  /// What to call this platform when telling somebody a feature is not on it.
  final String name;

  const PlatformSupport({
    required this.webView,
    required this.video,
    required this.audio,
    required this.camera,
    required this.videoStills,
    required this.localDatabase,
    required this.authRedirect,
    required this.name,
  });

  /// A phone, where all of it works.
  static const mobile = PlatformSupport(
    webView: true,
    video: true,
    audio: true,
    camera: true,
    videoStills: true,
    localDatabase: true,
    authRedirect: true,
    name: 'this device',
  );

  static const macOS = PlatformSupport(
    webView: true,
    video: true,
    audio: true,
    // camera ships android, ios and web only.
    camera: false,
    videoStills: false,
    localDatabase: true,
    // The macOS Runner declares no CFBundleURLTypes entry.
    authRedirect: false,
    name: 'macOS',
  );

  static const web = PlatformSupport(
    // The browser is the browser: a link opens a tab rather than a web view
    // inside one.
    webView: false,
    video: true,
    audio: true,
    camera: true,
    videoStills: true,
    // sqflite is native. Drafts on the web would need a different store.
    localDatabase: false,
    // A browser cannot open a custom scheme. The web build would need an
    // https redirect of its own.
    authRedirect: false,
    name: 'the web',
  );

  /// Windows and Linux, which none of the six native plugins covers.
  static const desktop = PlatformSupport(
    webView: false,
    video: false,
    audio: false,
    camera: false,
    videoStills: false,
    localDatabase: false,
    authRedirect: false,
    name: 'Windows',
  );

  static const linux = PlatformSupport(
    webView: false,
    video: false,
    audio: false,
    camera: false,
    videoStills: false,
    localDatabase: false,
    authRedirect: false,
    name: 'Linux',
  );

  static PlatformSupport? _override;

  /// What the platform underneath this build supports.
  static PlatformSupport get current => _override ?? _host();

  /// Lets a test run a screen as though it were somewhere else. Pass null to
  /// go back to the real platform.
  @visibleForTesting
  static set current(PlatformSupport? value) => _override = value;

  static PlatformSupport _host() {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return mobile;
      case TargetPlatform.macOS:
        return macOS;
      case TargetPlatform.windows:
        return desktop;
      case TargetPlatform.linux:
        return linux;
    }
  }
}
