import 'package:flutter/material.dart';

/// Kyron Design System Theme Implementation
/// Based on Bluesky ALF (Application Layout Framework)
/// All values aligned with design-system repository
class AppTheme {
  // ===========================================================================
  // COLOR SYSTEM - Ramp-based from design-system
  // ===========================================================================
  
  // Contrast Ramp (backgrounds, text, borders)
  static const contrast = {
    0: Color(0xFFFFFFFF),   // Lightest (light bg)
    50: Color(0xFFF7F7F7),
    100: Color(0xFFE8E8E8),  // Hairline dividers
    200: Color(0xFFD9D9D9),  // Stronger borders
    300: Color(0xFFC9C9C9),  // Input borders
    400: Color(0xFFB0B0B0),  // Tertiary text, timestamps
    500: Color(0xFF999999),  // Secondary text
    600: Color(0xFF737373),
    700: Color(0xFF5C5C5C),  // Body text
    800: Color(0xFF3A3A3A),
    900: Color(0xFF262626),
    1000: Color(0xFF000000), // Darkest (light text)
  };
  
  // Primary Ramp (accent colors)
  static const primary = {
    0: Color(0xFFE6F0FF),
    50: Color(0xFFCCE0FF),
    100: Color(0xFFB3D1FF),
    200: Color(0xFF99C2FF),  // Disabled state
    300: Color(0xFF80B3FF),
    400: Color(0xFF66A4FF),  // Hover state (dark theme)
    500: Color(0xFF006AFF),  // DEFAULT ACCENT
    600: Color(0xFF005BCC),  // Pressed state (light theme)
    700: Color(0xFF004D99),  // Disabled state (dark theme)
    800: Color(0xFF003F80),
    900: Color(0xFF003366),
    1000: Color(0xFF00264D),
  };
  
  // Positive Ramp (success states)
  static const positive = {
    0: Color(0xFFE6FFF0),
    50: Color(0xFFCCFFE0),
    100: Color(0xFFB3FFD1),
    200: Color(0xFF99FFC2),
    300: Color(0xFF80FFB3),
    400: Color(0xFF66FFA4),
    500: Color(0xFF4CD4B0),  // successAqua
    600: Color(0xFF42B896),
    700: Color(0xFF389C7C),
    800: Color(0xFF2E8062),
    900: Color(0xFF246449),
    1000: Color(0xFF1A4830),
  };
  
  // Negative Ramp (error states)
  static const negative = {
    0: Color(0xFFFFE6E6),
    50: Color(0xFFFFCCCC),
    100: Color(0xFFFFB3B3),
    200: Color(0xFFFF9999),
    300: Color(0xFFFF8080),
    400: Color(0xFFFF6666),
    500: Color(0xFFFF4C4C),
    600: Color(0xFFFF6582),  // errorPink
    700: Color(0xFFCC3D3D),
    800: Color(0xFF992E2E),
    900: Color(0xFF661F1F),
    1000: Color(0xFF331010),
  };
  
  // Dim Theme Contrast Ramp
  static const dimContrast = {
    0: Color(0xFF151D28),   // Background
    50: Color(0xFF1E2A38),
    100: Color(0xFF2A3848),  // Hairline dividers
    200: Color(0xFF384858),
    300: Color(0xFF485868),
    400: Color(0xFF607080),  // Tertiary text
    500: Color(0xFF788898),
    600: Color(0xFF90A0B0),
    700: Color(0xFFA8B8C8),  // Body text
    800: Color(0xFFC0D0D8),
    900: Color(0xFFD8E8F0),
    1000: Color(0xFFF0F8FF), // Primary text
  };
  
  // ===========================================================================
  // SEMANTIC COLORS
  // ===========================================================================
  
  // Light Theme Colors (aligned with ramp system)
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightBackgroundStart = Color(0xFFFFFFFF);
  static const lightBackgroundEnd = Color(0xFFF0F4F8);
  static const lightSurface = Color(0xFFF7F7F7);  // contrast_50
  static const lightTextPrimary = Color(0xFF000000);  // contrast_1000
  static const lightTextSecondary = Color(0xFF5C5C5C);  // contrast_700
  static const lightTextTertiary = Color(0xFFB0B0B0);  // contrast_400
  
