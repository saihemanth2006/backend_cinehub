import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../ai_features/screens/ai_script_generator_screen.dart';

// ─────────────────────────────────────────────
//  DATA MODEL
// ─────────────────────────────────────────────
class FeatureItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String tag;
  final String emoji;

  const FeatureItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.tag,
    required this.emoji,
  });
}

// ─────────────────────────────────────────────
//  HOME PAGE
// ─────────────────────────────────────────────
class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> with TickerProviderStateMixin {
  late final AnimationController _heroCtrl;
  late final AnimationController _filmStripCtrl;
  late final AnimationController _pulseCtrl;
  late final AnimationController _staggerCtrl;
  late final AnimationController _reelCtrl;

  static const _features = [
    FeatureItem(
      title: 'AI Script\nGenerator',
      subtitle: 'Write compelling screenplays with AI',
      icon: Icons.auto_awesome_rounded,
      gradient: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
      tag: 'AI Powered',
      emoji: '✍️',
    ),
    FeatureItem(
      title: 'Text to\nVideo',
      subtitle: 'Turn your words into cinematic shots',
      icon: Icons.movie_creation_rounded,
      gradient: [Color(0xFFEC4899), Color(0xFFF43F5E)],
      tag: 'New ✨',
      emoji: '🎥',
    ),
    FeatureItem(
      title: 'Project\nManagement',
      subtitle: 'Schedule, budget & task manager',
      icon: Icons.dashboard_customize_rounded,
      gradient: [Color(0xFF10B981), Color(0xFF059669)],
      tag: 'Production',
      emoji: '🎬',
    ),
    FeatureItem(
      title: 'Equipment\nRental',
      subtitle: 'Cameras, lenses, lighting & more',
      icon: Icons.videocam_rounded,
      gradient: [Color(0xFFF59E0B), Color(0xFFEF4444)],
      tag: 'Marketplace',
      emoji: '📷',
    ),
    FeatureItem(
      title: 'Learning\nCenter',
      subtitle: 'Cinematography, editing & sound',
      icon: Icons.school_rounded,
      gradient: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
      tag: 'Courses',
      emoji: '🎓',
    ),
    FeatureItem(
      title: 'Film\nDistribution',
      subtitle: 'Festivals, OTT & YouTube reach',
      icon: Icons.public_rounded,
      gradient: [Color(0xFFA78BFA), Color(0xFF8B5CF6)],
      tag: 'Distribute',
      emoji: '🌐',
    ),
  ];

