import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/inputs/inputs.dart';
import '../../../../shared/widgets/chips/chips.dart';
import '../../../../shared/widgets/cards/cards.dart';
import '../../../../../screens/jobs/jobs_page.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});
  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _selectedFilter = 0;
  final _filters = ['All', 'Director', 'DOP', 'Editor', 'Writer', 'Actor', 'VFX'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            title: Text('Opportunities', style: AppTypography.h1),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: TabBar(
                controller: _tabController,
                tabs: const [Tab(text: 'Browse'), Tab(text: 'Applied'), Tab(text: 'Saved')],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            // Use the centralized JobsPage which now consumes realtime data
            const JobsPage(),
            _EmptyTab(icon: Iconsax.document, label: 'No applications yet'),
            _EmptyTab(icon: Iconsax.bookmark, label: 'No saved jobs'),
          ],
        ),
      ),
    );
  }
}

class _BrowseTab extends StatelessWidget {
  final List<String> filters;
  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;

  const _BrowseTab({required this.filters, required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: const AppSearchBar(hint: 'Search jobs, roles...'),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => AppFilterChip(
                label: filters[i],
                isSelected: selectedFilter == i,
                onTap: () => onFilterChanged(i),
              ),
            ),
          ),
        ),
        // Featured
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _FeaturedJob(),
          ).animate().fadeIn(duration: 500.ms),
        ),
        // Jobs list
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.separated(
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => _JobCard(index: i).animate().fadeIn(delay: Duration(milliseconds: 100 * i)),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _FeaturedJob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradient: const LinearGradient(colors: [Color(0xFF1A3D2E), Color(0xFF1A1A26)]),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.successMuted, borderRadius: AppRadii.borderFull),
                child: Text('Featured', style: AppTypography.labelSmall.copyWith(color: AppColors.success)),
              ),
              const Spacer(),
              const Icon(Iconsax.bookmark, size: 20, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),
          Text('Lead Cinematographer', style: AppTypography.h2),
          const SizedBox(height: 4),
          Text('Stellar Productions • Mumbai, IN', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            children: [
              SkillChip(label: 'Feature Film', color: AppColors.success),
              SkillChip(label: '₹8-12L/month', color: AppColors.accent),
              SkillChip(label: 'On-site', color: AppColors.info),
            ],
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatefulWidget {
  final int index;
  const _JobCard({required this.index});

  static const _titles = ['VFX Supervisor', 'Film Editor', 'Sound Designer', 'Script Supervisor', 'Color Grader', 'Production Mgr'];
  static const _companies = ['Pixar Studios', 'Netflix India', 'Dolby Labs', 'Warner Bros', 'DaVinci Post', 'Yash Raj Films'];
  static const _types = ['Feature Film', 'Series', 'Commercial', 'Documentary', 'Music Video', 'Corporate'];
  static const _salary = ['₹15-18L/month', '₹12-15L/month', '₹10-13L/month', '₹11-14L/month', '₹13-16L/month', '₹14-17L/month'];
  static const _locations = ['Mumbai, IN', 'Los Angeles, USA', 'London, UK', 'Delhi, IN', 'Vancouver, CA', 'Sydney, AU'];

  @override
  State<_JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<_JobCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleCtrl;

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
    final titles = _JobCard._titles;
    final companies = _JobCard._companies;
    final types = _JobCard._types;
    final salary = _JobCard._salary;
    final locations = _JobCard._locations;
    final index = widget.index;

    return GestureDetector(
      onTapDown: (_) => _scaleCtrl.forward(),
      onTapUp: (_) => _scaleCtrl.reverse(),
      onTapCancel: () => _scaleCtrl.reverse(),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Job: ${titles[index]} at ${companies[index]}'),
            backgroundColor: AppColors.success,
          ),
        );
      },
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.96).animate(
          CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOut),
        ),
        child: SurfaceCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A00E0), Color(0xFF0081CF)],
                      ),
                      borderRadius: AppRadii.borderMd,
                    ),
                    child: const Icon(Iconsax.briefcase, size: 22, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles[index],
                          style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          companies[index],
                          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentMuted,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Hiring',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Details ─────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _DetailItem(
                      icon: Iconsax.briefcase,
                      label: types[index],
                    ),
                  ),
                  Expanded(
                    child: _DetailItem(
                      icon: Iconsax.location,
                      label: locations[index],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ── Salary ──────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successMuted,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.dollar_circle, size: 14, color: AppColors.success),
                    const SizedBox(width: 6),
                    Text(
                      salary[index],
                      style: AppTypography.caption.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Apply button ────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 32,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                    borderRadius: AppRadii.borderMd,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Applied for ${titles[index]}!'),
                            backgroundColor: AppColors.success,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      borderRadius: AppRadii.borderMd,
                      child: Center(
                        child: Text(
                          'Apply Now',
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

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _EmptyTab extends StatelessWidget {
  final IconData icon;
  final String label;
  const _EmptyTab({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColors.textTertiary),
          const SizedBox(height: 12),
          Text(label, style: AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}
