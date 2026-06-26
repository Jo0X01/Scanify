import 'package:flutter/material.dart';

abstract class AppColors {
  // ─── Base ────────────────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ─── Primary (Refined Amber — same in both themes) ───────────────────────
  static const Color primary = Color(0xFFFF9F0A);
  static const Color primaryLight = Color(0xFFFFBD4F);
  static const Color primaryDark = Color(0xFFCC7D00);

  // ─── Semantic (same in both themes) ──────────────────────────────────────
  static const Color success = Color(0xFF34D399);
  static const Color error = Color(0xFFFF5370);
  static const Color warning = Color(0xFFFFBD4F);
  static const Color info = Color(0xFF60A5FA);

  // ═════════════════════════════════════════════════════════════════════════
  // DARK  (blue-tinted near-blacks)
  // ═════════════════════════════════════════════════════════════════════════

  static const Color shadow = Color(0x1AFFFFFF);
  static const Color lShadow = Color(0x1A000000);
  
  static const Color background = Color(0xFF080810);
  static const Color surface = Color(0xFF0F0F1C);
  static const Color surfaceVariant = Color(0xFF17172A);
  static const Color overlay = Color(0xCC080810);

  static const Color tabBackground = Color(0xFF0F0F1C);
  static const Color tabSelected = Color(0xFFFF9F0A);
  static const Color tabUnselected = Color(0xFF4A4A65);

  static const Color textPrimary = Color(0xFFF2F2F8);
  static const Color textSecondary = Color(0xFF9494B0);
  static const Color textDisabled = Color(0xFF4A4A65);
  static const Color textOnPrimary = Color(0xFF000000);

  static const Color iconColor = Color(0xFF9494B0);
  static const Color divider = Color(0xFF17172A);

  static const Color settingsTile = Color(0xFF0F0F1C);
  static const Color settingsDivider = Color(0xFF17172A);
  static const Color toggleActive = Color(0xFFFF9F0A);
  static const Color toggleInactive = Color(0xFF4A4A65);

  static const Color historyCard = Color(0xFF0F0F1C);
  static const Color historyDate = Color(0xFF4A4A65);
  static const Color categoryCard = Color(0xFF17172A);
  static const Color categoryIcon = Color(0xFFFF9F0A);
  static const Color scanBoxIdle = Color(0xFF4A4A65);
  static const Color scanBoxDetected = Color(0xFFFF9F0A);

  // ═════════════════════════════════════════════════════════════════════════
  // LIGHT  (off-white with matching blue undertone)
  // ═════════════════════════════════════════════════════════════════════════
  static const Color lBackground = Color(0xFFF2F2FA);
  static const Color lSurface = Color(0xFFFFFFFF);
  static const Color lSurfaceVariant = Color(0xFFE8E8F4);
  static const Color lOverlay = Color(0x99F2F2FA);

  static const Color lTabBackground = Color(0xFFFFFFFF);
  static const Color lTabSelected = Color(0xFFFF9F0A);
  static const Color lTabUnselected = Color(0xFF9494B0);

  static const Color lTextPrimary = Color(0xFF0F0F1C);
  static const Color lTextSecondary = Color(0xFF4A4A65);
  static const Color lTextDisabled = Color(0xFF9494B0);
  static const Color lTextOnPrimary = Color(0xFF000000);

  static const Color lIconColor = Color(0xFF4A4A65);
  static const Color lDivider = Color(0xFFE0E0F0);

  static const Color lSettingsTile = Color(0xFFFFFFFF);
  static const Color lSettingsDivider = Color(0xFFE8E8F4);
  static const Color lToggleActive = Color(0xFFFF9F0A);
  static const Color lToggleInactive = Color(0xFF9494B0);

  static const Color lHistoryCard = Color(0xFFFFFFFF);
  static const Color lHistoryDate = Color(0xFF9494B0);
  static const Color lCategoryCard = Color(0xFFE8E8F4);
  static const Color lCategoryIcon = Color(0xFFFF9F0A);
  static const Color lScanBoxIdle = Color(0xFF9494B0);
  static const Color lScanBoxDetected = Color(0xFFFF9F0A);
}
