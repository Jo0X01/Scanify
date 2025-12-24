import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppStrings.fontPoppins,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),
    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(color: AppColors.onPrimary),
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontPoppins,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.onPrimary,
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.onBackground,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.onBackground,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.onBackground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.onBackground,
        fontFamily: AppStrings.fontRoboto,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.onBackground,
        fontFamily: AppStrings.fontRoboto,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.onPrimary,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.onSurface.withOpacity(0.60),
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      hintStyle: TextStyle(color: AppColors.onSurface.withOpacity(0.5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onPrimary,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppStrings.fontPoppins,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      background: AppColors.primary,
      onBackground: AppColors.onPrimary,
      surface: AppColors.primary,
      onSurface: AppColors.onPrimary,
    ),
    scaffoldBackgroundColor: AppColors.primary,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(color: AppColors.onPrimary),
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontPoppins,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),
    ),
    // Reuse light textTheme if typography is the same
    textTheme: light.textTheme.apply(
      bodyColor: AppColors.onPrimary,
      displayColor: AppColors.onPrimary,
    ),
    bottomNavigationBarTheme: light.bottomNavigationBarTheme.copyWith(
      backgroundColor: AppColors.primary,
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: AppColors.onPrimary.withOpacity(0.60),
    ),
  );
}
