import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/router/routes.dart';
import '../../../../shared/widgets/cards/cards.dart';
import '../../../../shared/widgets/layout/layout_widgets.dart';
import '../../../../shared/widgets/layout/responsive_layout.dart';
import '../../../../shared/widgets/media/cached_avatar.dart';
import '../../../../shared/widgets/project/project_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ─────────────────────────────────────────
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            title: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      gradient: AppGradients.primary,
                      borderRadius: AppRadii.borderSm,
                    ),
                    child: const Icon(Icons.movie_filter_rounded, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text('CineHub', style: AppTypography.h1),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Stack(
                  children: [
                    const Icon(Iconsax.notification, size: 22),
                    Positioned(
                      top: 0, right: 0,
                      child: Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.error),
                      ),
                    ),
                  ],
                ),
                onPressed: () => context.push('/notifications'),
              ),
              IconButton(
                icon: const Icon(Iconsax.message, size: 22),
                onPressed: () => context.push(Routes.conversations),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // ── Welcome Hero ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  gradient: AppGradients.primarySoft,
                  borderRadius: AppRadii.borderLg,
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CachedAvatar(name: 'Creator', size: 48),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Good evening, Creator', style: AppTypography.h2),
                              const SizedBox(height: 2),
                              Text('Ready to bring your vision to life?',
                                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        _Stat(icon: Iconsax.folder_2, value: '12', label: 'Projects'),
                        const SizedBox(width: AppSpacing.md),
                        _Stat(icon: Iconsax.people, value: '248', label: 'Connections'),
                        const SizedBox(width: AppSpacing.md),
                        _Stat(icon: Iconsax.cpu, value: '150', label: 'AI Credits'),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.03, end: 0),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // ── Quick Actions ───────────────────────────────────
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: _Action(icon: Iconsax.edit, label: 'New\nScript', color: AppColors.primary,
                        onTap: () => context.push(Routes.scriptGenerator)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: _Action(icon: Iconsax.folder_add, label: 'New\nProject', color: AppColors.accent,
                        onTap: () => context.push('/projects')),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: _Action(icon: Iconsax.search_normal, label: 'Find\nTalent', color: AppColors.secondary,
                        onTap: () => context.go(Routes.discover)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: _Action(icon: Iconsax.briefcase, label: 'Browse\nJobs', color: AppColors.success,
                        onTap: () => context.go(Routes.opportunities)),
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // ── Active Projects ─────────────────────────────────
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'Active Projects', actionLabel: 'See all'),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 145,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => ProjectCardCompact(
                  title: ['Echoes of Tomorrow', 'Midnight Run', 'The Last Frame', 'Digital Dreams'][i],
                  subtitle: ['Sci-Fi • 65%', 'Action • 30%', 'Doc • 90%', 'Cyber • 10%'][i],
                  color: [AppColors.primary, AppColors.accent, AppColors.success, AppColors.secondary][i],
                  icon: [Iconsax.video, Iconsax.video_play, Iconsax.camera, Iconsax.monitor][i],
                ),
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // ── AI Recommendations ──────────────────────────────
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'AI For You', subtitle: 'Personalized recommendations'),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) => _RecCard(index: i),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ── Reusable local widgets ─────────────────────────────────────

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _Stat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.5),
          borderRadius: AppRadii.borderMd,
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(value, style: AppTypography.h3),
            Text(label, style: AppTypography.caption),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;
  const _Action({required this.icon, required this.label, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: AppRadii.borderLg,
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(label, style: AppTypography.labelSmall.copyWith(color: color), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _RecCard extends StatelessWidget {
  final int index;
  const _RecCard({required this.index});

  static const _types = ['Script Idea', 'Collaborator Match', 'Job Match', 'Trending Genre'];
  static const _descs = [
    'AI suggests a noir thriller based on your portfolio',
    'Sarah Chen — Award-winning cinematographer nearby',
    'Director of Photography role matching your skills',
    'Psychological horror trending — 40% increase',
  ];
  static const _icons = [Iconsax.edit, Iconsax.user_add, Iconsax.briefcase, Iconsax.trend_up];
  static const _colors = [AppColors.primary, AppColors.accent, AppColors.success, AppColors.secondary];

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: _colors[index].withValues(alpha: 0.12),
              borderRadius: AppRadii.borderMd,
            ),
            child: Icon(_icons[index], color: _colors[index], size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_types[index], style: AppTypography.labelMedium.copyWith(color: _colors[index])),
                const SizedBox(height: 2),
                Text(_descs[index], style: AppTypography.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Iconsax.arrow_right_3, size: 14, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}