  // Dark Theme Colors (aligned with ramp system)
  static const darkBackground = Color(0xFF000000);  // contrast_0
  static const darkSurface = Color(0xFF0A0A0A);  // contrast_50
  static const darkTextPrimary = Color(0xFFFFFFFF);  // contrast_1000
  static const darkTextSecondary = Color(0xFFB0B0B0);  // contrast_700
  static const darkTextTertiary = Color(0xFF5C5C5C);  // contrast_400
  
  // Dim Theme Colors
  static const dimBackground = Color(0xFF151D28);  // dimContrast_0
  static const dimSurface = Color(0xFF1E2A38);  // dimContrast_50
  static const dimTextPrimary = Color(0xFFF0F8FF);  // dimContrast_1000
  static const dimTextSecondary = Color(0xFFA8B8C8);  // dimContrast_700
  static const dimTextTertiary = Color(0xFF607080);  // dimContrast_400
  
  // Shared Colors
  static const accent = Color(0xFF006AFF);  // primary_500
  static const accentHover = Color(0xFF005BCC);  // primary_600
  static const accentDisabled = Color(0xFF99C2FF);  // primary_200
  static const errorPink = Color(0xFFFF6582);  // negative_600
  static const successAqua = Color(0xFF4CD4B0);  // positive_500
  
  // Pill backgrounds
  static const darkPillBg = Color(0xFF1A1A1A);  // contrast_50 (dark)
  static const lightPillBg = Color(0xFFF7F7F7);  // contrast_50 (light)
  
  // ===========================================================================
  // BACKWARD COMPATIBILITY
  // ===========================================================================
  
  static const background = lightBackground;
  static const surface = lightSurface;
  static const textPrimary = lightTextPrimary;
  static const textSecondary = lightTextSecondary;
  static const space6 = space8;
  static const space18 = space16;
  
  // ===========================================================================
  // TYPOGRAPHY - Fractional font sizes from Bluesky ALF
  // ===========================================================================
  
  static const _fontFamily = 'Inter';
  
  // Font Sizes (1.125 modular scale from 15px base)
  static const fontSize0 = 9.4;
  static const fontSize1 = 11.3;
  static const fontSize2 = 13.1;
  static const fontSize3 = 15.0;  // Base
  static const fontSize4 = 16.9;
  static const fontSize5 = 18.8;
  static const fontSize6 = 20.6;
  static const fontSize7 = 24.3;
  static const fontSize8 = 30.0;
  static const fontSize9 = 37.5;
  
  // Line Heights
  static const lineHeightTight = 1.15;
  static const lineHeightSnug = 1.3;
  static const lineHeightRelaxed = 1.5;
  
  // Font Weights
  static const fontWeightRegular = FontWeight.w400;
  static const fontWeightMedium = FontWeight.w500;
  static const fontWeightSemibold = FontWeight.w600;
  static const fontWeightBold = FontWeight.w700;
  
  // ===========================================================================
  // SPACING - Powers of 2 scale from design-system
  // ===========================================================================
  
  static const space2 = 2.0;
  static const space4 = 4.0;
  static const space8 = 8.0;
  static const space12 = 12.0;
  static const space16 = 16.0;
  static const space20 = 20.0;
  static const space24 = 24.0;
  static const space28 = 28.0;
  static const space32 = 32.0;
  static const space40 = 40.0;
  
  // ===========================================================================
  // BORDER RADIUS - From design-system
  // ===========================================================================
  
  static const radius2 = 2.0;
  static const radius4 = 4.0;
  static const radius8 = 8.0;    // radius.sm
  static const radius12 = 12.0;  // radius.md
  static const radius16 = 16.0;
  static const radius20 = 20.0;  // Bottom sheet radius
  static const radiusFull = 999.0; // Pill shape
  
  // Named radii for clarity
  static const radiusSm = radius8;
  static const radiusMd = radius12;
  static const radiusLg = radius16;
  
  // ===========================================================================
  // MOTION - From design-system
  // ===========================================================================
  
  static const motionMicro = Duration(milliseconds: 90);   // Press states
  static const motionFast = Duration(milliseconds: 180);  // Sheets closing
  static const motionNormal = Duration(milliseconds: 260); // Page pushes
  static const motionSlow = Duration(milliseconds: 420);  // Hero animations
  
  // Press interaction values
  static const pressScale = 0.97;
  static const pressOpacity = 0.85;
  
