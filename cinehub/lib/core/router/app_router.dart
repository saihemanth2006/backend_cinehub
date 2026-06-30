import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/discover/presentation/screens/discover_screen.dart';
import '../../features/opportunities/presentation/screens/jobs_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/ai/presentation/screens/ai_hub_screen.dart';
import '../../features/ai/presentation/screens/script_generator_screen.dart';
import '../../features/ai/presentation/screens/cost_predictor_screen.dart';
import '../../features/ai/presentation/screens/trailer_concept_screen.dart';
import '../../features/portfolio/presentation/screens/portfolio_screen.dart';
import '../../features/projects/presentation/screens/project_detail_screen.dart';
import '../../features/discover/presentation/screens/creator_profile_screen.dart';
import '../../features/opportunities/presentation/screens/job_detail_screen.dart';
import '../../features/messaging/presentation/screens/conversations_screen.dart';
import '../../features/messaging/presentation/screens/chat_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../shared/widgets/layout/app_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

/// CineHub router configuration.
///
/// Uses ShellRoute to persist bottom navigation across tab switches.
/// Starts with a cinematic splash screen on fresh launch.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash,
  debugLogDiagnostics: true,
  routes: [
    // ── Splash (full-screen, no shell) ─────────────────────────
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    // ── Auth (full-screen, no shell) ─────────────────────────
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),

    // ── Main App Shell (bottom nav) ──────────────────────────
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: Routes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: Routes.discover,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DiscoverScreen(),
          ),
        ),
        GoRoute(
          path: Routes.aiHub,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AIHubScreen(),
          ),
        ),
        GoRoute(
          path: Routes.opportunities,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: JobsScreen(),
          ),
        ),
        GoRoute(
          path: Routes.profile,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),

    // ── Detail screens (pushed on top of shell) ──────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.projectDetail,
      builder: (context, state) => ProjectDetailScreen(
        projectId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.creatorProfile,
      builder: (context, state) => CreatorProfileScreen(
        creatorId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.jobDetail,
      builder: (context, state) => JobDetailScreen(
        jobId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.portfolio,
      builder: (context, state) => const PortfolioScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.editProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.conversations,
      builder: (context, state) => const ConversationsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.chat,
      builder: (context, state) => ChatScreen(
        conversationId: state.pathParameters['id']!,
      ),
    ),

    // ── AI Sub-screens ───────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.scriptGenerator,
      builder: (context, state) => const ScriptGeneratorScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.costPredictor,
      builder: (context, state) => const CostPredictorScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.trailerConcept,
      builder: (context, state) => const TrailerConceptScreen(),
    ),

    // ── Settings ─────────────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
