import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

// ─────────────────────────────────────────────────────────────
//  DESIGN TOKENS (matching main app)
// ─────────────────────────────────────────────────────────────
class _C {
  static const bg = Color(0xFF06060E);
  static const accent = Color(0xFF7B5CFF);
  static const accentSoft = Color(0xFF9B7FFF);
  static const rose = Color(0xFFFF3D6B);
  static const textPrimary = Color(0xFFEEECFF);
  static const textMuted = Color(0xFF4A4870);
}

// ─────────────────────────────────────────────────────────────
//  SPLASH SCREEN
// ─────────────────────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const SplashScreen({super.key, required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // ── Animation controllers ──
  late AnimationController _bgPulse;
  late AnimationController _logoReveal;
  late AnimationController _textSlide;
  late AnimationController _ringExpand;
  late AnimationController _particleCtrl;
  late AnimationController _fadeOut;

  // ── Animations ──
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textSlideAnim;
  late Animation<double> _textOpacity;
  late Animation<double> _ringScale;
  late Animation<double> _ringOpacity;
  late Animation<double> _taglineOpacity;
  late Animation<double> _fadeOutAnim;

  // ── Particles ──
  late List<_SplashParticle> _particles;

  // ── Film strip frames ──
  late AnimationController _filmStripCtrl;

  bool _navigated = false;

  // ── Audio player ──
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // ── Background pulse ──
    _bgPulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // ── Logo reveal (scale + opacity) ──
    _logoReveal = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoReveal, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoReveal, curve: const Interval(0, 0.5, curve: Curves.easeOut)),
    );

    // ── Text slide in ──
    _textSlide = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textSlideAnim = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _textSlide, curve: Curves.easeOutCubic),
    );
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textSlide, curve: Curves.easeOut),
    );

    // ── Ring expand ──
    _ringExpand = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _ringScale = Tween<double>(begin: 0.5, end: 2.5).animate(
      CurvedAnimation(parent: _ringExpand, curve: Curves.easeOutCubic),
    );
    _ringOpacity = Tween<double>(begin: 0.6, end: 0).animate(
      CurvedAnimation(parent: _ringExpand, curve: Curves.easeOut),
    );

    // ── Tagline ──
    _taglineOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textSlide, curve: const Interval(0.3, 1.0, curve: Curves.easeOut)),
    );

    // ── Particles ──
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    final rng = Random();
    _particles = List.generate(40, (_) => _SplashParticle(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      size: rng.nextDouble() * 3 + 0.5,
      speed: rng.nextDouble() * 0.4 + 0.1,
      opacity: rng.nextDouble() * 0.5 + 0.1,
      angle: rng.nextDouble() * 2 * pi,
    ));

    // ── Film strip ──
    _filmStripCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // ── Fade out ──
    _fadeOut = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeOutAnim = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _fadeOut, curve: Curves.easeIn),
    );

    // ── Orchestrate the animation sequence ──
    _startSequence();
  }

  Future<void> _startSequence() async {
    // Delay before starting
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Play splash sound
    _audioPlayer.play(AssetSource('audio/splash_sound.wav'));

    // Ring expand + Logo reveal together
    _ringExpand.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _logoReveal.forward();

    // Text slides in after logo
    await Future.delayed(const Duration(milliseconds: 800));
    _textSlide.forward();

    // Hold for viewing
    await Future.delayed(const Duration(milliseconds: 2200));

    // Fade out and navigate
    if (!_navigated && mounted) {
      _navigated = true;
      _fadeOut.forward().then((_) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => widget.nextScreen,
              transitionsBuilder: (_, anim, __, child) {
                return FadeTransition(opacity: anim, child: child);
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _bgPulse.dispose();
    _logoReveal.dispose();
    _textSlide.dispose();
    _ringExpand.dispose();
    _particleCtrl.dispose();
    _filmStripCtrl.dispose();
    _fadeOut.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _C.bg,
      body: AnimatedBuilder(
        animation: _fadeOutAnim,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeOutAnim.value,
            child: Stack(
              children: [
                // ── Animated gradient background ──
                AnimatedBuilder(
                  animation: _bgPulse,
                  builder: (context, _) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 1.2 + _bgPulse.value * 0.3,
                          colors: [
                            _C.accent.withOpacity(0.08 + _bgPulse.value * 0.04),
                            _C.bg,
                            const Color(0xFF020208),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    );
                  },
                ),

                // ── Film strip decoration (top) ──
                Positioned(
                  top: -10,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: _filmStripCtrl,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: _FilmStripPainter(
                          progress: _filmStripCtrl.value,
                          opacity: 0.06,
                        ),
                        size: Size(size.width, 40),
                      );
                    },
                  ),
                ),

                // ── Film strip decoration (bottom) ──
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: _filmStripCtrl,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: _FilmStripPainter(
                          progress: 1 - _filmStripCtrl.value,
                          opacity: 0.06,
                        ),
                        size: Size(size.width, 40),
                      );
                    },
                  ),
                ),

                // ── Floating particles ──
                AnimatedBuilder(
                  animation: _particleCtrl,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _SplashParticlePainter(
                        particles: _particles,
                        progress: _particleCtrl.value,
                      ),
                      size: Size.infinite,
                    );
                  },
                ),

                // ── Expanding ring ──
                Center(
                  child: AnimatedBuilder(
                    animation: _ringExpand,
                    builder: (context, _) {
                      return Transform.scale(
                        scale: _ringScale.value,
                        child: Opacity(
                          opacity: _ringOpacity.value,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _C.accent,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ── Second ring (delayed) ──
                Center(
                  child: AnimatedBuilder(
                    animation: _ringExpand,
                    builder: (context, _) {
                      final delayed = (_ringExpand.value - 0.2).clamp(0.0, 1.0);
                      return Transform.scale(
                        scale: 0.5 + delayed * 2.0,
                        child: Opacity(
                          opacity: (0.4 - delayed * 0.4).clamp(0.0, 1.0),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _C.rose,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ── Center content (logo + text) ──
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Clapperboard icon ──
                      AnimatedBuilder(
                        animation: _logoReveal,
                        builder: (context, _) {
                          return Transform.scale(
                            scale: _logoScale.value,
                            child: Opacity(
                              opacity: _logoOpacity.value,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [_C.accent, _C.rose],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _C.accent.withOpacity(0.5),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                    BoxShadow(
                                      color: _C.rose.withOpacity(0.3),
                                      blurRadius: 40,
                                      offset: const Offset(10, 10),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.movie_creation_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 28),

                      // ── App name ──
                      AnimatedBuilder(
                        animation: _textSlide,
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(0, _textSlideAnim.value),
                            child: Opacity(
                              opacity: _textOpacity.value,
                              child: ShaderMask(
                                shaderCallback: (b) => const LinearGradient(
                                  colors: [_C.accentSoft, _C.rose],
                                ).createShader(b),
                                child: const Text(
                                  'CineHub',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      // ── Tagline ──
                      AnimatedBuilder(
                        animation: _textSlide,
                        builder: (context, _) {
                          return Opacity(
                            opacity: _taglineOpacity.value,
                            child: const Text(
                              'Where Cinema Meets Community',
                              style: TextStyle(
                                color: _C.textMuted,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 3,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // ── Bottom loading indicator ──
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: _textSlide,
                    builder: (context, _) {
                      return Opacity(
                        opacity: _textOpacity.value,
                        child: Center(
                          child: SizedBox(
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: AnimatedBuilder(
                                animation: _bgPulse,
                                builder: (context, _) {
                                  return LinearProgressIndicator(
                                    value: null,
                                    backgroundColor: _C.textMuted.withOpacity(0.2),
                                    valueColor: AlwaysStoppedAnimation(
                                      Color.lerp(_C.accent, _C.rose, _bgPulse.value)!,
                                    ),
                                    minHeight: 2,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ── Corner accent dots ──
                ..._buildCornerDots(size),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildCornerDots(Size size) {
    return [
      // Top-left
      Positioned(
        top: 40,
        left: 24,
        child: AnimatedBuilder(
          animation: _logoReveal,
          builder: (context, _) {
            return Opacity(
              opacity: _logoOpacity.value * 0.3,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: _C.accent,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
      // Top-right
      Positioned(
        top: 40,
        right: 24,
        child: AnimatedBuilder(
          animation: _logoReveal,
          builder: (context, _) {
            return Opacity(
              opacity: _logoOpacity.value * 0.3,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: _C.rose,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    ];
  }
}

// ─────────────────────────────────────────────────────────────
//  ANIMATED BUILDER HELPER
// ─────────────────────────────────────────────────────────────
class AnimatedBuilder extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;
  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) => builder(context, null);
}

// ─────────────────────────────────────────────────────────────
//  SPLASH PARTICLE
// ─────────────────────────────────────────────────────────────
class _SplashParticle {
  double x, y, size, speed, opacity, angle;
  _SplashParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.angle,
  });
}

class _SplashParticlePainter extends CustomPainter {
  final List<_SplashParticle> particles;
  final double progress;

  _SplashParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final dx = p.x * size.width + cos(p.angle + progress * 2 * pi * p.speed) * 30;
      final dy = (p.y * size.height - progress * p.speed * 200) % size.height;
      final paint = Paint()
        ..color = Color.lerp(_C.accent, _C.rose, p.x)!.withOpacity(p.opacity * 0.5)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.8);
      canvas.drawCircle(Offset(dx, dy), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SplashParticlePainter old) => true;
}

// ─────────────────────────────────────────────────────────────
//  FILM STRIP PAINTER
// ─────────────────────────────────────────────────────────────
class _FilmStripPainter extends CustomPainter {
  final double progress;
  final double opacity;

  _FilmStripPainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Film strip perforations
    const holeSize = 8.0;
    const spacing = 28.0;
    final offset = progress * spacing;

    // Top holes
    for (double x = -spacing + offset; x < size.width + spacing; x += spacing) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(x, 8), width: holeSize, height: holeSize * 1.4),
        const Radius.circular(2),
      );
      canvas.drawRRect(rect, paint);
    }

    // Bottom holes
    for (double x = -spacing + offset; x < size.width + spacing; x += spacing) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(x, size.height - 8), width: holeSize, height: holeSize * 1.4),
        const Radius.circular(2),
      );
      canvas.drawRRect(rect, paint);
    }

    // Border lines
    canvas.drawLine(Offset(0, 18), Offset(size.width, 18), borderPaint);
    canvas.drawLine(Offset(0, size.height - 18), Offset(size.width, size.height - 18), borderPaint);
  }

  @override
  bool shouldRepaint(covariant _FilmStripPainter old) => old.progress != progress;
}
