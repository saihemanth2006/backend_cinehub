import 'package:flutter/material.dart';

// Ambient orbs background animation
class _AmbientOrbs extends StatelessWidget {
  final AnimationController pulse;
  const _AmbientOrbs({required this.pulse});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (_, __) => Stack(
        children: [
          Positioned(
            top: -120,
            right: -80,
            child: _Orb(
              size: 320,
              color: const Color(
                0xFF8B5CF6,
              ).withOpacity(0.12 + 0.06 * pulse.value),
            ),
          ),
          Positioned(
            bottom: 280,
            left: -80,
            child: _Orb(
              size: 260,
              color: const Color(
                0xFFEC4899,
              ).withOpacity(0.08 + 0.05 * pulse.value),
            ),
          ),
          Positioned(
            bottom: -60,
            right: 60,
            child: _Orb(
              size: 200,
              color: const Color(
                0xFF10B981,
              ).withOpacity(0.07 + 0.04 * pulse.value),
            ),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
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
  const _GradientIcon({
    required this.icon,
    required this.size,
    required this.colors,
  });

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
          child: Text(
            'Search projects, scripts, gear...',
            style: TextStyle(color: Color(0x47FFFFFF), fontSize: 13.5),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF8B5CF6).withOpacity(0.2),
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Text(
            '⌘ K',
            style: TextStyle(
              color: Color(0xFF8B5CF6),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
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
      child: CustomPaint(painter: _SprocketPainter(anim.value)),
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
    final shift = (progress * step * 4) % step;
    for (double x = -step + shift; x < size.width + step; x += step) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 0, holeW, holeH),
          const Radius.circular(2),
        ),
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
    width: 88,
    height: 44,
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
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
        ),
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
    top: 0,
    bottom: 0,
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
    child: Text(
      label,
      style: TextStyle(
        color: color.withOpacity(0.9),
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _GlowButton extends StatelessWidget {
  final String label;
  final List<Color> colors;
  final VoidCallback onTap;
  const _GlowButton({
    required this.label,
    required this.colors,
    required this.onTap,
  });

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
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 14,
          ),
        ],
      ),
    ),
  );
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (r) => LinearGradient(
            colors: [color, color.withOpacity(0.7)],
          ).createShader(r),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white30, fontSize: 10.5),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 28, color: Colors.white.withOpacity(0.08));
}

class _QuickActionCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _QuickActionCard({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tap;

  @override
  void initState() {
    super.initState();
    _tap = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
  }

  @override
  void dispose() {
    _tap.dispose();
    super.dispose();
  }

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
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(widget.icon, color: widget.color, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
