import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/network/base_api_service.dart';
import 'dart:convert';
import 'dart:math';
import '../../services/auth_service.dart';

import '../main_screen.dart';

// Normalize string: collapse multiple consecutive spaces to single space
String normalizeString(String s, {bool preserveNewlines = false}) {
  if (s.isEmpty) return s;
  if (preserveNewlines) {
    return s.split('\n').map((line) => line.replaceAll(RegExp(r'[ \t]+'), ' ')).join('\n');
  }
  return s.replaceAll(RegExp(r'[ \t\n]+'), ' ').trim();
}

// ─────────────────────────────────────────────────────────────
//  DESIGN TOKENS (matching main app)
// ─────────────────────────────────────────────────────────────
class _C {
  static const bg = Color(0xFF06060E);
  static const surface = Color(0xFF0C0C18);
  static const card = Color(0xFF111120);
  static const cardBorder = Color(0xFF1A1A2E);
  static const accent = Color(0xFF7B5CFF);
  static const accentSoft = Color(0xFF9B7FFF);
  static const rose = Color(0xFFFF3D6B);
  static const textPrimary = Color(0xFFEEECFF);
  static const textSec = Color(0xFF8884AA);
  static const textMuted = Color(0xFF4A4870);
}

// ─────────────────────────────────────────────────────────────
//  ANIMATED BACKGROUND PARTICLES
// ─────────────────────────────────────────────────────────────
class _Particle {
  double x, y, size, speed, opacity;
  _Particle({required this.x, required this.y, required this.size, required this.speed, required this.opacity});
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  _ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final yOff = (p.y - progress * p.speed * 80) % size.height;
      final paint = Paint()
        ..color = _C.accent.withOpacity(p.opacity * 0.4)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 0.6);
      canvas.drawCircle(Offset(p.x * size.width, yOff), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => true;
}

// ─────────────────────────────────────────────────────────────
//  STYLED INPUT FIELD
// ─────────────────────────────────────────────────────────────
class _StyledField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  const _StyledField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscure = false,
    this.keyboardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: _C.textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(color: _C.textMuted.withOpacity(0.7), fontSize: 14),
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 12, right: 8),
            child: Icon(icon, color: _C.accent.withOpacity(0.7), size: 20),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  GRADIENT BUTTON