  static const _filmLabels = [
    ('🎬', 'Action'),
    ('✍️', 'Script'),
    ('🎥', 'Shoot'),
    ('✂️', 'Edit'),
    ('🎵', 'Sound'),
    ('🌐', 'Distribute'),
    ('📣', 'Promote'),
    ('🏆', 'Festival'),
  ];

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
      ..forward();
    _filmStripCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))
      ..repeat(reverse: true);
    _staggerCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))
      ..forward();
    _reelCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
  }

  @override
  void dispose() {
    _heroCtrl.dispose();
    _filmStripCtrl.dispose();
    _pulseCtrl.dispose();
    _staggerCtrl.dispose();
    _reelCtrl.dispose();
    super.dispose();
  }

  // ── helpers ──────────────────────────────────
  Animation<double> _interval(AnimationController ctrl, double start, double end,
      {Curve curve = Curves.easeOut}) =>
      CurvedAnimation(parent: ctrl, curve: Interval(start, end, curve: curve));

  // ── build ─────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: Stack(
        children: [
          _AmbientOrbs(pulse: _pulseCtrl),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildFilmStrip()),
                SliverToBoxAdapter(child: _buildHeroBanner()),
                SliverToBoxAdapter(child: _buildSectionLabel('All Features', '6 tools')),
                _buildFeatureGrid(),
                SliverToBoxAdapter(child: _buildStatsRow()),
                SliverToBoxAdapter(child: _buildQuickActions()),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────
  Widget _buildHeader() {
    final slide = _interval(_heroCtrl, 0.0, 0.55);
    final fade = _interval(_heroCtrl, 0.0, 0.45);
    return AnimatedBuilder(
      animation: _heroCtrl,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, -28 * (1 - slide.value)),
        child: Opacity(
          opacity: fade.value.clamp(0.0, 1.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  children: [
                    _GradientIcon(icon: Icons.movie_filter_rounded, size: 20,
                        colors: const [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
                    const SizedBox(width: 10),
                    ShaderMask(
                      shaderCallback: (r) => const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                      ).createShader(r),
                      child: const Text('CineStudio',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8)),
                    ),
                    const Spacer(),
                    _IconChip(icon: Icons.notifications_none_rounded),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFF1E1E2E),
                      child: Icon(Icons.person_rounded, color: Colors.white60, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                // Greeting
                const Text('Lights. Camera.', style: TextStyle(color: Colors.white38, fontSize: 15)),
                const SizedBox(height: 2),
                ShaderMask(
                  shaderCallback: (r) => const LinearGradient(
                    colors: [Colors.white, Color(0xFFCBB6FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(r),
                  child: const Text('Action! 🎬',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: -0.5)),
                ),
                const SizedBox(height: 6),
                const Text('Your complete filmmaking platform',
                    style: TextStyle(color: Colors.white30, fontSize: 13.5)),
                const SizedBox(height: 18),
                // Search bar
                _SearchBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── FILM STRIP ────────────────────────────────
  Widget _buildFilmStrip() {
    return AnimatedBuilder(
      animation: _filmStripCtrl,
      builder: (_, __) {
        return Container(
          margin: const EdgeInsets.only(top: 22),
          height: 44,
          color: const Color(0xFF111118),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Sprocket holes top & bottom
              Positioned(
                  top: 0, left: 0, right: 0, child: _SprocketRow(anim: _filmStripCtrl)),
              Positioned(
                  bottom: 0, left: 0, right: 0, child: _SprocketRow(anim: _filmStripCtrl)),
              // Moving labels — UnconstrainedBox lets the Row be wider than screen
              // without causing a layout overflow assertion
              Positioned.fill(
                child: OverflowBox(
                  alignment: Alignment.centerLeft,
                  maxWidth: double.infinity,
                  child: Transform.translate(
                    offset: Offset(-(_filmStripCtrl.value * 704) % 704, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ..._filmLabels.map((l) => _FilmCell(emoji: l.$1, label: l.$2)),
                        ..._filmLabels.map((l) => _FilmCell(emoji: l.$1, label: l.$2)),
                        ..._filmLabels.map((l) => _FilmCell(emoji: l.$1, label: l.$2)),
                      ],
                    ),
                  ),
                ),
              ),
              // Edge fades
              _EdgeFade(fromLeft: true),
              _EdgeFade(fromLeft: false),
            ],
          ),
        );
      },
    );
  }

  // ── HERO BANNER ───────────────────────────────
  Widget _buildHeroBanner() {
    final anim = _interval(_heroCtrl, 0.3, 0.9);
    return AnimatedBuilder(
      animation: _heroCtrl,
      builder: (_, __) => Opacity(
        opacity: anim.value.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - anim.value)),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1B1040), Color(0xFF2D1B69), Color(0xFF1E1040)],
              ),
              border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.35), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Glow blob
                  AnimatedBuilder(
                    animation: _pulseCtrl,
                    builder: (_, __) => Positioned(
                      right: -40, top: -40,
                      child: Container(
                        width: 180, height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [
                            const Color(0xFF8B5CF6).withOpacity(0.25 + 0.12 * _pulseCtrl.value),
                            Colors.transparent,
                          ]),
                        ),
                      ),
                    ),
                  ),
                  // Rotating reel
                  Positioned(
                    right: 18, bottom: 14,
                    child: AnimatedBuilder(
                      animation: _reelCtrl,
                      builder: (_, __) => Transform.rotate(
                        angle: _reelCtrl.value * 2 * math.pi,
                        child: Icon(Icons.radio_button_unchecked_rounded,
                            size: 90,
                            color: const Color(0xFF8B5CF6).withOpacity(0.18)),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 50, bottom: 46,
                    child: AnimatedBuilder(
                      animation: _reelCtrl,
                      builder: (_, __) => Transform.rotate(
                        angle: -_reelCtrl.value * 2 * math.pi,
                        child: const Icon(Icons.movie_rounded,
                            size: 28, color: Color(0xFF8B5CF6)),
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 100, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _TagChip(label: '✨  AI Script Generator', color: const Color(0xFF8B5CF6)),
                        const SizedBox(height: 8),
                        const Text('Write your next\nblockbuster screenplay',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                height: 1.22)),
                        const SizedBox(height: 10),
                        _GlowButton(
                          label: 'Generate Script',
                          colors: const [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── SECTION LABEL ─────────────────────────────
  Widget _buildSectionLabel(String title, String badge) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 4),
      child: Row(
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2)),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(badge,
                style: const TextStyle(
                    color: Color(0xFF8B5CF6), fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── FEATURE GRID ──────────────────────────────
  Widget _buildFeatureGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.63,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            final start = (i * 0.09).clamp(0.0, 0.6);
            final end = (start + 0.4).clamp(0.0, 1.0);
            final anim = _interval(_staggerCtrl, start, end);
            return AnimatedBuilder(
              animation: _staggerCtrl,
              builder: (_, __) => Transform.translate(
                offset: Offset(0, 32 * (1 - anim.value)),
                child: Opacity(
                  opacity: anim.value.clamp(0.0, 1.0),
                  child: _FeatureCard(feature: _features[i]),
                ),
              ),
            );
          },
          childCount: _features.length,
        ),
      ),
    );
  }

  // ── STATS ROW ─────────────────────────────────
  Widget _buildStatsRow() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF111118),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: const [
          _StatItem(value: '12K+', label: 'Filmmakers', color: Color(0xFF8B5CF6)),
          _StatDivider(),
          _StatItem(value: '3.5K', label: 'Projects', color: Color(0xFFEC4899)),
          _StatDivider(),
          _StatItem(value: '800+', label: 'Equipment', color: Color(0xFF10B981)),
          _StatDivider(),
          _StatItem(value: '200+', label: 'Festivals', color: Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  // ── QUICK ACTIONS ─────────────────────────────
  Widget _buildQuickActions() {
    const actions = [
      ('Upload Film', Icons.upload_file_rounded, Color(0xFFEC4899)),
      ('New Project', Icons.add_circle_outline_rounded, Color(0xFF8B5CF6)),
      ('Find Crew', Icons.group_rounded, Color(0xFF10B981)),
      ('Rent Gear', Icons.camera_alt_rounded, Color(0xFFF59E0B)),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('Quick Actions', ''),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: actions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final a = actions[i];
              return _QuickActionCard(label: a.$1, icon: a.$2, color: a.$3);
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  FEATURE CARD
// ─────────────────────────────────────────────
class _FeatureCard extends StatefulWidget {
  final FeatureItem feature;
  const _FeatureCard({required this.feature});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tap;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _tap = AnimationController(vsync: this, duration: const Duration(milliseconds: 140));
  }

  @override
  void dispose() {
    _tap.dispose();
    super.dispose();
  }

  void _down(_) { setState(() => _pressed = true); _tap.forward(); }
  void _up() { setState(() => _pressed = false); _tap.reverse(); }

  @override
  Widget build(BuildContext context) {
    final f = widget.feature;
    return GestureDetector(
      onTapDown: _down,
      onTapUp: (_) => _up(),
      onTapCancel: _up,
      onTap: () {
        _up();
        // Navigate to AI Script Generator when this feature is tapped
        if (f.title.contains('AI Script')) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const AIScriptGeneratorScreen(apiKey: ''),
          ));
          return;
        }
      },
      child: AnimatedBuilder(
        animation: _tap,
        builder: (_, child) => Transform.scale(
          scale: 1.0 - 0.035 * _tap.value,
          child: child,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: const Color(0xFF111118),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _pressed
                  ? f.gradient.first.withOpacity(0.6)
                  : Colors.white.withOpacity(0.07),
              width: _pressed ? 1.5 : 1,
            ),
            boxShadow: _pressed
                ? [BoxShadow(color: f.gradient.first.withOpacity(0.25), blurRadius: 22, spreadRadius: 1)]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon with gradient bg
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: f.gradient),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: f.gradient.first.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Icon(f.icon, color: Colors.white, size: 20),
                ),
                const SizedBox(height: 8),
                // Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: f.gradient.first.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(f.tag,
                      style: TextStyle(
                          color: f.gradient.first,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3)),
                ),
                const SizedBox(height: 6),
                Text(f.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        height: 1.25)),
                const SizedBox(height: 3),
                Text(f.subtitle,
                    style: const TextStyle(
                        color: Colors.white30,
                        fontSize: 10.5,
                        height: 1.35),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Open  →',
                        style: TextStyle(
                            color: f.gradient.first.withOpacity(0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: f.gradient),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Icon(Icons.arrow_outward_rounded,
                          color: Colors.white, size: 14),
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

// ─────────────────────────────────────────────
//  SMALL WIDGETS
// ─────────────────────────────────────────────

class _AmbientOrbs extends StatelessWidget {
  final AnimationController pulse;
  const _AmbientOrbs({required this.pulse});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (_, __) => Stack(children: [
        Positioned(
          top: -120, right: -80,
          child: _Orb(
              size: 320,
              color: const Color(0xFF8B5CF6).withOpacity(0.12 + 0.06 * pulse.value)),
        ),
        Positioned(
          bottom: 280, left: -80,
          child: _Orb(
              size: 260,
              color: const Color(0xFFEC4899).withOpacity(0.08 + 0.05 * pulse.value)),
        ),
        Positioned(
          bottom: -60, right: 60,
          child: _Orb(
              size: 200,
              color: const Color(0xFF10B981).withOpacity(0.07 + 0.04 * pulse.value)),
        ),
      ]),
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: size, height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent]),
        ),
      );
}

