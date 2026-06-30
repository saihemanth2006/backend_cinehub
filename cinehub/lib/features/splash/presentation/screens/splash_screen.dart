import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';

/// Cinematic splash screen with animated CineHub branding.
///
/// Shows app logo and brand animation before navigating to the home screen.
/// Designed for a premium first impression on Android devices.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Immersive splash
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (!mounted) return;
    // Restore system UI before navigating
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Ambient background glow ───────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppGradients.heroGlow,
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 1200.ms, curve: Curves.easeOut)
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2800.ms),

          // ── Center content ────────────────────────────────────
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Brand icon
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                    borderRadius: BorderRadius.circular(AppRadii.xxl),
                    boxShadow: [AppShadows.primaryGlow(opacity: 0.4)],
                  ),
                  child: const Icon(
                    Icons.movie_creation_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1.0, 1.0),
                      duration: 800.ms,
                      curve: Curves.elasticOut,
                    ),

                const SizedBox(height: AppSpacing.xxl),

                // App name
                Text(
                  'CineHub',
                  style: AppTypography.displayMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5,
                  ),
                )
                    .animate(delay: 400.ms)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),

                const SizedBox(height: AppSpacing.sm),

                // Tagline
                Text(
                  'AI-Powered Filmmaking',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
                    .animate(delay: 700.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.3, end: 0, duration: 500.ms, curve: Curves.easeOut),
              ],
            ),
          ),

          // ── Bottom indicator ──────────────────────────────────
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom + 48,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.primary.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          )
              .animate(delay: 1200.ms)
              .fadeIn(duration: 400.ms),
        ],
      ),
    );
  }
}
