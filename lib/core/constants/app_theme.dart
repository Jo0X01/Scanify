import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';

abstract class AppTheme {
  // ═══════════════════════════════════════════════════════════════════════════
  // DARK
  // ═══════════════════════════════════════════════════════════════════════════
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppStrings.fontCairo,

    // ── Color scheme ──────────────────────────────────────────────────────
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.textPrimary,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.textOnPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceVariant,
      error: AppColors.error,
      onError: AppColors.white,
      outline: AppColors.divider,
    ),

    scaffoldBackgroundColor: AppColors.background,

    // ── System UI overlay ─────────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.tabBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: AppColors.iconColor),
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    ),

    // ── Text ──────────────────────────────────────────────────────────────
    textTheme: _buildTextTheme(
      primary: AppColors.textPrimary,
      secondary: AppColors.textSecondary,
      disabled: AppColors.textDisabled,
    ),

    // ── Bottom nav ────────────────────────────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.tabBackground,
      selectedItemColor: AppColors.tabSelected,
      unselectedItemColor: AppColors.tabUnselected,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      elevation: 0,
    ),

    // ── Input ─────────────────────────────────────────────────────────────
    inputDecorationTheme: _buildInputTheme(
      fill: AppColors.surfaceVariant,
      border: AppColors.divider,
      focused: AppColors.primary,
      error: AppColors.error,
      hint: AppColors.textDisabled,
    ),

    // ── Card ──────────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // ── Icons ─────────────────────────────────────────────────────────────
    iconTheme: const IconThemeData(color: AppColors.iconColor, size: 22),

    // ── Buttons ───────────────────────────────────────────────────────────
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(),

    // ── Switch ────────────────────────────────────────────────────────────
    switchTheme: _buildSwitchTheme(
      active: AppColors.toggleActive,
      inactive: AppColors.toggleInactive,
      track: AppColors.surfaceVariant,
    ),

    // ── ListTile ──────────────────────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      tileColor: AppColors.settingsTile,
      iconColor: AppColors.primary,
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
        color: AppColors.textSecondary,
      ),
    ),

    // ── Divider ───────────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // ── SnackBar ──────────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surface,
      contentTextStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    // ── Dialog ────────────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    ),

    // ── Bottom sheet ──────────────────────────────────────────────────────
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // ── Chip ──────────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceVariant,
      labelStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
      ),
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      side: const BorderSide(color: AppColors.divider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),

    // ── Progress indicator ────────────────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT
  // ═══════════════════════════════════════════════════════════════════════════
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppStrings.fontCairo,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.lTextOnPrimary,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.lTextOnPrimary,
      surface: AppColors.lSurface,
      onSurface: AppColors.lTextPrimary,
      surfaceContainerHighest: AppColors.lSurfaceVariant,
      error: AppColors.error,
      onError: AppColors.white,
      outline: AppColors.lDivider,
    ),

    scaffoldBackgroundColor: AppColors.lBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.lBackground,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.lTabBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(color: AppColors.lIconColor),
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.lTextPrimary,
      ),
    ),

    textTheme: _buildTextTheme(
      primary: AppColors.lTextPrimary,
      secondary: AppColors.lTextSecondary,
      disabled: AppColors.lTextDisabled,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lTabBackground,
      selectedItemColor: AppColors.lTabSelected,
      unselectedItemColor: AppColors.lTabUnselected,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      elevation: 0,
    ),

    inputDecorationTheme: _buildInputTheme(
      fill: AppColors.lSurfaceVariant,
      border: AppColors.lDivider,
      focused: AppColors.primary,
      error: AppColors.error,
      hint: AppColors.lTextDisabled,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lSurface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    iconTheme: const IconThemeData(color: AppColors.lIconColor, size: 22),

    elevatedButtonTheme: _buildElevatedButtonTheme(),
    textButtonTheme: _buildTextButtonTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(),

    switchTheme: _buildSwitchTheme(
      active: AppColors.lToggleActive,
      inactive: AppColors.lToggleInactive,
      track: AppColors.lSurfaceVariant,
    ),

    listTileTheme: const ListTileThemeData(
      tileColor: AppColors.lSettingsTile,
      iconColor: AppColors.primary,
      titleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.lTextPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
        color: AppColors.lTextSecondary,
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.lDivider,
      thickness: 1,
      space: 1,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lSurface,
      contentTextStyle: const TextStyle(
        color: AppColors.lTextPrimary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.lTextPrimary,
      ),
      contentTextStyle: const TextStyle(
        fontFamily: AppStrings.fontCairo,
        fontSize: 14,
        color: AppColors.lTextSecondary,
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lSurfaceVariant,
      labelStyle: const TextStyle(
        color: AppColors.lTextSecondary,
        fontFamily: AppStrings.fontCairo,
        fontSize: 12,
      ),
      selectedColor: AppColors.primary.withValues(alpha: 0.15),
      side: const BorderSide(color: AppColors.lDivider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // Shared builders — avoids repeating identical style code
  // ═══════════════════════════════════════════════════════════════════════════

  static TextTheme _buildTextTheme({
    required Color primary,
    required Color secondary,
    required Color disabled,
  }) {
    return TextTheme(
      // Display
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
      // Headline
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
      // Title
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
      // Body — Poppins throughout, no font switching
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: secondary,
        fontFamily: "cairo"
      ),
      bodyMedium: TextStyle(fontSize: 14, color: secondary),
      bodySmall: TextStyle(fontSize: 12, color: disabled),
      // Label
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
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
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
        foregroundColor: AppColors.primary,
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
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
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