class _GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final List<Color> colors;
  const _GradientIcon({required this.icon, required this.size, required this.colors});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: size),
      );
}

class _IconChip extends StatelessWidget {
  final IconData icon;
  const _IconChip({required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: Colors.white.withOpacity(0.07)),
        ),
        child: Icon(icon, color: Colors.white54, size: 18),
      );
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFF111118),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: Colors.white30, size: 18),
            const SizedBox(width: 10),
            const Expanded(
              child: Text('Search projects, scripts, gear...',
                  style: TextStyle(color: Color(0x47FFFFFF), fontSize: 13.5)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withOpacity(0.2),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Text('⌘ K',
                  style: TextStyle(
                      color: Color(0xFF8B5CF6), fontSize: 11, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
}

class _SprocketRow extends StatelessWidget {
  final AnimationController anim;
  const _SprocketRow({required this.anim});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: anim,
        builder: (_, __) => SizedBox(
          height: 5,
          width: double.infinity,
          child: CustomPaint(
            painter: _SprocketPainter(anim.value),
          ),
        ),
      );
}

class _SprocketPainter extends CustomPainter {
  final double progress;
  const _SprocketPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF2A2A3A);
    const holeW = 10.0;
    const holeH = 5.0;
    const step = 18.0;
    // shift holes left as progress increases, wrapping with modulo
    final shift = (progress * step * 4) % step;
    for (double x = -step + shift; x < size.width + step; x += step) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, 0, holeW, holeH), const Radius.circular(2)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_SprocketPainter old) => old.progress != progress;
}

