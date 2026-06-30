import 'package:flutter/material.dart';
import 'responsive.dart';
import 'app_spacing.dart';

/// Adaptive spacing helpers for responsive layouts
class AdaptiveSpacing {
  AdaptiveSpacing._();

  /// Get adaptive horizontal padding for screen
  static EdgeInsets horizontalPadding(BuildContext context) {
    return Responsive.of(context).padding;
  }

  /// Get adaptive vertical padding for screen
  static EdgeInsets verticalPadding(BuildContext context) {
    return Responsive.of(context).paddingVertical;
  }

  /// Get adaptive all-sides padding for screen
  static EdgeInsets allPadding(BuildContext context) {
    return Responsive.of(context).paddingAll;
  }

  /// Get gap between items (adaptive)
  static SizedBox gap(BuildContext context, {Axis direction = Axis.vertical}) {
    final size = Responsive.of(context).itemSpacing;
    return direction == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }

  /// Get small gap (adaptive)
  static SizedBox smallGap(BuildContext context, {Axis direction = Axis.vertical}) {
    final responsive = Responsive.of(context);
    final size = responsive.scaleSpacing(AppSpacing.sm);
    return direction == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }

  /// Get medium gap (adaptive)
  static SizedBox mediumGap(BuildContext context, {Axis direction = Axis.vertical}) {
    final responsive = Responsive.of(context);
    final size = responsive.scaleSpacing(AppSpacing.md);
    return direction == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }

  /// Get large gap (adaptive)
  static SizedBox largeGap(BuildContext context, {Axis direction = Axis.vertical}) {
    final responsive = Responsive.of(context);
    final size = responsive.scaleSpacing(AppSpacing.lg);
    return direction == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }

  /// Get XL gap (adaptive)
  static SizedBox xlGap(BuildContext context, {Axis direction = Axis.vertical}) {
    final responsive = Responsive.of(context);
    final size = responsive.scaleSpacing(AppSpacing.xl);
    return direction == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }

  /// Get custom spacing scaled for device
  static double scaled(BuildContext context, double baseValue) {
    return Responsive.of(context).scaleSpacing(baseValue);
  }

  /// Get proportional spacing (percentage of screen width)
  static double proportional(BuildContext context, double percentage) {
    return Responsive.of(context).proportional(percentage);
  }
}
