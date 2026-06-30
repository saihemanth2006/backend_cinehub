import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/theme.dart';
import '../media/cached_avatar.dart';
import '../chips/chips.dart';

/// Film project card for dashboards and project lists.
class ProjectCard extends StatelessWidget {
  final String title;
  final String genre;
  final String status;
  final Color statusColor;
  final int teamSize;
  final double progress;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.genre,
    this.status = 'In Progress',
    this.statusColor = AppColors.primary,
    this.teamSize = 0,
    this.progress = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadii.borderLg,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: AppRadii.borderMd,
                  ),
                  child: Icon(Iconsax.video, size: 20, color: statusColor),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.labelLarge, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(genre, style: AppTypography.caption),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: AppRadii.borderFull,
                  ),
                  child: Text(status, style: AppTypography.labelSmall.copyWith(color: statusColor)),
                ),
              ],
            ),
            // Progress
            if (progress > 0) ...[
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: AppRadii.borderFull,
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppColors.surfaceElevated,
                        valueColor: AlwaysStoppedAnimation(statusColor),
                        minHeight: 4,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text('${(progress * 100).round()}%', style: AppTypography.labelSmall.copyWith(color: statusColor)),
                ],
              ),
            ],
            // Footer
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(Iconsax.people, size: 14, color: AppColors.textTertiary),
                const SizedBox(width: 4),
                Text('$teamSize members', style: AppTypography.caption),
                const Spacer(),
                const Icon(Iconsax.arrow_right_3, size: 14, color: AppColors.textTertiary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal project card for carousels.
class ProjectCardCompact extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const ProjectCardCompact({
    super.key,
    required this.title,
    required this.subtitle,
    this.color = AppColors.primary,
    this.icon = Iconsax.video,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withValues(alpha: 0.2), AppColors.surface],
          ),
          borderRadius: AppRadii.borderLg,
          border: Border.all(color: color.withValues(alpha: 0.2), width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 24, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelLarge, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Notification tile for notification list.
class NotificationTile extends StatelessWidget {
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color color;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.body,
    required this.time,
    this.icon = Iconsax.notification,
    this.color = AppColors.primary,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: isRead ? AppColors.background : AppColors.surface,
          border: Border(bottom: BorderSide(color: AppColors.divider, width: 0.5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: AppRadii.borderMd,
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.labelMedium.copyWith(
                    color: isRead ? AppColors.textSecondary : AppColors.textPrimary,
                  )),
                  const SizedBox(height: 2),
                  Text(body, style: AppTypography.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(time, style: AppTypography.labelSmall),
                ],
              ),
            ),
            if (!isRead)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
