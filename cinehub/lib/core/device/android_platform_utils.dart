import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Android-specific platform helpers.
///
/// Handles predictive back gestures, system UI mode,
/// and Android-specific behavior patterns.
class AndroidPlatformUtils {
  AndroidPlatformUtils._();

  /// Configure the system UI for the CineHub dark theme.
  static void configureSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF111118),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Color(0xFF111118),
      ),
    );
  }

  /// Set immersive mode (hides both status and nav bars).
  static Future<void> setImmersive() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  /// Restore edge-to-edge mode.
  static Future<void> setEdgeToEdge() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  /// Lock to portrait mode.
  static Future<void> lockPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Allow all orientations.
  static Future<void> unlockOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// Check if the device has a notch / display cutout.
  static bool hasNotch(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return padding.top > 30; // Standard status bar is ~24dp
  }

  /// Check if using gesture navigation (thin bottom bar).
  static bool usesGestureNav(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom > 0 &&
        MediaQuery.paddingOf(context).bottom < 30;
  }

  /// Provide haptic feedback for button taps.
  static void hapticTap() => HapticFeedback.lightImpact();

  /// Provide haptic feedback for selection changes.
  static void hapticSelect() => HapticFeedback.selectionClick();

  /// Provide haptic feedback for heavy/destructive actions.
  static void hapticHeavy() => HapticFeedback.heavyImpact();
}
