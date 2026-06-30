import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/cards/cards.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Echoes of Tomorrow',
        'type': 'Sci-Fi Thriller',
        'views': '12.4K',
        'rating': '4.8',
        'year': '2024',
        'color': const Color(0xFF4A00E0),
      },
      {
        'title': 'Midnight Run',
        'type': 'Action Drama',
        'views': '8.7K',
        'rating': '4.6',
        'year': '2024',
        'color': const Color(0xFFFF3D00),
      },
      {
        'title': 'The Last Frame',
        'type': 'Documentary',
        'views': '15.2K',
        'rating': '4.9',
        'year': '2023',
        'color': const Color(0xFF00D4FF),
      },
      {
        'title': 'Digital Dreams',
        'type': 'Music Video',
        'views': '24.1K',
        'rating': '4.7',
        'year': '2023',
        'color': const Color(0xFFFF8C00),
      },
      {
        'title': 'Silent Shadows',
        'type': 'Noir Crime',
        'views': '9.3K',
        'rating': '4.5',
        'year': '2023',
        'color': const Color(0xFF00E676),
      },
      {
        'title': 'Neon Nights',
        'type': 'Cyberpunk',
        'views': '5.6K',
        'rating': '4.4',
        'year': '2023',
        'color': const Color(0xFF7C4DFF),
      },
      {
        'title': 'Urban Lens',
        'type': 'Indie Short',
        'views': '3.4K',
        'rating': '4.7',
        'year': '2022',
        'color': const Color(0xFF00BCD4),
      },
      {
        'title': 'Timeless',
        'type': 'Experimental',
        'views': '2.1K',
        'rating': '4.6',
        'year': '2022',
        'color': const Color(0xFFE91E63),
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            title: Text('Portfolio', style: AppTypography.h1),
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // ── Filter & Sort ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceElevated,
                        borderRadius: AppRadii.borderMd,
                        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                      ),
                      child: DropdownButton<String>(
                        value: 'Recent',
                        items: ['Recent', 'Popular', 'Oldest', 'Highest Rated']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (_) {},
                        isExpanded: true,
                        underline: const SizedBox(),
                        hint: Text('Sort by', style: AppTypography.bodySmall),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: AppRadii.borderMd,
                      border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                    ),
                    child: Icon(Iconsax.setting_2, size: 20, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),

          // ── Projects Grid ───────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: projects.length,
              itemBuilder: (_, index) => _PortfolioCard(
                project: projects[index],
                index: index,
              ).animate(delay: Duration(milliseconds: index * 50)).fadeIn().slideY(begin: 0.02),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _PortfolioCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;

  const _PortfolioCard({required this.project, required this.index});

  @override
  State<_PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<_PortfolioCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleCtrl;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleCtrl.forward(),
      onTapUp: (_) => _scaleCtrl.reverse(),
      onTapCancel: () => _scaleCtrl.reverse(),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Viewing: ${widget.project['title']}'),
          backgroundColor: widget.project['color'],
          duration: const Duration(seconds: 2),
        ),
      ),
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOut),
        ),
        child: SurfaceCard(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Thumbnail ───────────────────────────────────
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.project['color'],
                        widget.project['color'].withValues(alpha: 0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadii.lg),
                      topRight: Radius.circular(AppRadii.lg),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // ── Play button ──────────────────────────
                      Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.play,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // ── Year badge ──────────────────────────
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.project['year'],
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // ── Views badge ─────────────────────────
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.eye,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.project['views'],
                              style: AppTypography.caption.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Info ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project['title'],
                      style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.project['type'],
                      style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Iconsax.star1, size: 12, color: AppColors.accent),
                        const SizedBox(width: 2),
                        Text(
                          widget.project['rating'],
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
            ],
          ),
        ),
      ),
    );
  }
}
