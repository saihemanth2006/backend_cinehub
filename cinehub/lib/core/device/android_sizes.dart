import 'package:flutter/material.dart';

/// Android device size categories and responsive scaling helpers.
///
/// Designed for the real-world distribution of Android screen sizes:
/// - Compact:  320–360 dp (budget phones, older devices)
/// - Standard: 360–411 dp (most mid-range, Pixel 7, Galaxy A-series)
/// - Large:    412–600 dp (flagships, Galaxy S/Note, OnePlus)
/// - XLarge:   600+ dp   (small tablets, foldable inner screen)
enum AndroidScreenCategory { compact, standard, large, xlarge }

class AndroidSizes {
  AndroidSizes._();

  // ── Breakpoints ──────────────────────────────────────────────
  static const double compactMax = 360.0;
  static const double standardMax = 411.0;
  static const double largeMax = 600.0;

  // ── Common Android densities ─────────────────────────────────
  static const double mdpi = 1.0;
  static const double hdpi = 1.5;
  static const double xhdpi = 2.0;
  static const double xxhdpi = 3.0;
  static const double xxxhdpi = 4.0;

  // ── Typical Android system insets ────────────────────────────
  static const double statusBarHeight = 24.0;
  static const double navigationBarHeight = 48.0;
  static const double gestureNavHeight = 16.0;

  /// Determine the current device's screen category.
  static AndroidScreenCategory category(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < compactMax) return AndroidScreenCategory.compact;
    if (width < standardMax) return AndroidScreenCategory.standard;
    if (width < largeMax) return AndroidScreenCategory.large;
    return AndroidScreenCategory.xlarge;
  }

  /// Scale a value based on the device category.
  ///
  /// ```dart
  /// final padding = AndroidSizes.scale(context, compact: 12, standard: 16, large: 20);
  /// ```
  static double scale(
    BuildContext context, {
    required double compact,
    required double standard,
    double? large,
    double? xlarge,
  }) {
    switch (category(context)) {
      case AndroidScreenCategory.compact:
        return compact;
      case AndroidScreenCategory.standard:
        return standard;
      case AndroidScreenCategory.large:
        return large ?? standard;
      case AndroidScreenCategory.xlarge:
        return xlarge ?? large ?? standard;
    }
  }

  /// Whether the device uses gesture navigation (no 3-button nav).
  static bool usesGestureNav(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom > gestureNavHeight;
  }

  /// Effective content width minus horizontal screen padding.
  static double contentWidth(BuildContext context, {double padding = 16}) {
    return MediaQuery.sizeOf(context).width - (padding * 2);
  }

  /// Number of grid columns for responsive layouts.
  static int gridColumns(BuildContext context) {
    switch (category(context)) {
      case AndroidScreenCategory.compact:
        return 2;
      case AndroidScreenCategory.standard:
        return 2;
      case AndroidScreenCategory.large:
        return 3;
      case AndroidScreenCategory.xlarge:
        return 4;
    }
  }

  /// Bottom padding that accounts for gesture nav or button nav.
  static double safeBottomPadding(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return bottom > 0 ? bottom : navigationBarHeight;
  }
}
