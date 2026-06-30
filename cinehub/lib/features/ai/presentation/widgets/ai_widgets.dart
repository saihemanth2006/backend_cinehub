///
/// @file ai_widgets.dart
/// @description Supplemental AI UI widgets — AILoadingWidget, TypingTextAnimation, AIModuleCard.
/// NOTE: AIResponseCard lives in shared/widgets/ai/ai_widgets.dart (single source of truth).
///
library;

import 'package:flutter/material.dart';
import 'package:cinehub/core/theme/app_colors.dart';


/// Animated loading indicator with typing effect
class AILoadingWidget extends StatefulWidget {
  final String? message;
  final Duration animationDuration;

  const AILoadingWidget({
    super.key,
    this.message = 'Generating with AI...',
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  State<AILoadingWidget> createState() => _AILoadingWidgetState();
}

class _AILoadingWidgetState extends State<AILoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _dotsController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Animated glow effect
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 80 + (30 * _pulseController.value),
              height: 80 + (30 * _pulseController.value),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.3),
                    AppColors.primary.withOpacity(0),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.auto_awesome,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 24),
        // Message with typing dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.message ?? 'Generating with AI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            AnimatedBuilder(
              animation: _dotsController,
              builder: (context, child) {
                final progress = _dotsController.value;
                return Row(
                  children: [
                    Opacity(
                      opacity: (progress > 0 && progress < 0.4) ? 1 : 0.3,
                      child: Text('.', style: TextStyle(color: AppColors.primary)),
                    ),
                    SizedBox(width: 2),
                    Opacity(
                      opacity: (progress > 0.3 && progress < 0.7) ? 1 : 0.3,
                      child: Text('.', style: TextStyle(color: AppColors.primary)),
                    ),
                    SizedBox(width: 2),
                    Opacity(
                      opacity: (progress > 0.6) ? 1 : 0.3,
                      child: Text('.', style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Typing Animation ────────────────────────────────────────
/// Text with typewriter animation effect
class TypingTextAnimation extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle? style;
  final VoidCallback? onComplete;

  const TypingTextAnimation({
    super.key,
    required this.text,
    this.duration = const Duration(milliseconds: 50),
    this.style,
    this.onComplete,
  });

  @override
  State<TypingTextAnimation> createState() => _TypingTextAnimationState();
}

class _TypingTextAnimationState extends State<TypingTextAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late int _displayedCharacters = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration * widget.text.length,
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {
        _displayedCharacters =
            (widget.text.length * _controller.value).ceil();
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.substring(0, _displayedCharacters),
      style: widget.style,
    );
  }
}

// ─── AI Module Card ─────────────────────────────────────────
/// Card for displaying available AI modules
class AIModuleCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final int taskCount;
  final VoidCallback onTap;
  final bool isSelected;

  const AIModuleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.taskCount,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [AppColors.primary.withOpacity(0.3), AppColors.primary.withOpacity(0.1)]
                : [AppColors.darkBg, AppColors.darkBg.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.primary.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 28,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '$taskCount tasks',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