class _FilmCell extends StatelessWidget {
  final String emoji;
  final String label;
  const _FilmCell({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) => Container(
        width: 88, height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.white.withOpacity(0.06)),
            right: BorderSide(color: Colors.white.withOpacity(0.06)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 5),
            Text(label,
                style: const TextStyle(
                    color: Colors.white38, fontSize: 10.5, fontWeight: FontWeight.w600)),
          ],
        ),
      );
}

class _EdgeFade extends StatelessWidget {
  final bool fromLeft;
  const _EdgeFade({required this.fromLeft});

  @override
  Widget build(BuildContext context) => Positioned(
        left: fromLeft ? 0 : null,
        right: fromLeft ? null : 0,
        top: 0, bottom: 0,
        child: Container(
          width: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                fromLeft ? const Color(0xFF09090B) : Colors.transparent,
                fromLeft ? Colors.transparent : const Color(0xFF09090B),
              ],
            ),
          ),
        ),
      );
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.4), width: 0.8),
        ),
        child: Text(label,
            style: TextStyle(
                color: color.withOpacity(0.9),
                fontSize: 11.5,
                fontWeight: FontWeight.w700)),
      );
}

class _GlowButton extends StatelessWidget {
  final String label;
  final List<Color> colors;
  final VoidCallback onTap;
  const _GlowButton({required this.label, required this.colors, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                  color: colors.first.withOpacity(0.45),
                  blurRadius: 16,
                  offset: const Offset(0, 6))
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
            ],
          ),
        ),
      );
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatItem({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (r) =>
                  LinearGradient(colors: [color, color.withOpacity(0.7)]).createShader(r),
              child: Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(color: Colors.white30, fontSize: 10.5),
                textAlign: TextAlign.center),
          ],
        ),
      );
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) => Container(
        width: 1, height: 28,
        color: Colors.white.withOpacity(0.08),
      );
}

class _QuickActionCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _QuickActionCard({required this.label, required this.icon, required this.color});

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tap;

  @override
  void initState() {
    super.initState();
    _tap = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
  }

  @override
  void dispose() { _tap.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => _tap.forward(),
        onTapUp: (_) => _tap.reverse(),
        onTapCancel: () => _tap.reverse(),
        child: AnimatedBuilder(
          animation: _tap,
          builder: (_, child) =>
              Transform.scale(scale: 1.0 - 0.04 * _tap.value, child: child),
          child: Container(
            width: 110,
            decoration: BoxDecoration(
              color: const Color(0xFF111118),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: widget.color.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 18),
                ),
                const SizedBox(height: 8),
                Text(widget.label,
                    style: const TextStyle(
                        color: Colors.white60, fontSize: 11, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
}