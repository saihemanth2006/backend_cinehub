import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/theme/theme.dart';

// ═══════════════════════════════════════════════════════════
// ═  AI MODULE CARD
// ═══════════════════════════════════════════════════════════

/// Premium card for displaying an AI module in the hub.
class AiModuleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String taskCount;
  final Color accentColor;
  final VoidCallback? onTap;
  final bool isComingSoon;

  const AiModuleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.taskCount,
    required this.accentColor,
    this.onTap,
    this.isComingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isComingSoon ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadii.borderLg,
          border: Border.all(
            color: isComingSoon
                ? AppColors.border
                : accentColor.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.15),
                        accentColor.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: AppRadii.borderMd,
                  ),
                  child: Icon(icon, size: 20, color: accentColor),
                ),
                const Spacer(),
                if (isComingSoon)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.warningMuted,
                      borderRadius: AppRadii.borderFull,
                    ),
                    child: Text(
                      'Soon',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.warning,
                        fontSize: 9,
                      ),
                    ),
                  )
                else
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: AppRadii.borderFull,
                    ),
                    child: Text(
                      taskCount,
                      style: AppTypography.labelSmall.copyWith(
                        color: accentColor,
                        fontSize: 9,
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: AppTypography.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTypography.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ═  AI TASK CHIP
// ═══════════════════════════════════════════════════════════

/// Selectable chip for an AI task within a module.
class AiTaskChip extends StatelessWidget {
  final String label;
  final String? description;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback? onTap;

  const AiTaskChip({
    super.key,
    required this.label,
    this.description,
    this.isSelected = false,
    this.accentColor = AppColors.primary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withValues(alpha: 0.12)
              : AppColors.surface,
          borderRadius: AppRadii.borderFull,
          border: Border.all(
            color: isSelected
                ? accentColor
                : AppColors.border,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? accentColor : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ═  AI RESPONSE VIEWER
// ═══════════════════════════════════════════════════════════

/// Expandable card for displaying structured AI responses.
class AiStructuredResponse extends StatefulWidget {
  final String title;
  final Map<String, dynamic> data;
  final String? module;
  final String? task;
  final int? tokensUsed;
  final int? generationTimeMs;
  final VoidCallback? onCopy;
  final VoidCallback? onRegenerate;

  const AiStructuredResponse({
    super.key,
    required this.title,
    required this.data,
    this.module,
    this.task,
    this.tokensUsed,
    this.generationTimeMs,
    this.onCopy,
    this.onRegenerate,
  });

  @override
  State<AiStructuredResponse> createState() => _AiStructuredResponseState();
}

class _AiStructuredResponseState extends State<AiStructuredResponse> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.borderLg,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: AppTypography.labelLarge),
                        if (widget.generationTimeMs != null)
                          Text(
                            '${widget.generationTimeMs}ms • ${widget.tokensUsed ?? 0} tokens',
                            style: AppTypography.caption.copyWith(fontSize: 10),
                          ),
                      ],
                    ),
                  ),
                  if (widget.onCopy != null)
                    IconButton(
                      icon: const Icon(Iconsax.copy, size: 16),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: widget.data.toString()),
                        );
                        widget.onCopy?.call();
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                  if (widget.onRegenerate != null)
                    IconButton(
                      icon: const Icon(Iconsax.refresh, size: 16),
                      onPressed: widget.onRegenerate,
                      visualDensity: VisualDensity.compact,
                    ),
                  Icon(
                    _isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
          ),

          // Content
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildDataWidgets(widget.data),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildDataWidgets(Map<String, dynamic> data) {
    return data.entries.map((entry) {
      if (entry.value is List) {
        return _buildListSection(entry.key, entry.value as List);
      } else if (entry.value is Map) {
        return _buildMapSection(
            entry.key, Map<String, dynamic>.from(entry.value));
      } else {
        return _buildKeyValue(entry.key, entry.value.toString());
      }
    }).toList();
  }

  Widget _buildKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatKey(key),
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildListSection(String key, List items) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatKey(key),
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          ...items.map((item) {
            if (item is Map) {
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: AppRadii.borderMd,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (item as Map<String, dynamic>).entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${_formatKey(e.key)}: ',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextSpan(
                              text: e.value.toString(),
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•  ', style: AppTypography.bodySmall.copyWith(color: AppColors.primary)),
                  Expanded(child: Text(item.toString(), style: AppTypography.bodySmall)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMapSection(String key, Map<String, dynamic> map) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatKey(key),
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: AppRadii.borderMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: map.entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${_formatKey(e.key)}: ',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: e.value.toString(),
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    // Convert camelCase to Title Case
    return key
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (m) => ' ${m.group(0)}',
        )
        .trim()
        .split(' ')
        .map((w) => w.isNotEmpty
            ? '${w[0].toUpperCase()}${w.substring(1)}'
            : w)
        .join(' ');
  }
}

// ═══════════════════════════════════════════════════════════
// ═  AI LOADING SHIMMER
// ═══════════════════════════════════════════════════════════

/// Cinematic loading indicator for AI generation.
class AiLoadingIndicator extends StatefulWidget {
  final String? status;
  final String? module;

  const AiLoadingIndicator({super.key, this.status, this.module});

  @override
  State<AiLoadingIndicator> createState() => _AiLoadingIndicatorState();
}

class _AiLoadingIndicatorState extends State<AiLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.borderLg,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    startAngle: 0,
                    endAngle: 6.28,
                    transform:
                        GradientRotation(_controller.value * 6.28),
                    colors: [
                      AppColors.primary,
                      AppColors.accent,
                      AppColors.secondary,
                      AppColors.primary,
                    ],
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Iconsax.cpu, size: 20, color: AppColors.primary),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            widget.status ?? 'Generating...',
            style: AppTypography.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'AI is processing your request',
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }
}
