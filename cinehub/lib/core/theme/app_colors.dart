import 'package:flutter/material.dart';

/// CineHub dark cinematic color system.
///
/// Inspired by Linear, Notion dark mode, and AI SaaS dashboards.
/// Deep blacks with blue undertones, electric violet primary, warm amber accents.
class AppColors {
  AppColors._();

  // ── Backgrounds ──────────────────────────────────────────────
  static const Color background = Color(0xFF08080D);
  static const Color surface = Color(0xFF111118);
  static const Color surfaceElevated = Color(0xFF1A1A26);
  static const Color surfaceOverlay = Color(0xFF222233);
  static const Color surfaceBorder = Color(0xFF2A2A3C);
  static const Color surfaceHover = Color(0xFF1E1E2E);

  // ── Brand ────────────────────────────────────────────────────
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF7C3AED);
  static const Color primaryMuted = Color(0xFF2D2250);
  static const Color primaryGlow = Color(0x338B5CF6);

  static const Color accent = Color(0xFFE8A838);
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentMuted = Color(0xFF3D2E12);

  static const Color secondary = Color(0xFFEC4899);
  static const Color secondaryMuted = Color(0xFF3D1C30);

  // ── Text ─────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF0F0F5);
  static const Color textSecondary = Color(0xFF9090A7);
  static const Color textTertiary = Color(0xFF5A5A72);
  static const Color textDisabled = Color(0xFF3D3D52);
  static const Color textInverse = Color(0xFF08080D);

  // ── Semantic ─────────────────────────────────────────────────
  static const Color success = Color(0xFF34D399);
  static const Color successMuted = Color(0xFF0D3525);
  static const Color error = Color(0xFFF87171);
  static const Color errorMuted = Color(0xFF3D1C1C);
  static const Color warning = Color(0xFFFBBF24);
  static const Color warningMuted = Color(0xFF3D3012);
  static const Color info = Color(0xFF60A5FA);
  static const Color infoMuted = Color(0xFF1C2A3D);

  // ── Utility ──────────────────────────────────────────────────
  static const Color divider = Color(0xFF1E1E2E);
  static const Color border = Color(0xFF2A2A3C);
  static const Color borderFocus = Color(0xFF8B5CF6);
  static const Color shimmerBase = Color(0xFF1A1A26);
  static const Color shimmerHighlight = Color(0xFF2A2A3C);
  static const Color scrim = Color(0xCC000000);

  // ── Online / Status ──────────────────────────────────────────
  static const Color online = Color(0xFF34D399);
  static const Color offline = Color(0xFF5A5A72);
  static const Color busy = Color(0xFFF87171);
  static const Color away = Color(0xFFFBBF24);
}
