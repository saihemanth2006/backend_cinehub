import 'package:flutter/material.dart';
import 'app_spacing.dart';
import 'app_sizes.dart';

/// CineHub responsive design system
/// 
/// Provides adaptive scaling for all screen sizes (mobile, tablet, desktop)
/// while maintaining design consistency across viewports.
/// 
/// Usage:
/// ```dart
/// final responsive = Responsive.of(context);
/// final padding = responsive.padding;  // Adapts based on screen width
/// final fontSize = responsive.scaledFont(18);
/// final columns = responsive.columns;  // 1 on mobile, 2+ on tablet
/// ```
class Responsive {
  final BuildContext context;
  final MediaQueryData mediaQuery;

  Responsive({required this.context}) 
    : mediaQuery = MediaQuery.of(context);

  /// Get responsive instance from context
  static Responsive of(BuildContext context) => Responsive(context: context);

  // ── Screen Dimensions ────────────────────────────────────────────────────

  /// Screen width in logical pixels
  double get width => mediaQuery.size.width;

  /// Screen height in logical pixels
  double get height => mediaQuery.size.height;

  /// Device pixel ratio (scale factor)
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Viewport padding (status bar, notch, etc.)
  EdgeInsets get viewportPadding => mediaQuery.viewInsets;

  /// Safe area padding
  EdgeInsets get safePadding => mediaQuery.padding;

  // ── Breakpoints ──────────────────────────────────────────────────────────

  /// Breakpoint for mobile (< 500dp)
  static const double breakpointMobile = 500;

  /// Breakpoint for tablet (500-800dp)
  static const double breakpointTablet = 800;

  /// Breakpoint for desktop (> 800dp)
  static const double breakpointDesktop = 1200;

  /// Is mobile-sized device
  bool get isMobile => width < breakpointTablet;

  /// Is tablet-sized device
  bool get isTablet => width >= breakpointTablet && width < breakpointDesktop;

  /// Is desktop-sized device
  bool get isDesktop => width >= breakpointDesktop;

  /// Is small screen (phone portrait)
  bool get isSmallScreen => width < 380;

  /// Is large screen (tablet/desktop)
  bool get isLargeScreen => width > 600;

  /// Is landscape orientation
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Is portrait orientation
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  // ── Responsive Spacing ──────────────────────────────────────────────────

  /// Get adaptive horizontal padding based on screen width
  EdgeInsets get padding {
    if (isSmallScreen) return const EdgeInsets.symmetric(horizontal: 12);
    if (isMobile) return const EdgeInsets.symmetric(horizontal: 16);
    if (isTablet) return const EdgeInsets.symmetric(horizontal: 24);
    return const EdgeInsets.symmetric(horizontal: 32);
  }

  /// Get adaptive vertical padding
  EdgeInsets get paddingVertical {
    if (isMobile) return const EdgeInsets.symmetric(vertical: 16);
    if (isTablet) return const EdgeInsets.symmetric(vertical: 24);
    return const EdgeInsets.symmetric(vertical: 32);
  }

  /// Get adaptive all-side padding
  EdgeInsets get paddingAll {
    if (isSmallScreen) return const EdgeInsets.all(12);
    if (isMobile) return const EdgeInsets.all(16);
    if (isTablet) return const EdgeInsets.all(24);
    return const EdgeInsets.all(32);
  }

  /// Scale spacing value based on screen width
  double scaleSpacing(double baseValue) {
    if (isSmallScreen) return baseValue * 0.8;
    if (isMobile) return baseValue;
    if (isTablet) return baseValue * 1.2;
    return baseValue * 1.4;
  }

  /// Get adaptive spacing between items
  double get itemSpacing {
    if (isSmallScreen) return AppSpacing.sm;
    if (isMobile) return AppSpacing.md;
    if (isTablet) return AppSpacing.lg;
    return AppSpacing.xl;
  }

  // ── Responsive Typography ────────────────────────────────────────────────

  /// Scale font size based on screen width
  double scaledFont(double baseSize) {
    if (isSmallScreen) return baseSize * 0.85;
    if (isMobile) return baseSize;
    if (isTablet) return baseSize * 1.1;
    if (isDesktop) return baseSize * 1.2;
    return baseSize;
  }

