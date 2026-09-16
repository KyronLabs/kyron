import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/app_theme.dart';
import '../models/language.dart';
import '../services/app_preferences.dart';

final appPreferencesProvider = Provider<AppPreferences>(
  (ref) => AppPreferences(),
);

/// The preferences the whole app reads, held in memory so a screen can render
/// the current value synchronously instead of waiting on a disk read.
class PreferencesState {
  final Language language;
  final Language primaryLanguage;
  final List<Language> contentLanguages;
  final double textScale;
  final bool pushEnabled;
  final bool emailEnabled;
  final AppTheme theme;
  final bool dataSaver;

  /// False until the stored values have been read once.
  final bool isLoaded;

  const PreferencesState({
    this.language = Languages.fallback,
    this.primaryLanguage = Languages.fallback,
    this.contentLanguages = const [],
    this.textScale = AppPreferences.defaultTextScale,
    this.pushEnabled = true,
    this.emailEnabled = true,
    this.theme = AppTheme.system,
    this.dataSaver = false,
    this.isLoaded = false,
  });

  PreferencesState copyWith({
    Language? language,
    Language? primaryLanguage,
    List<Language>? contentLanguages,
    double? textScale,
    bool? pushEnabled,
    bool? emailEnabled,
    AppTheme? theme,
    bool? dataSaver,
    bool? isLoaded,
  }) =>
      PreferencesState(
        language: language ?? this.language,
        primaryLanguage: primaryLanguage ?? this.primaryLanguage,
        contentLanguages: contentLanguages ?? this.contentLanguages,
        textScale: textScale ?? this.textScale,
        pushEnabled: pushEnabled ?? this.pushEnabled,
        emailEnabled: emailEnabled ?? this.emailEnabled,
        theme: theme ?? this.theme,
        dataSaver: dataSaver ?? this.dataSaver,
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
      _store.readTheme(),
      _store.readDataSaver(),
      _store.readPrimaryLanguage(),
      _store.readContentLanguages(),
    ]);
    if (!mounted) return;
    state = PreferencesState(
      language: results[0] as Language,
      textScale: results[1] as double,
      pushEnabled: results[2] as bool,
      emailEnabled: results[3] as bool,
      theme: results[4] as AppTheme,
      dataSaver: results[5] as bool,
      primaryLanguage: results[6] as Language,
      contentLanguages: results[7] as List<Language>,
      isLoaded: true,
    );
  }

  // Each setter updates state first so the UI reflects the tap immediately,
  // then persists. A failed write loses the preference on next launch rather
  // than making the control feel broken now.
  Future<void> setLanguage(Language language) async {
    state = state.copyWith(language: language);
    await _store.writeLanguage(language);
  }

  Future<void> setPrimaryLanguage(Language language) async {
    state = state.copyWith(primaryLanguage: language);
    await _store.writePrimaryLanguage(language);
  }

  Future<void> setContentLanguages(List<Language> languages) async {
    state = state.copyWith(contentLanguages: languages);
    await _store.writeContentLanguages(languages);
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

  Future<void> setTheme(AppTheme theme) async {
    state = state.copyWith(theme: theme);
    await _store.writeTheme(theme);
  }

  Future<void> setDataSaver(bool enabled) async {
    state = state.copyWith(dataSaver: enabled);
    await _store.writeDataSaver(enabled);
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>(
  (ref) => PreferencesNotifier(ref.read(appPreferencesProvider)),
);
