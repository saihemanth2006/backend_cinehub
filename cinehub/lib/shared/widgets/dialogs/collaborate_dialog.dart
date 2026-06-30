import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/theme.dart';
import '../buttons/buttons.dart';

/// Dialog for requesting collaboration on projects.
class CollaborateDialog extends StatefulWidget {
  final VoidCallback onConfirm;
  final String? creatorName;

  const CollaborateDialog({
    super.key,
    required this.onConfirm,
    this.creatorName,
  });

  @override
  State<CollaborateDialog> createState() => _CollaborateDialogState();
}

class _CollaborateDialogState extends State<CollaborateDialog> {
  String? _selectedType;
  final _msgCtrl = TextEditingController();

  final List<Map<String, dynamic>> _projectTypes = [
    {"label": "Short Film", "icon": Iconsax.video, "color": Color(0xFFFF8C00)},
    {"label": "Feature Film", "icon": Iconsax.camera, "color": Color(0xFFFF3D00)},
    {"label": "Commercial", "icon": Iconsax.volume_high, "color": Color(0xFF4A00E0)},
    {"label": "Music Video", "icon": Iconsax.music, "color": Color(0xFF00D4FF)},
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ────────────────────────────────────────────
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppGradients.primary,
                        borderRadius: AppRadii.borderMd,
                      ),
                      child: const Icon(Iconsax.people, size: 24, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Request Collaboration', style: AppTypography.labelLarge),
                          const SizedBox(height: 2),
                          Text(
                            'with ${widget.creatorName ?? "this creator"}',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.5),
                          borderRadius: AppRadii.borderSm,
                        ),
                        child: Icon(Iconsax.close_square, size: 18, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Project type chips ─────────────────────────────────
                Text(
                  'Project Type',
                  style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _projectTypes.map((type) {
                    final isSelected = _selectedType == type['label'];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedType = type['label']),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: [type['color'], type['color'].withValues(alpha: 0.7)],
                                )
                              : null,
                          color: isSelected ? null : AppColors.background.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : AppColors.border.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              type['icon'],
                              size: 16,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              type['label'],
                              style: AppTypography.labelSmall.copyWith(
                                color: isSelected ? Colors.white : AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // ── Optional message ───────────────────────────────────
                Text(
                  'Message (optional)',
                  style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.5),
                    borderRadius: AppRadii.borderMd,
                    border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
                  ),
                  child: TextField(
                    controller: _msgCtrl,
                    maxLines: 3,
                    maxLength: 200,
                    style: AppTypography.bodySmall,
                    decoration: InputDecoration(
                      hintText: 'Tell them about your project idea...',
                      hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(12),
                      counterStyle: AppTypography.caption.copyWith(color: AppColors.textTertiary),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Action buttons ─────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: GhostButton(
                        label: 'Cancel',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Send Request',
                        icon: Iconsax.send_1,
                        onPressed: _selectedType != null ? widget.onConfirm : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