  /// Get line height for text based on screen
  double get lineHeight {
    if (isMobile) return 1.5;
    if (isTablet) return 1.6;
    return 1.7;
  }

  // ── Responsive Grid ──────────────────────────────────────────────────────

  /// Number of columns for grid layout
  int get columns {
    if (isMobile) return 1;
    if (isTablet) return 2;
    if (isDesktop) return 3;
    return 4;
  }

  /// Number of columns for wide grid
  int get columnsWide {
    if (isMobile) return 2;
    if (isTablet) return 3;
    if (isDesktop) return 4;
    return 6;
  }

  /// Item width for grid layout (accounting for gaps)
  double gridItemWidth(int columns, [double gap = 12]) {
    final totalGap = gap * (columns - 1);
    final availableWidth = width - padding.horizontal - totalGap;
    return availableWidth / columns;
  }

  // ── Responsive Widths ────────────────────────────────────────────────────

  /// Get max width for content container
  double get maxContentWidth {
    if (isMobile) return width;
    if (isTablet) return 600;
    return 900;
  }

  /// Get adaptive card width
  double get cardWidth {
    if (isMobile) return width - padding.horizontal;
    if (isTablet) return (width - padding.horizontal - 12) / 2;
    return 300;
  }

  /// Get half screen width (for side-by-side layouts)
  double get halfWidth => (width - padding.horizontal) / 2;

  /// Get third screen width (for three-column layouts)
  double get thirdWidth => (width - padding.horizontal) / 3;

  // ── Responsive Heights ───────────────────────────────────────────────────

  /// Get adaptive card height
  double get cardHeight {
    if (isSmallScreen) return 140;
    if (isMobile) return 160;
    if (isTablet) return 200;
    return 240;
  }

  /// Get compact card height
  double get compactCardHeight {
    if (isMobile) return 100;
    if (isTablet) return 120;
    return 140;
  }

  /// Get hero section height
  double get heroHeight {
    if (isMobile) return 200;
    if (isTablet) return 300;
    return 400;
  }

  // ── Responsive Component Sizes ───────────────────────────────────────────

  /// Get adaptive avatar size
  double avatarSize(String size) {
    const baseMap = {
      'sm': AppSizes.avatarSm,
      'md': AppSizes.avatarMd,
      'lg': AppSizes.avatarLg,
    };
    
    double baseSize = baseMap[size] ?? AppSizes.avatarMd;
    
    if (isSmallScreen) return baseSize * 0.85;
    if (isMobile) return baseSize;
    if (isTablet) return baseSize * 1.1;
    return baseSize * 1.2;
  }

  /// Get adaptive icon size
  double iconSize(String size) {
    const baseMap = {
      'sm': AppSizes.iconSm,
      'md': AppSizes.iconMd,
      'lg': AppSizes.iconLg,
    };
    
    double baseSize = baseMap[size] ?? AppSizes.iconMd;
    
    if (isSmallScreen) return baseSize * 0.9;
    if (isMobile) return baseSize;
    if (isTablet) return baseSize * 1.1;
    return baseSize * 1.15;
  }

  // ── Aspect Ratios ────────────────────────────────────────────────────────

  /// Standard video aspect ratio (16:9)
  double get aspectRatio169 => 16 / 9;

  /// Square aspect ratio
  double get aspectRatioSquare => 1;

  /// Portrait aspect ratio (4:5)
  double get aspectRatioPortrait => 4 / 5;

  // ── Utility Methods ──────────────────────────────────────────────────────

  /// Clamp value between min and max
  double clamp(double value, double min, double max) {
    return value.clamp(min, max);
  }

  /// Scale value proportionally to screen
  double proportional(double percentage) {
    return width * (percentage / 100);
  }

  /// Get breakpoint name for debugging
  String get breakpointName {
    if (isSmallScreen) return 'small';
    if (isMobile) return 'mobile';
    if (isTablet) return 'tablet';
    if (isDesktop) return 'desktop';
    return 'unknown';
  }

  @override
  String toString() {
    return 'Responsive(width: $width, height: $height, breakpoint: $breakpointName)';
  }
}