// ─────────────────────────────────────────────────────────────
class _GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final List<Color> colors;

  const _GradientButton({
    required this.text,
    this.onPressed,
    this.loading = false,
    this.colors = const [_C.accent, Color(0xFF9B4FE0)],
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1, end: 0.95).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.onPressed == null
                      ? [_C.textMuted, _C.textMuted]
                      : widget.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: widget.onPressed != null
                    ? [
                        BoxShadow(
                          color: widget.colors.first.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: widget.loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Text(
                        widget.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Helper: AnimatedBuilder is actually AnimatedWidget or we use AnimatedBuilder
class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext, Widget?) builder;
  const AnimatedBuilder({super.key, required this.animation, required this.builder});
  @override
  Widget build(BuildContext context) => AnimatedBuilder2(animation: animation, builder: builder);
}

class AnimatedBuilder2 extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;
  const AnimatedBuilder2({super.key, required Animation<double> animation, required this.builder}) : super(listenable: animation);
  @override
  Widget build(BuildContext context) => builder(context, null);
}

// ═════════════════════════════════════════════════════════════
//  LOGIN SCREEN
// ═════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoggedIn;
  final VoidCallback? onSignUpRequested;

  const LoginScreen({super.key, this.onLoggedIn, this.onSignUpRequested});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final TextEditingController _identifierCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;

  late AnimationController _particleCtrl;
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _particleCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();

    final rng = Random();
    _particles = List.generate(30, (_) => _Particle(
      x: rng.nextDouble(),
      y: rng.nextDouble() * 800,
      size: rng.nextDouble() * 3 + 1,
      speed: rng.nextDouble() * 0.5 + 0.3,
      opacity: rng.nextDouble() * 0.6 + 0.1,
    ));
  }

  @override
  void dispose() {
    _particleCtrl.dispose();
    _fadeCtrl.dispose();
    _identifierCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  Future<void> _tryLogin() async {
    final id = _identifierCtl.text.trim();
    final pwd = _passwordCtl.text;
    if (id.isEmpty || pwd.isEmpty) {
      _showSnack('Please enter your credentials', isError: true);
      return;
    }
    setState(() => _loading = true);
    try {
      final resp = await BaseApiService.post('/login', body: {'identifier': id, 'password': pwd});
      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        if (body is Map && body['ok'] == true) {
          AuthService().setFromLogin(body);
          if (!mounted) return;
          HapticFeedback.mediumImpact();
          if (widget.onLoggedIn != null) {
            widget.onLoggedIn!.call();
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
          }
          return;
        }
        String msg = 'Login failed';
        if (body is Map && body['error'] != null) msg = body['error'].toString();
        _showSnack(msg, isError: true);
      } else {
        String msg = 'Login failed';
        try {
          final body = jsonDecode(resp.body);
          if (body is Map && body['error'] != null) msg = body['error'].toString();
        } catch (_) {}
        _showSnack(msg, isError: true);
      }
    } catch (e) {
      _showSnack('Connection error: $e', isError: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? _C.rose.withOpacity(0.9) : _C.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      content: Row(
        children: [
          Icon(isError ? Icons.error_outline_rounded : Icons.check_circle_rounded,
              color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(msg, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13))),
        ],
      ),
    ));
  }

  void _openSignup() {
    if (widget.onSignUpRequested != null) {
      widget.onSignUpRequested!.call();
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Stack(
        children: [
          // ── Animated particle background ──
          AnimatedBuilder2(
            animation: _particleCtrl,
            builder: (context, _) => CustomPaint(
              painter: _ParticlePainter(_particles, _particleCtrl.value),
              size: Size.infinite,
            ),
          ),

          // ── Top gradient glow ──
          Positioned(
            top: -120,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_C.accent.withOpacity(0.15), Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Bottom rose glow ──
          Positioned(
            bottom: -80,
            right: -40,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_C.rose.withOpacity(0.08), Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Main content ──
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _C.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _C.cardBorder),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: _C.textPrimary, size: 16),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Logo / Brand
                    ShaderMask(
                      shaderCallback: (b) => const LinearGradient(
                        colors: [_C.accentSoft, _C.rose],
                      ).createShader(b),
                      child: const Text(
                        'CineHub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Welcome text
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: _C.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Sign in to continue your creative journey',
                      style: TextStyle(
                        color: _C.textSec,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Email/Username field
                    _StyledField(
                      controller: _identifierCtl,
                      label: 'Email or Username',
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 16),

                    // Password field
                    _StyledField(
                      controller: _passwordCtl,
                      label: 'Password',
                      icon: Icons.lock_outline_rounded,
                      obscure: _obscurePassword,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            color: _C.textMuted,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: _C.accentSoft,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login button
                    _GradientButton(
                      text: 'Sign In',
                      loading: _loading,
                      onPressed: _loading ? null : _tryLogin,
                    ),

                    const SizedBox(height: 28),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Container(height: 1, color: _C.cardBorder)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR', style: TextStyle(color: _C.textMuted, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        Expanded(child: Container(height: 1, color: _C.cardBorder)),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Social buttons (decorative)
                    Row(
                      children: [
                        Expanded(
                          child: _SocialButton(icon: Icons.g_mobiledata_rounded, label: 'Google', onTap: () {}),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SocialButton(icon: Icons.apple_rounded, label: 'Apple', onTap: () {}),
                        ),
                      ],
                    ),

                    const SizedBox(height: 36),

                    // Sign up link
                    Center(
                      child: GestureDetector(
                        onTap: _openSignup,
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(color: _C.textSec, fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: _C.accentSoft,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SOCIAL SIGN-IN BUTTON
// ─────────────────────────────────────────────────────────────
class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _C.cardBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _C.textPrimary, size: 22),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: _C.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  SIGNUP SCREEN
// ═════════════════════════════════════════════════════════════
class SignupScreen extends StatefulWidget {
  final void Function(BuildContext)? onSignedUp;

  const SignupScreen({super.key, this.onSignedUp});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with TickerProviderStateMixin {
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _otp = TextEditingController();

  bool _sending = false;
  bool _verifying = false;
  bool _verified = false;
  bool _registering = false;
  bool _obscurePassword = true;

  late AnimationController _particleCtrl;
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;
  late List<_Particle> _particles;

  // Step tracking for visual progress
  int _currentStep = 0; // 0: info, 1: verify, 2: complete

  @override
  void initState() {
    super.initState();
    _particleCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();

    final rng = Random();
    _particles = List.generate(25, (_) => _Particle(
      x: rng.nextDouble(),
      y: rng.nextDouble() * 800,
      size: rng.nextDouble() * 3 + 1,
      speed: rng.nextDouble() * 0.5 + 0.3,
      opacity: rng.nextDouble() * 0.6 + 0.1,
    ));
  }

  @override
  void dispose() {
    _particleCtrl.dispose();
    _fadeCtrl.dispose();
    _fullName.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _otp.dispose();
    super.dispose();
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? _C.rose.withOpacity(0.9) : _C.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      content: Row(
        children: [
          Icon(isError ? Icons.error_outline_rounded : Icons.check_circle_rounded,
              color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(msg, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13))),
        ],
      ),
    ));
  }

  Future<void> _sendOtp() async {
    final email = _email.text.trim();
    if (email.isEmpty) {
      _showSnack('Please enter your email first', isError: true);
      return;
    }
    setState(() => _sending = true);
    try {
      final resp = await BaseApiService.post('/send-otp', body: {'email': email});
      if (resp.statusCode == 200) {
        _showSnack('OTP sent to your email ✉️');
        setState(() => _currentStep = 1);
      } else {
        _showSnack('Failed to send OTP', isError: true);
      }
    } catch (e) {
      _showSnack('Connection error', isError: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _verifyOtp() async {
    final email = _email.text.trim();
    final code = _otp.text.trim();
    if (email.isEmpty || code.isEmpty) return;
    setState(() => _verifying = true);
    try {
      final resp = await BaseApiService.post('/verify-otp', body: {'email': email, 'otp': code});
      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        if (body is Map && body['ok'] == true) {
          setState(() {
            _verified = true;
            _currentStep = 2;
          });
          HapticFeedback.mediumImpact();
          _showSnack('Email verified! 🎉');
          return;
        }
      }
      _showSnack('Invalid OTP, please try again', isError: true);
    } catch (e) {
      _showSnack('Connection error', isError: true);
    } finally {
      if (mounted) setState(() => _verifying = false);
    }
  }

  Future<void> _register() async {
    if (!_verified) {
      _showSnack('Please verify your email first', isError: true);
      return;
    }
    if (_fullName.text.trim().isEmpty || _password.text.isEmpty) {
      _showSnack('Please fill in all required fields', isError: true);
      return;
    }
    setState(() => _registering = true);
    final body = jsonEncode({
      'fullName': _fullName.text.trim(),
      'email': _email.text.trim(),
      'phone': _phone.text.trim(),
      'password': _password.text,
      'otp': _otp.text.trim(),
    });
    try {
      final resp = await BaseApiService.post('/register', body: jsonDecode(body));
      if (resp.statusCode == 200) {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['ok'] == true) {
          _showSnack('Account created! 🎬');
          // try to auto-login so we get a token and user stored
          try {
            final lid = _phone.text.trim();
            final lpwd = _password.text;
            final lresp = await BaseApiService.post('/login', body: {'identifier': lid, 'password': lpwd});
            if (lresp.statusCode == 200) {
              final lbody = jsonDecode(lresp.body);
              if (lbody is Map && lbody['ok'] == true) {
                AuthService().setFromLogin(lbody);
              }
            }
          } catch (_) {}
          if (!mounted) return;
          if (widget.onSignedUp != null) {
            widget.onSignedUp!(context);
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
          }
          return;
        }
      }
      String errorMsg = 'Registration failed';
      try {
        final parsed = jsonDecode(resp.body);
        if (parsed is Map && parsed['error'] != null) {
          errorMsg = parsed['error'].toString();
          if (parsed['details'] != null) {
            errorMsg += ': ' + parsed['details'].join(', ');
          }
        }
      } catch (_) {}
      _showSnack(errorMsg, isError: true);
    } catch (e) {
      _showSnack('Connection error', isError: true);
    } finally {
      if (mounted) setState(() => _registering = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Stack(
        children: [
          // ── Animated particle background ──
          AnimatedBuilder2(
            animation: _particleCtrl,
            builder: (context, _) => CustomPaint(
              painter: _ParticlePainter(_particles, _particleCtrl.value),
              size: Size.infinite,
            ),
          ),

          // ── Top gradient glow ──
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_C.rose.withOpacity(0.12), Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Bottom accent glow ──
          Positioned(
            bottom: -100,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_C.accent.withOpacity(0.1), Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Main content ──
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _C.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: _C.cardBorder),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, color: _C.textPrimary, size: 16),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Brand
                    ShaderMask(
                      shaderCallback: (b) => const LinearGradient(
                        colors: [_C.accentSoft, _C.rose],
                      ).createShader(b),
                      child: const Text(
                        'CineHub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Create Account',
                      style: TextStyle(
                        color: _C.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Join the film community today',
                      style: TextStyle(
                        color: _C.textSec,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Step indicator ──
                    _StepIndicator(currentStep: _currentStep),

                    const SizedBox(height: 28),

                    // Full name
                    _StyledField(
                      controller: _fullName,
                      label: 'Full Name',
                      icon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 14),

                    // Email
                    _StyledField(
                      controller: _email,
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),

                    // Send OTP button
                    if (!_verified)
                      _GradientButton(
                        text: _sending ? 'Sending...' : 'Send OTP',
                        loading: _sending,
                        onPressed: _sending ? null : _sendOtp,
                        colors: const [Color(0xFF00BFA5), Color(0xFF00897B)],
                      ),

                    if (_currentStep >= 1 && !_verified) ...[
                      const SizedBox(height: 14),
                      // OTP field
                      _StyledField(
                        controller: _otp,
                        label: 'Enter OTP',
                        icon: Icons.pin_outlined,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 14),
                      _GradientButton(
                        text: _verifying ? 'Verifying...' : 'Verify Email',
                        loading: _verifying,
                        onPressed: _verifying ? null : _verifyOtp,
                        colors: const [_C.accent, Color(0xFF9B4FE0)],
                      ),
                    ],

                    if (_verified) ...[
                      const SizedBox(height: 8),
                      // Verified badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00BFA5).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.3)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check_circle_rounded, color: Color(0xFF00BFA5), size: 18),
                            SizedBox(width: 8),
                            Text('Email verified', style: TextStyle(color: Color(0xFF00BFA5), fontWeight: FontWeight.w600, fontSize: 13)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Phone
                      _StyledField(
                        controller: _phone,
                        label: 'Phone Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 14),

                      // Password
                      _StyledField(
                        controller: _password,
                        label: 'Create Password',
                        icon: Icons.lock_outline_rounded,
                        obscure: _obscurePassword,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Icon(
                              _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: _C.textMuted,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Register button
                      _GradientButton(
                        text: 'Create Account',
                        loading: _registering,
                        onPressed: _registering ? null : _register,
                        colors: const [_C.rose, Color(0xFFE91E63)],
                      ),
                    ],

                    const SizedBox(height: 32),

                    // Already have account
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: _C.textSec, fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: _C.accentSoft,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  STEP INDICATOR
// ─────────────────────────────────────────────────────────────
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Details', 'Verify', 'Complete'];
    return Row(
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Connector line
          final stepBefore = i ~/ 2;
          return Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: stepBefore < currentStep ? _C.accent : _C.cardBorder,
              ),
            ),
          );
        }
        final step = i ~/ 2;
        final isActive = step <= currentStep;
        final isCurrent = step == currentStep;
        return Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? _C.accent : _C.surface,
                border: Border.all(
                  color: isCurrent ? _C.accent : (isActive ? _C.accent : _C.cardBorder),
                  width: isCurrent ? 2 : 1,
                ),
                boxShadow: isCurrent
                    ? [BoxShadow(color: _C.accent.withOpacity(0.4), blurRadius: 12)]
                    : [],
              ),
              child: Center(
                child: isActive && step < currentStep
                    ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                    : Text(
                        '${step + 1}',
                        style: TextStyle(
                          color: isActive ? Colors.white : _C.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              steps[step],
              style: TextStyle(
                color: isActive ? _C.textPrimary : _C.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      }),
    );
  }
}