  // ===========================================================================
  // TEXT THEME - Aligned with design-system typography
  // ===========================================================================
  
  static TextTheme _baseTextTheme(Color primary, Color secondary, Color tertiary) => TextTheme(
    // Display
    displayLarge: const TextStyle(
      fontSize: fontSize9, // 37.5
      fontWeight: fontWeightBold,
      letterSpacing: 0,
      height: lineHeightTight,
    ),
    displayMedium: const TextStyle(
      fontSize: fontSize8, // 30.0
      fontWeight: fontWeightBold,
      letterSpacing: 0,
      height: lineHeightTight,
    ),
    displaySmall: const TextStyle(
      fontSize: fontSize7, // 24.3
      fontWeight: fontWeightSemibold,
      letterSpacing: 0,
      height: lineHeightTight,
    ),
    
    // Headlines
    headlineLarge: const TextStyle(
      fontSize: fontSize6, // 20.6
      fontWeight: fontWeightSemibold,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    headlineMedium: const TextStyle(
      fontSize: fontSize5, // 18.8
      fontWeight: fontWeightSemibold,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    headlineSmall: const TextStyle(
      fontSize: fontSize4, // 16.9
      fontWeight: fontWeightSemibold,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    
    // Titles
    titleLarge: const TextStyle(
      fontSize: fontSize3, // 15.0 (base)
      fontWeight: fontWeightSemibold,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    titleMedium: const TextStyle(
      fontSize: fontSize2, // 13.1
      fontWeight: fontWeightSemibold,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    titleSmall: const TextStyle(
      fontSize: fontSize1, // 11.3
      fontWeight: fontWeightSemibold,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    
    // Body
    bodyLarge: const TextStyle(
      fontSize: fontSize4, // 16.9
      fontWeight: fontWeightRegular,
      letterSpacing: 0,
      height: lineHeightRelaxed,
    ),
    bodyMedium: const TextStyle(
      fontSize: fontSize3, // 15.0 (base)
      fontWeight: fontWeightRegular,
      letterSpacing: 0,
      height: lineHeightRelaxed,
    ),
    bodySmall: const TextStyle(
      fontSize: fontSize2, // 13.1
      fontWeight: fontWeightRegular,
      letterSpacing: 0,
      height: lineHeightRelaxed,
    ),
    
    // Labels
    labelLarge: const TextStyle(
      fontSize: fontSize4, // 16.9
      fontWeight: fontWeightMedium,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    labelMedium: const TextStyle(
      fontSize: fontSize3, // 15.0
      fontWeight: fontWeightMedium,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
    labelSmall: const TextStyle(
      fontSize: fontSize2, // 13.1
      fontWeight: fontWeightMedium,
      letterSpacing: 0,
      height: lineHeightSnug,
    ),
  ).apply(fontFamily: _fontFamily);
  
  // ===========================================================================
  // THEME DEFINITIONS
  // ===========================================================================
  
  /// Light Theme
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackgroundStart,
      canvasColor: lightSurface,
      colorScheme: const ColorScheme.light(
        primary: accent,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        background: lightBackgroundStart,
        onBackground: lightTextPrimary,
        error: errorPink,
        onError: Colors.white,
        primaryContainer: lightPillBg,
        secondaryContainer: lightSurface,
      ),
      textTheme: _baseTextTheme(lightTextPrimary, lightTextSecondary, lightTextTertiary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: BorderSide(color: lightTextSecondary.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: const BorderSide(color: errorPink, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: space16, horizontal: space16),
        hintStyle: TextStyle(color: lightTextSecondary),
        errorStyle: const TextStyle(color: errorPink),
      ),
      primaryTextTheme: _baseTextTheme(lightTextPrimary, lightTextSecondary, lightTextTertiary),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: fontSize5,
          fontWeight: fontWeightSemibold,
          letterSpacing: 0,
          height: lineHeightSnug,
        ),
        iconTheme: IconThemeData(color: lightTextPrimary),
        actionsIconTheme: IconThemeData(color: lightTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: fontSize3,
            fontWeight: fontWeightMedium,
            letterSpacing: 0,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(color: accent.withOpacity(0.24)),
          foregroundColor: accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: fontSize3,
            fontWeight: fontWeightMedium,
            letterSpacing: 0,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFD9D9D9),
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius20),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
      ),
    );
  }
  
  /// Dark Theme
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkSurface,
      colorScheme: ColorScheme.dark(
        primary: accent,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        background: darkBackground,
        onBackground: darkTextPrimary,
        error: errorPink,
        onError: Colors.white,
        primaryContainer: darkPillBg,
        secondaryContainer: darkSurface,
      ),
      textTheme: _baseTextTheme(darkTextPrimary, darkTextSecondary, darkTextTertiary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: const BorderSide(color: errorPink, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: space16, horizontal: space16),
        hintStyle: TextStyle(color: darkTextSecondary),
        errorStyle: const TextStyle(color: errorPink),
      ),
      primaryTextTheme: _baseTextTheme(darkTextPrimary, darkTextSecondary, darkTextTertiary),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: fontSize5,
          fontWeight: fontWeightSemibold,
          letterSpacing: 0,
          height: lineHeightSnug,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
        actionsIconTheme: IconThemeData(color: darkTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: fontSize3,
            fontWeight: fontWeightMedium,
            letterSpacing: 0,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(color: accent.withOpacity(0.24)),
          foregroundColor: accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: fontSize3,
            fontWeight: fontWeightMedium,
            letterSpacing: 0,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF384858),
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius20),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
      ),
    );
  }
  
