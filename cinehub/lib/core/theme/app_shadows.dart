import 'package:flutter/material.dart';
import 'app_colors.dart';

/// CineHub shadow and elevation system for dark theme.
///
/// Uses subtle colored glows instead of traditional drop shadows
/// to create depth on dark backgrounds.
class AppShadows {
  AppShadows._();

  // ── Glow shadows (dark theme) ────────────────────────────────
  static const BoxShadow subtle = BoxShadow(
    color: Color(0x0AFFFFFF),
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  static const BoxShadow sm = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  static const BoxShadow md = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  static const BoxShadow lg = BoxShadow(
    color: Color(0x29000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  static const BoxShadow xl = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 24,
    offset: Offset(0, 12),
  );

  // ── Brand glow ───────────────────────────────────────────────
  static BoxShadow primaryGlow({double opacity = 0.3}) => BoxShadow(
        color: AppColors.primary.withValues(alpha: opacity),
        blurRadius: 20,
        spreadRadius: -4,
        offset: const Offset(0, 4),
      );

  static BoxShadow accentGlow({double opacity = 0.3}) => BoxShadow(
        color: AppColors.accent.withValues(alpha: opacity),
        blurRadius: 20,
        spreadRadius: -4,
        offset: const Offset(0, 4),
      );

  // ── Elevation presets ────────────────────────────────────────
  static const List<BoxShadow> elevation0 = [];
  static const List<BoxShadow> elevation1 = [subtle];
  static const List<BoxShadow> elevation2 = [sm];
  static const List<BoxShadow> elevation3 = [md];
  static const List<BoxShadow> elevation4 = [lg];
  static const List<BoxShadow> elevation5 = [xl];
}
