import 'package:flutter/material.dart';

class AppTheme {
  // Dark Colors
  static const background = Color(0xFF0D0D0F);
  static const surface = Color(0xFF1A1A1D);
  static const textPrimary = Color(0xFFE5EBF5);
  static const textSecondary = Color(0xFF7E8A9A);
  
  // Light Colors
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightBackgroundStart = Color(0xFFFFFFFF);
  static const lightBackgroundEnd = Color(0xFFF0F4F8);
  static const lightSurface = Color(0xFFF8FAFC);
  static const lightTextPrimary = Color(0xFF1A202C);
  static const lightTextSecondary = Color(0xFF718096);
  
  // Pill button backgrounds
  static const darkPillBg = Color(0xFF1F1F23);
  static const lightPillBg = Color(0xFFF7F7F7);

  // Shared Colors
  static const accent = Color(0xFF4C8FFF);
  static const errorPink = Color(0xFFFF6582);
  static const successAqua = Color(0xFF4CD4B0);

  // Typography
  static const _fontFamily = 'Inter';

  static TextTheme _baseTextTheme(Color primary, Color secondary) => TextTheme(
        displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: primary, letterSpacing: -0.2),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: primary),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: primary),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primary),
        titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: primary),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: secondary),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: primary),
        labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primary),
        labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: secondary),
      ).apply(fontFamily: _fontFamily);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    canvasColor: surface,
    colorScheme: ColorScheme.dark(
      primary: accent,
      onPrimary: Colors.white,
      secondary: accent,
      onSecondary: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      background: background,
      onBackground: textPrimary,
      error: errorPink,
      onError: Colors.white,
      primaryContainer: darkPillBg,
    ),
    textTheme: _baseTextTheme(textPrimary, textSecondary),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF111114),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      hintStyle: const TextStyle(color: textSecondary),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        backgroundColor: accent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        side: BorderSide(color: accent.withOpacity(0.24)),
        foregroundColor: accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accent,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackgroundStart,
    canvasColor: lightSurface,
    colorScheme: ColorScheme.light(
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
    ),
    textTheme: _baseTextTheme(lightTextPrimary, lightTextSecondary),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightTextSecondary.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accent, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(color: lightTextPrimary, fontSize: 18, fontWeight: FontWeight.w600),
      iconTheme: IconThemeData(color: lightTextPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        backgroundColor: accent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        side: BorderSide(color: accent.withOpacity(0.24)),
        foregroundColor: accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accent,
      ),
    ),
  );
}

extension ThemeColors on BuildContext {
  Color get surfaceColor =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.surface
          : AppTheme.lightSurface;

  Color get onSurfaceColor =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.textPrimary
          : AppTheme.lightTextPrimary;

  Color get pillBgColor =>
      Theme.of(this).brightness == Brightness.dark
          ? AppTheme.darkPillBg
          : AppTheme.lightPillBg;
}