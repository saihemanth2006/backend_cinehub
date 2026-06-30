import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradientBorder extends StatefulWidget {
  final Widget child;
  final bool isActive;
  final double borderRadius;
  final double borderWidth;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;

  const AnimatedGradientBorder({
    super.key,
    required this.child,
    this.isActive = false,
    this.borderRadius = 50.0,
    this.borderWidth = 2.0,
    this.gradientColors = const [
      Color(0xFF8B5CF6),
      Color(0xFFEC4899),
      Color(0xFF8B5CF6)
    ],
    this.backgroundColor = const Color(0xff151515),
    this.boxShadow,
  });

  @override
  State<AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    if (widget.isActive) _controller.repeat();
  }

  @override
  void didUpdateWidget(AnimatedGradientBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(widget.isActive ? widget.borderWidth : 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: widget.boxShadow,
            gradient: widget.isActive
                ? SweepGradient(
                    colors: widget.gradientColors,
                    transform: GradientRotation(_controller.value * 2 * math.pi),
                  )
                : null,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(
                  widget.borderRadius - (widget.isActive ? widget.borderWidth : 0.0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  widget.borderRadius - (widget.isActive ? widget.borderWidth : 0.0)),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
