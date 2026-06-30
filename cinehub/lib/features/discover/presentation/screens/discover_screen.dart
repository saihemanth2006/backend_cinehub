import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/inputs/inputs.dart';
import '../../../../shared/widgets/chips/chips.dart';
import '../../../../shared/widgets/media/cached_avatar.dart';
import '../../../../shared/widgets/cards/cards.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedFilter = 0;
  final _filters = ['All', 'Directors', 'Cinematographers', 'Writers', 'Editors', 'Actors', 'VFX Artists'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            title: Text('Discover Talent', style: AppTypography.h1),
          ),

          // ── Search ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.md),
              child: const AppSearchBar(
                hint: 'Search creators, skills, locations...',
              ),
            ),
          ),

          // ── Filters ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) => AppFilterChip(
                  label: _filters[index],
                  isSelected: _selectedFilter == index,
                  onTap: () => setState(() => _selectedFilter = index),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

          // ── Featured Creator ────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _FeaturedCreatorCard(),
            ).animate().fadeIn(duration: 500.ms),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          // ── Creator Grid ────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 8,
              itemBuilder: (context, index) => _CreatorCard(index: index)
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 400.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _FeaturedCreatorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2D1B69), Color(0xFF1A1A26)],
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Row(
        children: [
          const CachedAvatar(name: 'Sarah Chen', size: 64),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Featured Creator', style: AppTypography.overline.copyWith(color: AppColors.accent)),
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(Iconsax.verify5, size: 16, color: AppColors.accent),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text('Sarah Chen', style: AppTypography.h2),
                Text('Award-winning Cinematographer', style: AppTypography.bodySmall),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const SkillChip(label: 'Cinematography'),
                    const SizedBox(width: AppSpacing.xs),
                    const SkillChip(label: 'Color Grade', color: AppColors.accent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CreatorCard extends StatefulWidget {
  final int index;
  const _CreatorCard({required this.index});

  static const _names = ['Alex Rivera', 'Mia Tanaka', 'James Wright', 'Priya Sharma', 'Omar Hassan', 'Luna Park', 'Dev Patel', 'Zara Kim'];
  static const _roles = ['Director', 'Editor', 'VFX Artist', 'Screenwriter', 'Cinematographer', 'Sound Design', 'Producer', 'Actor'];
  static const _ratings = ['4.9', '4.8', '4.7', '4.9', '4.6', '4.8', '4.7', '4.9'];
  static const _location = ['Mumbai, IN', 'Tokyo, JP', 'LA, USA', 'Delhi, IN', 'Cairo, EG', 'Seoul, KR', 'Bangalore, IN', 'Seoul, KR'];
  static const _skills = [
    ['Directing', 'Cinematography'],
    ['Editing', 'Color Grading'],
    ['VFX', 'Motion Graphics'],
    ['Writing', 'Script Analysis'],
    ['Cinematography', 'Lighting'],
    ['Audio Mix', 'Sound Effects'],
    ['Project Management', 'Budgeting'],
    ['Acting', 'Character Work'],
  ];

  @override
  State<_CreatorCard> createState() => _CreatorCardState();
}

class _CreatorCardState extends State<_CreatorCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleCtrl;
  final bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final names = _CreatorCard._names;
    final roles = _CreatorCard._roles;
    final ratings = _CreatorCard._ratings;
    final locations = _CreatorCard._location;
    final skillsList = _CreatorCard._skills;
    final index = widget.index;

    return GestureDetector(
      onTapDown: (_) {
        _scaleCtrl.forward();
      },
      onTapUp: (_) {
        _scaleCtrl.reverse();
      },
      onTapCancel: () {
        _scaleCtrl.reverse();
      },
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Viewing ${names[index]}\'s profile'),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.primary,
          ),
        );
      },
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOut),
        ),
        child: SurfaceCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header with avatar and badge ────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedAvatar(name: names[index], size: 48),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          names[index],
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Iconsax.star1, size: 12, color: AppColors.accent),
                            const SizedBox(width: 2),
                            Text(
                              ratings[index],
                              style: AppTypography.caption.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.successMuted,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Verified',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.success,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Role and location ───────────────────────────
              Text(
                roles[index],
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Icon(Iconsax.location, size: 12, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(
                    locations[index],
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Skills ──────────────────────────────────────
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: skillsList[index].take(2).map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.background.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.border.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      skill,
                      style: AppTypography.caption.copyWith(
                        fontSize: 9,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),

              // ── Action button ───────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                    borderRadius: AppRadii.borderMd,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Center(
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceElevated,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Collaborate with ${names[index]}',
                                      style: AppTypography.h2,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${roles[index]} from ${locations[index]}',
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Cancel'),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.primary,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Collaboration request sent to ${names[index]}!'),
                                                  backgroundColor: AppColors.success,
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Send Request',
                                              style: TextStyle(color: Colors.white),
                                            ),
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
                      },
                      borderRadius: AppRadii.borderMd,
                      child: Center(
                        child: Text(
                          'Collaborate',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

