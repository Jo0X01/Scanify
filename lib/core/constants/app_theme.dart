// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanify/core/constants/app_strings.dart';

abstract class AppTheme {
  static const Color _primary = Color(0xFFE8960A);
  static const Color _primaryLight = Color(0xFFF5B83D);
  static const Color _primaryDark = Color(0xFFB87208);
  static const Color _error = Color(0xFFFF5370);
  static const Color _success = Color(0xFF34D399);
  static const Color _white = Color(0xFFFFFFFF);

  static const Color _dBackground = Color(0xFF111118);
  static const Color _dSurface = Color(0xFF0F0F1C);
  static const Color _dSurfaceVariant = Color(0xFF17172A);
  static const Color _dTextPrimary = Color(0xFFF2F2F8);
  static const Color _dTextSecondary = Color(0xFF9494B0);
  static const Color _dTextDisabled = Color(0xFF4A4A65);
  static const Color _dIconColor = Color(0xFF9494B0);
  static const Color _dDivider = Color(0xFF17172A);
  static const Color _dTabUnselected = Color(0xFF4A4A65);
  static const Color _dToggleInactive = Color(0xFF4A4A65);

  static const Color _lBackground = Color(0xFFF2F2FA);
  static const Color _lSurface = Color(0xFFFFFFFF);
  static const Color _lSurfaceVariant = Color(0xFFE8E8F4);
  static const Color _lTextPrimary = Color(0xFF0F0F1C);
  static const Color _lTextSecondary = Color(0xFF4A4A65);
  static const Color _lTextDisabled = Color(0xFF9494B0);
  static const Color _lIconColor = Color(0xFF4A4A65);
  static const Color _lDivider = Color(0xFFE0E0F0);
  static const Color _lTabUnselected = Color(0xFF9494B0);
  static const Color _lToggleInactive = Color(0xFF9494B0);

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppStrings.fontCairo,

    colorScheme: const ColorScheme.dark(
      primary: _primary,
      onPrimary: _white,
      secondary: _primaryLight,
      onSecondary: _white,
      surface: _dSurface,
      onSurface: _dTextSecondary,
      surfaceContainerHighest: _dSurfaceVariant,
      error: _error,
      onError: _white,
      outline: _dDivider,
    ),

    scaffoldBackgroundColor: _dBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: _dBackground,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: _dSurface,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: _dIconColor),
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: _dTextPrimary,
      ),
    ),

    textTheme: _buildTextTheme(
      primary: _dTextPrimary,
      secondary: _dTextSecondary,
      disabled: _dTextDisabled,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _dSurface,
      selectedItemColor: _primary,
      unselectedItemColor: _dTabUnselected,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      elevation: 0,
    ),

    inputDecorationTheme: _buildInputTheme(
      fill: _dSurfaceVariant,
      border: _dDivider,
      focused: _primary,
      error: _error,
      hint: _dTextDisabled,
    ),

    cardTheme: CardThemeData(
      color: _dSurface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    iconTheme: const IconThemeData(color: _dIconColor, size: 22),

    elevatedButtonTheme: _buildElevatedButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(),

    switchTheme: _buildSwitchTheme(
      active: _primary,
      inactive: _dToggleInactive,
      track: _dSurfaceVariant,
    ),

    listTileTheme: const ListTileThemeData(
      tileColor: _dSurface,
      iconColor: _primary,
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _dTextPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
        color: _dTextSecondary,
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: _dDivider,
      thickness: 1,
      space: 1,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: _dSurface,
      contentTextStyle: const TextStyle(
        color: _dTextPrimary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: _dSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: _dTextPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        color: _dTextSecondary,
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _dSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: _dSurfaceVariant,
      labelStyle: const TextStyle(
        color: _dTextSecondary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
      ),
      selectedColor: Color(0x33E8960A),
      side: const BorderSide(color: _dDivider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(color: _primary),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT THEME
  // ═══════════════════════════════════════════════════════════════════════════
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppStrings.fontCairo,

    colorScheme: const ColorScheme.light(
      primary: _primary,
      onPrimary: _white,
      secondary: _primaryLight,
      onSecondary: _white,
      surface: _lSurface,
      onSurface: _dTextSecondary,
      surfaceContainerHighest: _lSurfaceVariant,
      error: _error,
      onError: _white,
      outline: _lDivider,
    ),

    scaffoldBackgroundColor: _lBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: _lBackground,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: _lSurface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(color: _lIconColor),
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: _lTextPrimary,
      ),
    ),

    textTheme: _buildTextTheme(
      primary: _lTextPrimary,
      secondary: _lTextSecondary,
      disabled: _lTextDisabled,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _lSurface,
      selectedItemColor: _primary,
      unselectedItemColor: _lTabUnselected,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      elevation: 0,
    ),

    inputDecorationTheme: _buildInputTheme(
      fill: _lSurfaceVariant,
      border: _lDivider,
      focused: _primary,
      error: _error,
      hint: _lTextDisabled,
    ),

    cardTheme: CardThemeData(
      color: _lSurface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    iconTheme: const IconThemeData(color: _lIconColor, size: 22),

    elevatedButtonTheme: _buildElevatedButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(),

    switchTheme: _buildSwitchTheme(
      active: _primary,
      inactive: _lToggleInactive,
      track: _lSurfaceVariant,
    ),

    listTileTheme: const ListTileThemeData(
      tileColor: _lSurface,
      iconColor: _primary,
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _lTextPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
        color: _lTextSecondary,
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: _lDivider,
      thickness: 1,
      space: 1,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: _lSurface,
      contentTextStyle: const TextStyle(
        color: _lTextPrimary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: _lSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: _lTextPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        color: _lTextSecondary,
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _lSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: _lSurfaceVariant,
      labelStyle: const TextStyle(
        color: _lTextSecondary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
      ),
      selectedColor: Color(0x26E8960A),
      side: const BorderSide(color: _lDivider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(color: _primary),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // Shared builders
  // ═══════════════════════════════════════════════════════════════════════════

  static TextTheme _buildTextTheme({
    required Color primary,
    required Color secondary,
    required Color disabled,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: secondary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: secondary,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: secondary),
      bodySmall: TextStyle(fontSize: 12, color: disabled),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondary,
      ),
      labelSmall: TextStyle(fontSize: 12, color: disabled),
    );
  }

  static InputDecorationTheme _buildInputTheme({
    required Color fill,
    required Color border,
    required Color focused,
    required Color error,
    required Color hint,
  }) {
    final radius = BorderRadius.circular(12);
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      hintStyle: TextStyle(color: hint, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: focused, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: error, width: 1.5),
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: _white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: AppStrings.fontCairo,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(
          fontFamily: AppStrings.fontCairo,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primary,
        side: const BorderSide(color: _primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: AppStrings.fontCairo,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static SwitchThemeData _buildSwitchTheme({
    required Color active,
    required Color inactive,
    required Color track,
  }) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? active : inactive,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? active.withValues(alpha: 0.35)
            : track,
      ),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}
