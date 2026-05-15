import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  // ── Design tokens (matching app theme) ──────────────────────
  static const _bg = Color(0xFF06060E);
  static const _card = Color(0xFF111120);
  static const _cardBorder = Color(0xFF1A1A2E);
  static const _accent = Color(0xFF7B5CFF);
  static const _accentSoft = Color(0xFF9B7FFF);
  static const _rose = Color(0xFFFF3D6B);
  static const _amber = Color(0xFFFFA726);
  static const _textPrimary = Color(0xFFEEECFF);
  static const _textSec = Color(0xFF8884AA);
  static const _textMuted = Color(0xFF4A4870);

  String _selectedFilter = 'All';
  static const _filters = [
    'All', 'Acting', 'Direction', 'Cinematography',
    'Editing', 'Writing', 'Production', 'VFX'
  ];

  static const _jobs = [
    (
      title: 'Lead Actor – Feature Film',
      company: 'Red Curtain Productions',
      location: 'Mumbai, MH',
      type: 'On-site',
      pay: '₹2L–₹5L',
      category: 'Acting',
      icon: Icons.theater_comedy_rounded,
      color1: Color(0xFF7B5CFF),
      color2: Color(0xFF3A1FA0),
      urgent: true,
      posted: '2h ago',
    ),
    (
      title: 'Cinematographer – OTT Series',
      company: 'StreamVision Studios',
      location: 'Hyderabad, TS',
      type: 'Contract',
      pay: '₹80k/mo',
      category: 'Cinematography',
      icon: Icons.camera_rounded,
      color1: Color(0xFF00BFA5),
      color2: Color(0xFF004D40),
      urgent: false,
      posted: '5h ago',
    ),
    (
      title: 'Screenplay Writer – Thriller',
      company: 'Noir Pictures',
      location: 'Remote',
      type: 'Freelance',
      pay: '₹50k–₹1.2L',
      category: 'Writing',
      icon: Icons.edit_note_rounded,
      color1: Color(0xFFFF3D6B),
      color2: Color(0xFF8B0024),
      urgent: false,
      posted: '1d ago',
    ),
    (
      title: 'Assistant Director – Short Film',
      company: 'Indie Frames Co.',
      location: 'Delhi, DL',
      type: 'On-site',
      pay: '₹25k–₹40k',
      category: 'Direction',
      icon: Icons.movie_filter_rounded,
      color1: Color(0xFFFFA726),
      color2: Color(0xFF6D3400),
      urgent: true,
      posted: '3h ago',
    ),
    (
      title: 'VFX Artist – Sci-Fi Feature',
      company: 'Pixel Storm VFX',
      location: 'Bengaluru, KA',
      type: 'Hybrid',
      pay: '₹60k–₹1.5L',
      category: 'VFX',
      icon: Icons.auto_fix_high_rounded,
      color1: Color(0xFF00D4FF),
      color2: Color(0xFF003356),
      urgent: false,
      posted: '2d ago',
    ),
    (
      title: 'Video Editor – Documentary',
      company: 'RealLens Films',
      location: 'Remote',
      type: 'Freelance',
      pay: '₹30k–₹60k',
      category: 'Editing',
      icon: Icons.cut_rounded,
      color1: Color(0xFF7C3AED),
      color2: Color(0xFF2E1065),
      urgent: false,
      posted: '4h ago',
    ),
    (
      title: 'Line Producer – Ad Films',
      company: 'Bolt Creative Agency',
      location: 'Mumbai, MH',
      type: 'On-site',
      pay: '₹70k–₹1L',
      category: 'Production',
      icon: Icons.playlist_add_check_rounded,
      color1: Color(0xFFBE185D),
      color2: Color(0xFF500724),
      urgent: true,
      posted: '6h ago',
    ),
  ];

  List<Map<String, dynamic>> get _filtered {
    return _jobs
        .where((j) =>
            _selectedFilter == 'All' || j.category == _selectedFilter)
        .map((j) => {
              'title': j.title,
              'company': j.company,
              'location': j.location,
              'type': j.type,
              'pay': j.pay,
              'category': j.category,
              'icon': j.icon,
              'color1': j.color1,
              'color2': j.color2,
              'urgent': j.urgent,
              'posted': j.posted,
            })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (b) => const LinearGradient(
                          colors: [_accentSoft, _rose],
                        ).createShader(b),
                        child: const Text(
                          'Film Jobs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Find your next big break',
                        style: TextStyle(
                            color: _textMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Post a job button
                  GestureDetector(
                    onTap: () => HapticFeedback.mediumImpact(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [_accent, Color(0xFF9B4FE0)]),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _accent.withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_rounded,
                              color: Colors.white, size: 16),
                          SizedBox(width: 5),
                          Text('Post Job',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Stats row ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Row(
                children: [
                  _StatChip(
                      label: '124 Open',
                      icon: Icons.work_outline_rounded,
                      color: _accent),
                  const SizedBox(width: 10),
                  _StatChip(
                      label: '38 Urgent',
                      icon: Icons.bolt_rounded,
                      color: _rose),
                  const SizedBox(width: 10),
                  _StatChip(
                      label: '17 Remote',
                      icon: Icons.wifi_rounded,
                      color: _amber),
                ],
              ),
            ),

            // ── Filter chips ──────────────────────────────────
            SizedBox(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 2),
                physics: const BouncingScrollPhysics(),
                itemCount: _filters.length,
                itemBuilder: (_, i) {
                  final sel = _filters[i] == _selectedFilter;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedFilter = _filters[i]);
                      HapticFeedback.selectionClick();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: sel
                            ? const LinearGradient(
                                colors: [_accent, Color(0xFF9B4FE0)])
                            : null,
                        color: sel ? null : _card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: sel ? _accent : _cardBorder,
                            width: 0.8),
                      ),
                      child: Text(_filters[i],
                          style: TextStyle(
                              color: sel ? Colors.white : _textSec,
                              fontSize: 12,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w500)),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ── Job listings ──────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                physics: const BouncingScrollPhysics(),
                itemCount: _filtered.length,
                itemBuilder: (_, i) =>
                    _JobCard(job: _filtered[i], index: i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STAT CHIP
// ─────────────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _StatChip(
      {required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25), width: 0.8),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: color, size: 13),
        const SizedBox(width: 5),
        Text(label,
            style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  JOB CARD
// ─────────────────────────────────────────────────────────────
class _JobCard extends StatefulWidget {
  final Map<String, dynamic> job;
  final int index;
  const _JobCard({required this.job, required this.index});

  @override
  State<_JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<_JobCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  bool _saved = false;

  static const _bg = Color(0xFF06060E);
  static const _card = Color(0xFF111120);
  static const _cardBorder = Color(0xFF1A1A2E);
  static const _accent = Color(0xFF7B5CFF);
  static const _rose = Color(0xFFFF3D6B);
  static const _amber = Color(0xFFFFA726);
  static const _textPrimary = Color(0xFFEEECFF);
  static const _textSec = Color(0xFF8884AA);
  static const _textMuted = Color(0xFF4A4870);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _fade =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(
            begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(
        Duration(milliseconds: widget.index * 70), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final j = widget.job;
    final c1 = j['color1'] as Color;
    final c2 = j['color2'] as Color;
    final urgent = j['urgent'] as bool;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [c1.withOpacity(0.15), c2.withOpacity(0.08)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
                color: c1.withOpacity(0.25), width: 0.8),
          ),
          child: Container(
            margin: const EdgeInsets.all(1),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(21),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top row ─────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon box
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [c1, c2]),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(j['icon'] as IconData,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),

                    // Title + company
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Flexible(
                              child: Text(j['title'] as String,
                                  style: const TextStyle(
                                      color: _textPrimary,
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w700,
                                      height: 1.2),
                                  overflow:
                                      TextOverflow.ellipsis),
                            ),
                            if (urgent) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2),
                                decoration: BoxDecoration(
                                  color: _rose.withOpacity(0.12),
                                  borderRadius:
                                      BorderRadius.circular(6),
                                  border: Border.all(
                                      color:
                                          _rose.withOpacity(0.35),
                                      width: 0.7),
                                ),
                                child: const Text('URGENT',
                                    style: TextStyle(
                                        color: _rose,
                                        fontSize: 8,
                                        fontWeight:
                                            FontWeight.w900,
                                        letterSpacing: 0.8)),
                              ),
                            ]
                          ]),
                          const SizedBox(height: 3),
                          Text(j['company'] as String,
                              style: TextStyle(
                                  color: c1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),

                    // Save button
                    GestureDetector(
                      onTap: () {
                        setState(() => _saved = !_saved);
                        HapticFeedback.selectionClick();
                      },
                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 200),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _saved
                              ? _amber.withOpacity(0.12)
                              : _cardBorder,
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(
                              color: _saved
                                  ? _amber.withOpacity(0.4)
                                  : Colors.transparent,
                              width: 0.8),
                        ),
                        child: Icon(
                          _saved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: _saved ? _amber : _textSec,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Tags row ────────────────────────────────
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _Tag(
                        icon: Icons.location_on_outlined,
                        label: j['location'] as String,
                        color: _textSec),
                    _Tag(
                        icon: Icons.schedule_rounded,
                        label: j['type'] as String,
                        color: c1),
                    _Tag(
                        icon: Icons.currency_rupee_rounded,
                        label: j['pay'] as String,
                        color: _textSec),
                  ],
                ),

                const SizedBox(height: 14),

                // ── Apply row ───────────────────────────────
                Row(children: [
                  Text(j['posted'] as String,
                      style: const TextStyle(
                          color: _textMuted, fontSize: 11)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => HapticFeedback.mediumImpact(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 9),
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [c1, c2]),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: c1.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: const Text('Apply Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  INLINE TAG
// ─────────────────────────────────────────────────────────────
class _Tag extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Tag(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: color.withOpacity(0.18), width: 0.7),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: color, size: 11),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600)),
      ]),
    );
  }
}