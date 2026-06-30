import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/router/routes.dart';
import '../../../../shared/widgets/media/cached_avatar.dart';
import '../../../../shared/widgets/chips/chips.dart';
import '../../../../shared/widgets/buttons/buttons.dart';
import '../../../../shared/widgets/dialogs/collaborate_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Cover + Avatar
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(gradient: AppGradients.primarySoft),
                ),
                Positioned(
                  top: 140,
                  left: AppSpacing.lg,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 4),
                    ),
                    child: const CachedAvatar(name: 'You', size: 80),
                  ),
                ),
                Positioned(
                  top: 44,
                  right: AppSpacing.lg,
                  child: Row(
                    children: [
                      GhostButton(label: 'Edit', icon: Iconsax.edit, onPressed: () {}),
                      const SizedBox(width: 8),
                      _AppBarAction(
                        icon: Iconsax.setting_2,
                        onTap: () => context.push(Routes.settings),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),

          // Info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Name', style: AppTypography.h1),
                  const SizedBox(height: 4),
                  Text('Director & Screenwriter', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Iconsax.location, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text('Mumbai, India', style: AppTypography.caption),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Stats
                  Row(
                    children: [
                      _StatItem(value: '2.4K', label: 'Followers'),
                      const SizedBox(width: AppSpacing.xxl),
                      _StatItem(value: '186', label: 'Following'),
                      const SizedBox(width: AppSpacing.xxl),
                      _StatItem(value: '12', label: 'Projects'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Bio
                  Text(
                    'Passionate filmmaker with 8+ years of experience in indie and commercial cinema. Specializing in character-driven narratives.',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary, height: 1.6),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Skills
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: const [
                      SkillChip(label: 'Directing'),
                      SkillChip(label: 'Screenwriting', color: AppColors.accent),
                      SkillChip(label: 'Editing', color: AppColors.success),
                      SkillChip(label: 'Color Grading', color: AppColors.info),
                      SkillChip(label: 'Cinematography', color: AppColors.secondary),
                    ],
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          // Portfolio preview
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Portfolio', style: AppTypography.h2),
                  TextButton(onPressed: () {}, child: Text('See all', style: AppTypography.labelMedium.copyWith(color: AppColors.primary))),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                itemBuilder: (_, i) => _PortfolioPreview(index: i),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          // ── Quick Settings Menu ──────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quick Settings', style: AppTypography.h2),
                  const SizedBox(height: AppSpacing.md),
                  _MenuTile(
                    icon: Iconsax.setting_2,
                    iconColor: AppColors.primary,
                    title: 'Settings',
                    subtitle: 'App preferences & configuration',
                    onTap: () => context.push(Routes.settings),
                  ),
                  _MenuTile(
                    icon: Iconsax.notification,
                    iconColor: AppColors.accent,
                    title: 'Notifications',
                    subtitle: 'Manage your alerts',
                    badge: '3',
                    onTap: () {},
                  ),
                  _MenuTile(
                    icon: Iconsax.document,
                    iconColor: AppColors.info,
                    title: 'My Applications',
                    subtitle: 'Track your job applications',
                    onTap: () {},
                  ),
                  _MenuTile(
                    icon: Iconsax.bookmark,
                    iconColor: AppColors.success,
                    title: 'Saved Items',
                    subtitle: 'Projects, jobs & creators',
                    onTap: () {},
                  ),
                  _MenuTile(
                    icon: Iconsax.message_question,
                    iconColor: AppColors.warning,
                    title: 'Help & Support',
                    subtitle: 'FAQ and contact us',
                    onTap: () {},
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.h2),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _PortfolioPreview extends StatelessWidget {
  final int index;
  const _PortfolioPreview({required this.index});

  static const _colors = [AppColors.primary, AppColors.accent, AppColors.secondary, AppColors.success];
  static const _labels = ['Short Film', 'Music Video', 'Documentary', 'Commercial'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_colors[index].withValues(alpha: 0.3), AppColors.surface],
        ),
        borderRadius: AppRadii.borderLg,
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 12, left: 12,
            child: Text(_labels[index], style: AppTypography.labelMedium.copyWith(color: Colors.white)),
          ),
          const Positioned(
            top: 8, right: 8,
            child: Icon(Iconsax.play_circle, color: Colors.white70, size: 24),
          ),
        ],
      ),
    );
  }
}

/// Circular app bar action button (settings gear, etc.)
class _AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AppBarAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.7),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Icon(icon, size: AppSizes.iconSm, color: AppColors.textPrimary),
      ),
    );
  }
}

/// Menu tile for the quick settings section on the profile screen.
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback? onTap;

  const _MenuTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadii.borderLg,
          splashColor: AppColors.primaryGlow,
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadii.borderLg,
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: Icon(icon, color: iconColor, size: AppSizes.iconSm),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.labelLarge),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(AppRadii.full),
                    ),
                    child: Text(
                      badge!,
                      style: AppTypography.labelSmall.copyWith(color: Colors.white, fontSize: 10),
                    ),
                  ),
                if (badge == null)
                  const Icon(Iconsax.arrow_right_3, size: 16, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
