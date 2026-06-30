import 'package:flutter/material.dart';

/// Android-specific sizing constants and device breakpoints.
///
/// Designed for portrait-first mobile layouts with Material 3 touch targets.
/// All values are optimized for common Android screen sizes (360–430dp width).
class AppSizes {
  AppSizes._();

  // ── Touch Targets (Material 3) ─────────────────────────────────
  static const double touchTargetMin = 48.0;
  static const double touchTargetMd = 56.0;
  static const double touchTargetLg = 64.0;

  // ── App Bar ────────────────────────────────────────────────────
  static const double appBarHeight = 56.0;
  static const double appBarElevated = 64.0;

  // ── Bottom Navigation ──────────────────────────────────────────
  static const double bottomNavHeight = 64.0;
  static const double bottomNavIconSize = 24.0;
  static const double bottomNavLabelSize = 12.0;

  // ── Screen-level padding ───────────────────────────────────────
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets screenPaddingLg = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets screenPaddingAll = EdgeInsets.all(16);

  // ── Cards ──────────────────────────────────────────────────────
  static const double cardMinHeight = 80.0;
  static const double cardImageHeight = 180.0;
  static const double cardCompactHeight = 100.0;
  static const double cardHeroHeight = 220.0;

  // ── Avatars ────────────────────────────────────────────────────
  static const double avatarXs = 28.0;
  static const double avatarSm = 36.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 80.0;
  static const double avatarHero = 120.0;

  // ── Icon sizes ─────────────────────────────────────────────────
  static const double iconXs = 14.0;
  static const double iconSm = 18.0;
  static const double iconMd = 22.0;
  static const double iconLg = 28.0;
  static const double iconXl = 36.0;
  static const double iconHero = 48.0;

  // ── Buttons ────────────────────────────────────────────────────
  static const double buttonHeight = 48.0;
  static const double buttonHeightSm = 36.0;
  static const double buttonHeightLg = 56.0;

  // ── Input Fields ───────────────────────────────────────────────
  static const double inputHeight = 48.0;
  static const double inputHeightLg = 56.0;
  static const double textAreaMinHeight = 120.0;

  // ── Divider ────────────────────────────────────────────────────
  static const double dividerThin = 0.5;
  static const double dividerThick = 1.0;

  // ── Bottom Sheet ───────────────────────────────────────────────
  static const double bottomSheetHandle = 4.0;
  static const double bottomSheetHandleWidth = 36.0;
  static const double bottomSheetMaxHeight = 0.9;

  // ── Notification Badge ─────────────────────────────────────────
  static const double badgeSize = 8.0;
  static const double badgeSizeLg = 18.0;

  // ── Android Breakpoints ────────────────────────────────────────
  /// Compact phone (320–360dp)
  static const double compactWidth = 360.0;

  /// Standard phone (360–411dp)
  static const double standardWidth = 411.0;

  /// Large phone / small tablet (412–600dp)
  static const double largeWidth = 600.0;

  // ── Android System Bar Heights ─────────────────────────────────
  /// Standard Android status bar height
  static const double androidStatusBar = 24.0;

  /// Android 3-button navigation bar height
  static const double androidNavBar3Button = 48.0;

  /// Android gesture navigation bar height
  static const double androidNavBarGesture = 16.0;

  /// Android 2-button navigation bar height
  static const double androidNavBar2Button = 32.0;

  /// Whether the screen is a compact phone
  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < compactWidth;

  /// Whether the screen is standard width
  static bool isStandard(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= compactWidth &&
      MediaQuery.sizeOf(context).width < largeWidth;

  /// Whether the device is a large phone or small tablet
  static bool isLarge(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= largeWidth;

  /// Safe area bottom (for gesture navigation)
  static double safeBottom(BuildContext context) =>
      MediaQuery.paddingOf(context).bottom;

  /// Safe area top (for status bar)
  static double safeTop(BuildContext context) =>
      MediaQuery.paddingOf(context).top;

  /// Available height minus app bar and bottom nav
  static double contentHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height -
      appBarHeight -
      bottomNavHeight -
      safeTop(context) -
      safeBottom(context);

  /// Adaptive horizontal padding based on screen width
  static EdgeInsets adaptivePadding(BuildContext context) {
    if (isCompact(context)) {
      return const EdgeInsets.symmetric(horizontal: 12);
    }
    if (isLarge(context)) {
      return const EdgeInsets.symmetric(horizontal: 24);
    }
    return screenPadding;
  }

  /// Number of grid columns based on screen width
  static int gridColumns(BuildContext context) {
    if (isCompact(context)) return 2;
    if (isLarge(context)) return 3;
    return 2;
  }

  /// Card aspect ratio adapted to screen category
  static double cardAspectRatio(BuildContext context) {
    if (isCompact(context)) return 0.7;
    return 0.75;
  }
}