  /// Dim Theme (Default Dark)
  static ThemeData get dimTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: dimBackground,
      canvasColor: dimSurface,
      colorScheme: ColorScheme.dark(
        primary: accent,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        surface: dimSurface,
        onSurface: dimTextPrimary,
        background: dimBackground,
        onBackground: dimTextPrimary,
        error: errorPink,
        onError: Colors.white,
        primaryContainer: dimSurface,
        secondaryContainer: dimSurface,
      ),
      textTheme: _baseTextTheme(dimTextPrimary, dimTextSecondary, dimTextTertiary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dimSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius12),
          borderSide: const BorderSide(color: accent, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: space16, horizontal: space16),
        hintStyle: TextStyle(color: dimTextSecondary),
      ),
      primaryTextTheme: _baseTextTheme(dimTextPrimary, dimTextSecondary, dimTextTertiary),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: fontSize5,
          fontWeight: fontWeightSemibold,
          letterSpacing: 0,
          height: lineHeightSnug,
        ),
        iconTheme: IconThemeData(color: dimTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: fontSize3,
            fontWeight: fontWeightMedium,
            letterSpacing: 0,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: dimSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF485868),
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: dimSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius20),
          ),
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
      ),
    );
  }
}

// ===========================================================================
// EXTENSIONS
// ===========================================================================

/// Extension for easy access to theme colors
extension ThemeColors on BuildContext {
  Color get surfaceColor =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkSurface
          : AppTheme.lightSurface;

  Color get onSurfaceColor =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkTextPrimary
          : AppTheme.lightTextPrimary;

  Color get pillBgColor =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkPillBg
          : AppTheme.lightPillBg;

  Color get accentColor => AppTheme.accent;

  Color get errorColor => AppTheme.errorPink;

  Color get successColor => AppTheme.successAqua;

  Color get textSecondary =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkTextSecondary
          : AppTheme.lightTextSecondary;

  Color get textTertiary =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkTextTertiary
          : AppTheme.lightTextTertiary;

  Color get surface =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkSurface
          : AppTheme.lightSurface;

  Color get background =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkBackground
          : AppTheme.lightBackground;

  Color get textPrimary =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkTextPrimary
          : AppTheme.lightTextPrimary;
}

/// Extension for spacing
extension Spacing on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
  EdgeInsets get all => EdgeInsets.all(toDouble());
  EdgeInsets get hPad => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vPad => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get tPad => EdgeInsets.only(top: toDouble());
  EdgeInsets get bPad => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get lPad => EdgeInsets.only(left: toDouble());
  EdgeInsets get rPad => EdgeInsets.only(right: toDouble());
}

/// Extension for radius on num - carefully named to avoid conflicts
extension NumRadius on num {
  BorderRadius get radius => BorderRadius.all(Radius.circular(toDouble()));
  Radius get circular => Radius.circular(toDouble());
  BorderRadius get topRadius => BorderRadius.vertical(
    top: Radius.circular(toDouble()),
  );
  BorderRadius get bottomRadius => BorderRadius.vertical(
    bottom: Radius.circular(toDouble()),
  );
}
