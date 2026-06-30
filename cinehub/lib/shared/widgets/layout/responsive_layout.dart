import 'package:flutter/material.dart';
import '../../../core/theme/responsive.dart';

/// Adaptive layout widget that rebuilds when screen size changes
/// 
/// Usage:
/// ```dart
/// AdaptiveLayout(
///   builder: (context, responsive) => Column(
///     children: [
///       SizedBox(height: responsive.itemSpacing),
///     ],
///   ),
/// )
/// ```
class AdaptiveLayout extends StatelessWidget {
  final Widget Function(BuildContext context, Responsive responsive) builder;

  const AdaptiveLayout({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final responsive = Responsive.of(context);
        return builder(context, responsive);
      },
    );
  }
}

/// Responsive padding wrapper
/// 
/// Usage:
/// ```dart
/// ResponsivePadding(
///   child: Text('Content'),
/// )
/// ```
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final bool horizontal;
  final bool vertical;

  const ResponsivePadding({
    required this.child,
    this.horizontal = true,
    this.vertical = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    
    if (horizontal && vertical) {
      return Padding(
        padding: responsive.paddingAll,
        child: child,
      );
    } else if (horizontal) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.padding.left,
        ),
        child: child,
      );
    } else if (vertical) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: responsive.paddingVertical.top,
        ),
        child: child,
      );
    }
    
    return child;
  }
}

/// Responsive gap between widgets (replaces SizedBox with adaptive sizing)
class ResponsiveGap extends StatelessWidget {
  final Axis direction;
  final bool adaptive;

  const ResponsiveGap({
    this.direction = Axis.vertical,
    this.adaptive = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!adaptive) {
      return direction == Axis.vertical
          ? const SizedBox(height: 16)
          : const SizedBox(width: 16);
    }

    final responsive = Responsive.of(context);
    final gap = responsive.itemSpacing;

    return direction == Axis.vertical
        ? SizedBox(height: gap)
        : SizedBox(width: gap);
  }
}

/// Responsive grid view that adapts column count based on screen size
class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final int? columnsOverride;
  final double gap;
  final ScrollPhysics physics;

  const ResponsiveGridView({
    required this.children,
    this.columnsOverride,
    this.gap = 12,
    this.physics = const NeverScrollableScrollPhysics(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final columns = columnsOverride ?? responsive.columns;

    return GridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: gap,
      crossAxisSpacing: gap,
      physics: physics,
      shrinkWrap: true,
      children: children,
    );
  }
}

/// Responsive flex container that adapts to screen size
/// 
/// Usage:
/// ```dart
/// ResponsiveFlex(
///   children: [
///     Flexible(child: Widget1()),
///     Flexible(child: Widget2()),
///   ],
/// )
/// ```
class ResponsiveFlex extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveFlex({
    required this.children,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    
    // On small screens, stack vertically
    final effectiveDirection = responsive.isSmallScreen && direction == Axis.horizontal
        ? Axis.vertical
        : direction;

    if (effectiveDirection == Axis.horizontal) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    } else {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    }
  }
}

/// Responsive spacer that takes up available space
class ResponsiveSpacer extends StatelessWidget {
  final int flex;

  const ResponsiveSpacer({
    this.flex = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: const SizedBox.expand(),
    );
  }
}

/// Responsive container with max width constraint
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final Alignment alignment;

  const ResponsiveContainer({
    required this.child,
    this.maxWidth,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final effectiveMaxWidth = maxWidth ?? responsive.maxContentWidth;

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
        child: child,
      ),
    );
  }
}

/// Responsive text that scales font size based on screen
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double baseSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    this.style,
    this.baseSize = 16,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final scaledSize = responsive.scaledFont(baseSize);

    return Text(
      text,
      style: (style ?? TextStyle(fontSize: baseSize)).copyWith(
        fontSize: scaledSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive divider with adaptive height
class ResponsiveDivider extends StatelessWidget {
  final double? height;
  final Color? color;

  const ResponsiveDivider({
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final effectiveHeight = height ?? responsive.scaleSpacing(16);

    return SizedBox(height: effectiveHeight);
  }
}

/// Responsive row that wraps on small screens
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final MainAxisAlignment mainAxisAlignment;

  const ResponsiveRow({
    required this.children,
    this.gap = 12,
    this.mainAxisAlignment = MainAxisAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    if (responsive.isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) SizedBox(height: gap),
          ],
        ],
      );
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i < children.length - 1) SizedBox(width: gap),
        ],
      ],
    );
  }
}

/// Responsive two-column layout that stacks on mobile
class ResponsiveTwoColumn extends StatelessWidget {
  final Widget first;
  final Widget second;
  final double gap;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveTwoColumn({
    required this.first,
    required this.second,
    this.gap = 16,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    if (responsive.isMobile) {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          first,
          SizedBox(height: gap),
          second,
        ],
      );
    }

    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Expanded(child: first),
        SizedBox(width: gap),
        Expanded(child: second),
      ],
    );
  }
}

/// Responsive sliver padding for CustomScrollView
class ResponsiveSliverPadding extends StatelessWidget {
  final Widget sliver;

  const ResponsiveSliverPadding({
    required this.sliver,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return SliverPadding(
      padding: responsive.padding,
      sliver: sliver,
    );
  }
}
