import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/app_language.dart';
import '../services/app_preferences.dart';

final appPreferencesProvider = Provider<AppPreferences>(
  (ref) => AppPreferences(),
);

/// The preferences the whole app reads, held in memory so a screen can render
/// the current value synchronously instead of waiting on a disk read.
class PreferencesState {
  final AppLanguage language;
  final double textScale;
  final bool pushEnabled;
  final bool emailEnabled;

  /// False until the stored values have been read once.
  final bool isLoaded;

  const PreferencesState({
    this.language = AppLanguage.english,
    this.textScale = AppPreferences.defaultTextScale,
    this.pushEnabled = true,
    this.emailEnabled = true,
    this.isLoaded = false,
  });

  PreferencesState copyWith({
    AppLanguage? language,
    double? textScale,
    bool? pushEnabled,
    bool? emailEnabled,
    bool? isLoaded,
  }) =>
      PreferencesState(
        language: language ?? this.language,
        textScale: textScale ?? this.textScale,
        pushEnabled: pushEnabled ?? this.pushEnabled,
        emailEnabled: emailEnabled ?? this.emailEnabled,
        isLoaded: isLoaded ?? this.isLoaded,
      );
}

class PreferencesNotifier extends StateNotifier<PreferencesState> {
  final AppPreferences _store;

  PreferencesNotifier(this._store) : super(const PreferencesState()) {
    _load();
  }

  Future<void> _load() async {
    final results = await Future.wait([
      _store.readLanguage(),
      _store.readTextScale(),
      _store.readPushEnabled(),
      _store.readEmailEnabled(),
    ]);
    if (!mounted) return;
    state = PreferencesState(
      language: results[0] as AppLanguage,
      textScale: results[1] as double,
      pushEnabled: results[2] as bool,
      emailEnabled: results[3] as bool,
      isLoaded: true,
    );
  }

  // Each setter updates state first so the UI reflects the tap immediately,
  // then persists. A failed write loses the preference on next launch rather
  // than making the control feel broken now.
  Future<void> setLanguage(AppLanguage language) async {
    state = state.copyWith(language: language);
    await _store.writeLanguage(language);
  }

  Future<void> setTextScale(double scale) async {
    state = state.copyWith(textScale: scale);
    await _store.writeTextScale(scale);
  }

  Future<void> setPushEnabled(bool enabled) async {
    state = state.copyWith(pushEnabled: enabled);
    await _store.writePushEnabled(enabled);
  }

  Future<void> setEmailEnabled(bool enabled) async {
    state = state.copyWith(emailEnabled: enabled);
    await _store.writeEmailEnabled(enabled);
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>(
  (ref) => PreferencesNotifier(ref.read(appPreferencesProvider)),
);
