import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Curated gradient presets for the cinematic dark UI.
class AppGradients {
  AppGradients._();

  // ── Hero / Brand gradients ───────────────────────────────────
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.secondary],
  );

  static const LinearGradient primarySoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryMuted, AppColors.secondaryMuted],
  );

  static const LinearGradient accent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.accent, Color(0xFFEF4444)],
  );

  // ── Surface gradients ────────────────────────────────────────
  static const LinearGradient surfaceFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.surfaceElevated, AppColors.surface],
  );

  static const LinearGradient cardSheen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E1E2E),
      Color(0xFF15151F),
    ],
  );

  // ── Overlay gradients ────────────────────────────────────────
  static const LinearGradient imageOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xCC08080D),
    ],
  );

  static const LinearGradient imageOverlayFull = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x4008080D),
      Color(0xE608080D),
    ],
  );

  // ── Background glow (behind hero cards) ──────────────────────
  static const RadialGradient heroGlow = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [
      Color(0x208B5CF6),
      Colors.transparent,
    ],
  );

  // ── Mesh-like ambient ────────────────────────────────────────
  static const LinearGradient ambientPurple = LinearGradient(
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
    colors: [
      Color(0x108B5CF6),
      Colors.transparent,
      Color(0x10EC4899),
    ],
  );
}
