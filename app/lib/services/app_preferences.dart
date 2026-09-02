import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_language.dart';

/// Device-level preferences: things that belong to this install rather than to
/// the account.
///
/// SharedPreferences rather than secure storage -- none of this is a
/// credential, and secure storage is markedly slower to read at startup.
class AppPreferences {
  static const _kLanguage = 'pref_language_code';
  static const _kTextScale = 'pref_text_scale';
  static const _kPushEnabled = 'pref_push_enabled';
  static const _kEmailEnabled = 'pref_email_enabled';
  static const _kVideoMuted = 'pref_video_muted';

  /// The scales the font-size screen offers, smallest first.
  static const textScales = <double>[0.85, 1.0, 1.15, 1.3];

  /// A name for each, in the same order.
  static const textScaleLabels = <String>['Small', 'Medium', 'Large', 'Larger'];

  /// What a fresh install gets. Stated once so the store, the in-memory state
  /// and the label fallback cannot disagree about it.
  static const defaultTextScale = 0.85;

  static String labelForScale(double scale) {
    final index = textScales.indexOf(scale);
    return index == -1
        ? labelForScale(defaultTextScale)
        : textScaleLabels[index];
  }

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Whether video plays silently. One answer for the whole app, remembered
  /// across launches: turning the sound on used to be something you did to one
  /// clip, so watching a feed meant unmuting every post in it.
  ///
  /// Muted on a fresh install. A feed that starts talking is hostile.
  Future<bool> readVideoMuted() async =>
      (await _prefs).getBool(_kVideoMuted) ?? true;

  Future<void> writeVideoMuted(bool muted) async =>
      (await _prefs).setBool(_kVideoMuted, muted);

  Future<AppLanguage> readLanguage() async =>
      AppLanguage.fromCode((await _prefs).getString(_kLanguage));

  Future<void> writeLanguage(AppLanguage language) async =>
      (await _prefs).setString(_kLanguage, language.code);

  /// Clamped to an offered value: a scale stored by a build with a different
  /// set would otherwise render at a size no screen was checked against.
  Future<double> readTextScale() async {
    final stored = (await _prefs).getDouble(_kTextScale);
    if (stored == null || !textScales.contains(stored)) {
      return defaultTextScale;
    }
    return stored;
  }

  Future<void> writeTextScale(double scale) async =>
      (await _prefs).setDouble(_kTextScale, scale);

  Future<bool> readPushEnabled() async =>
      (await _prefs).getBool(_kPushEnabled) ?? true;

  Future<void> writePushEnabled(bool enabled) async =>
      (await _prefs).setBool(_kPushEnabled, enabled);

  Future<bool> readEmailEnabled() async =>
      (await _prefs).getBool(_kEmailEnabled) ?? true;

  Future<void> writeEmailEnabled(bool enabled) async =>
      (await _prefs).setBool(_kEmailEnabled, enabled);
}
