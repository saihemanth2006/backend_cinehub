import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/theme.dart';

/// AI response card styled like ChatGPT — used for script output, cost estimates, etc.
class AIResponseCard extends StatelessWidget {
  final String title;
  final String content;
  final bool isGenerating;
  final VoidCallback? onCopy;
  final VoidCallback? onSave;
  final VoidCallback? onRegenerate;

  const AIResponseCard({
    super.key,
    required this.title,
    required this.content,
    this.isGenerating = false,
    this.onCopy,
    this.onSave,
    this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.borderLg,
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.divider, width: 0.5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                    borderRadius: AppRadii.borderSm,
                  ),
                  child: const Icon(Iconsax.cpu, size: 14, color: Colors.white),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(title, style: AppTypography.labelLarge),
                const Spacer(),
                if (isGenerating)
                  _PulsingDot()
                else ...[
                  if (onCopy != null)
                    _ActionIcon(icon: Iconsax.copy, onTap: onCopy!),
                  if (onSave != null)
                    _ActionIcon(icon: Iconsax.document_download, onTap: onSave!),
                  if (onRegenerate != null)
                    _ActionIcon(icon: Iconsax.refresh, onTap: onRegenerate!),
                ],
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: isGenerating
                ? _TypingIndicator()
                : SelectableText(
                    content,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.7,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// AI prompt input card with send button — ChatGPT-style.
class AIPromptInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback? onSend;
  final bool isLoading;

  const AIPromptInput({
    super.key,
    required this.controller,
    this.hint = 'Describe your idea...',
    this.onSend,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadii.borderLg,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.8),
            borderRadius: AppRadii.borderLg,
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: 4,
                  minLines: 1,
                  style: AppTypography.bodyMedium,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: isLoading ? null : onSend,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: isLoading ? null : AppGradients.primary,
                    color: isLoading ? AppColors.surfaceElevated : null,
                    borderRadius: AppRadii.borderMd,
                  ),
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                        )
                      : const Icon(Iconsax.send_1, size: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// AI generation progress card with animated steps.
class AIGeneratingCard extends StatelessWidget {
  final String status;
  final double progress;
  final List<String> steps;
  final int currentStep;

  const AIGeneratingCard({
    super.key,
    required this.status,
    this.progress = 0,
    this.steps = const [],
    this.currentStep = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppGradients.primarySoft,
        borderRadius: AppRadii.borderLg,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PulsingDot(),
              const SizedBox(width: AppSpacing.md),
              Text(status, style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
            ],
          ),
          if (progress > 0) ...[
            const SizedBox(height: AppSpacing.lg),
            ClipRRect(
              borderRadius: AppRadii.borderFull,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.surfaceElevated,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                minHeight: 4,
              ),
            ),
          ],
          if (steps.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            ...List.generate(steps.length, (i) {
              final isDone = i < currentStep;
              final isCurrent = i == currentStep;
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    Icon(
                      isDone ? Iconsax.tick_circle : (isCurrent ? Iconsax.clock : Iconsax.minus_cirlce),
                      size: 16,
                      color: isDone ? AppColors.success : (isCurrent ? AppColors.primary : AppColors.textTertiary),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      steps[i],
                      style: AppTypography.bodySmall.copyWith(
                        color: isDone ? AppColors.textSecondary : (isCurrent ? AppColors.textPrimary : AppColors.textTertiary),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ActionIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.md),
        child: Icon(icon, size: 18, color: AppColors.textTertiary),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary.withValues(alpha: 0.4 + _ctrl.value * 0.6),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _ctrl.value * 0.4),
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Row(
        children: List.generate(3, (i) {
          final delay = i * 0.2;
          final value = ((_ctrl.value + delay) % 1.0);
          final opacity = 0.3 + (value < 0.5 ? value : 1 - value) * 0.7;
          return Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: opacity),
            ),
          );
        }),
      ),
    );
  }
}
