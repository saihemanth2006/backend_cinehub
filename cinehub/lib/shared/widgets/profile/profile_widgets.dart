import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/theme.dart';
import '../media/cached_avatar.dart';
import '../chips/chips.dart';

/// Full profile card with cover, avatar, stats, and actions.
class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String? location;
  final String? imageUrl;
  final List<String> skills;
  final int followers;
  final int projects;
  final bool isVerified;
  final VoidCallback? onTap;
  final VoidCallback? onFollow;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
    this.location,
    this.imageUrl,
    this.skills = const [],
    this.followers = 0,
    this.projects = 0,
    this.isVerified = false,
    this.onTap,
    this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadii.borderLg,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover gradient
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: AppGradients.primarySoft,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
            ),
            // Avatar + Info
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.surface, width: 3),
                          ),
                          child: CachedAvatar(name: name, imageUrl: imageUrl, size: 48),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: onFollow,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: AppColors.primaryMuted,
                              borderRadius: AppRadii.borderFull,
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                            ),
                            child: Text('Follow', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(child: Text(name, style: AppTypography.labelLarge, overflow: TextOverflow.ellipsis)),
                            if (isVerified) ...[
                              const SizedBox(width: 4),
                              const Icon(Iconsax.verify5, size: 14, color: AppColors.primary),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(role, style: AppTypography.caption),
                        if (location != null) ...[
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Iconsax.location, size: 10, color: AppColors.textTertiary),
                              const SizedBox(width: 3),
                              Text(location!, style: AppTypography.labelSmall),
                            ],
                          ),
                        ],
                        const SizedBox(height: AppSpacing.sm),
                        // Stats
                        Row(
                          children: [
                            Text('$followers', style: AppTypography.labelMedium),
                            Text(' followers', style: AppTypography.caption),
                            const SizedBox(width: AppSpacing.md),
                            Text('$projects', style: AppTypography.labelMedium),
                            Text(' projects', style: AppTypography.caption),
                          ],
                        ),
                        if (skills.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: skills.take(3).map((s) => SkillChip(label: s)).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact creator row for lists.
class CreatorListTile extends StatelessWidget {
  final String name;
  final String role;
  final String? imageUrl;
  final double? rating;
  final VoidCallback? onTap;

  const CreatorListTile({
    super.key,
    required this.name,
    required this.role,
    this.imageUrl,
    this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadii.borderMd,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            CachedAvatar(name: name, imageUrl: imageUrl, size: 44),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.labelLarge),
                  Text(role, style: AppTypography.caption),
                ],
              ),
            ),
            if (rating != null) ...[
              const Icon(Iconsax.star1, size: 14, color: AppColors.accent),
              const SizedBox(width: 3),
              Text(rating!.toStringAsFixed(1), style: AppTypography.labelMedium.copyWith(color: AppColors.accent)),
            ],
            const SizedBox(width: AppSpacing.sm),
            const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
