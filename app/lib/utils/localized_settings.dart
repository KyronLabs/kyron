import '../l10n/app_localizations.dart';
import '../models/app_theme.dart';
import '../services/app_preferences.dart';

/// Names the app's own settings models hold in English, in the reader's
/// language. The models keep English because they are also what is stored
/// and logged; this is only for what is drawn.
extension LocalizedSettings on AppLocalizations {
  /// One of [AppPreferences.textScaleLabels], by its index.
  String textScaleName(int index) => switch (index) {
        0 => this.ui('ui_text_size_small', 'Small'),
        1 => this.ui('ui_text_size_medium', 'Medium'),
        2 => this.ui('ui_text_size_large', 'Large'),
        _ => this.ui('ui_text_size_larger', 'Larger'),
      };

  /// The name of the size [scale] is, as [AppPreferences.labelForScale].
  String textScaleNameFor(double scale) {
    final index = AppPreferences.textScales.indexOf(scale);
    return textScaleName(
      index == -1
          ? AppPreferences.textScales.indexOf(AppPreferences.defaultTextScale)
          : index,
    );
  }

  String themeName(AppTheme theme) => switch (theme) {
        AppTheme.system => this.ui('theme_system', 'System'),
        AppTheme.light => this.ui('theme_light', 'Light'),
        AppTheme.dark => this.ui('theme_dark', 'Dark'),
        AppTheme.dim => this.ui('ui_theme_dim', 'Dim'),
      };

  String themeDetail(AppTheme theme) => switch (theme) {
        AppTheme.system => this.ui('ui_theme_system_detail',
            'Follow the phone’s own light or dark setting'),
        AppTheme.light => this.ui('ui_theme_light_detail', 'Always light'),
        AppTheme.dark => this.ui('ui_theme_dark_detail', 'Always dark'),
        AppTheme.dim => this.ui('ui_theme_dim_detail',
            'A softer dark, blue-grey rather than black'),
      };
}
