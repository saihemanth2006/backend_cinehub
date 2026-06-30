import 'package:flutter/material.dart';
import 'responsive.dart';
import 'app_typography.dart';

/// Adaptive typography helpers for responsive text styling
class AdaptiveTypography {
  AdaptiveTypography._();

  /// Get display large style scaled for device
  static TextStyle displayLarge(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.displayLarge;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(48),
      height: responsive.lineHeight,
    );
  }

  /// Get display medium style scaled for device
  static TextStyle displayMedium(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.displayMedium;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(36),
      height: responsive.lineHeight,
    );
  }

  /// Get display small style scaled for device
  static TextStyle displaySmall(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.displaySmall;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(28),
      height: responsive.lineHeight,
    );
  }

  /// Get h1 style scaled for device
  static TextStyle h1(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.h1;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(24),
      height: responsive.lineHeight,
    );
  }

  /// Get h2 style scaled for device
  static TextStyle h2(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.h2;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(20),
      height: responsive.lineHeight,
    );
  }

  /// Get h3 style scaled for device
  static TextStyle h3(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.h3;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(18),
      height: responsive.lineHeight,
    );
  }

  /// Get body large style scaled for device
  static TextStyle bodyLarge(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.bodyLarge;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(16),
      height: responsive.lineHeight,
    );
  }

  /// Get body medium style scaled for device
  static TextStyle bodyMedium(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.bodyMedium;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(14),
      height: responsive.lineHeight,
    );
  }

  /// Get body small style scaled for device
  static TextStyle bodySmall(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.bodySmall;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(12),
      height: responsive.lineHeight,
    );
  }

  /// Get label large style scaled for device
  static TextStyle labelLarge(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.labelLarge;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(14),
      height: responsive.lineHeight,
    );
  }

  /// Get label medium style scaled for device
  static TextStyle labelMedium(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.labelMedium;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(12),
      height: responsive.lineHeight,
    );
  }

  /// Get label small style scaled for device
  static TextStyle labelSmall(BuildContext context) {
    final responsive = Responsive.of(context);
    final baseStyle = AppTypography.labelSmall;
    return baseStyle.copyWith(
      fontSize: responsive.scaledFont(11),
      height: responsive.lineHeight,
    );
  }

  /// Get custom font size scaled for device
  static TextStyle custom({
    required BuildContext context,
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    final responsive = Responsive.of(context);
    return TextStyle(
      fontFamily: AppTypography.fontFamily,
      fontSize: responsive.scaledFont(fontSize),
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height ?? responsive.lineHeight,
    );
  }
}
