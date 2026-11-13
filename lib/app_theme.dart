import 'package:flutter/material.dart';

/// Centralized color palette and Material 3 theme for the application.
class AppColors {
  AppColors._();

  /// Primary Maroon: Main brand and accent color
  static const Color primaryMaroon = Color(0xFF800020);

  /// Secondary Maroon: Accents and interactive highlights
  static const Color secondaryMaroon = Color(0xFFA23A52);

  /// Soft Blush: Tonal background and container tint
  static const Color softBlush = Color(0xFFF7E7EB);

  /// Warm White: Background surface
  static const Color warmWhite = Color(0xFFFAF8F8);

  /// Dark Charcoal: High-contrast primary typography
  static const Color darkCharcoal = Color(0xFF252025);

  /// Supporting neutral colors
  static const Color mutedSlate = Color(0xFF6E646A);
  static const Color borderLight = Color(0xFFEADBDF);
  static const Color borderSubtle = Color(0xFFD6C8CC);
  static const Color softBlushBorder = Color(0xFFE8BDC7);
  static const Color cardWhite = Colors.white;
}

/// Application theme definitions.
class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.warmWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryMaroon,
        primary: AppColors.primaryMaroon,
        secondary: AppColors.secondaryMaroon,
        surface: AppColors.warmWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryMaroon,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.softBlush,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryMaroon);
          }
          return const IconThemeData(color: AppColors.mutedSlate);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.primaryMaroon,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: AppColors.mutedSlate,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          );
        }),
      ),
    );
  }
}
