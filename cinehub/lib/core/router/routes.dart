/// Route path constants to prevent typo bugs.
class Routes {
  Routes._();

  // ── Root ───────────────────────────────────────────────────
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // ── Auth ───────────────────────────────────────────────────
  static const String login = '/login';
  static const String register = '/register';

  // ── Main shell tabs ────────────────────────────────────────
  static const String home = '/home';
  static const String discover = '/discover';
  static const String aiHub = '/ai';
  static const String opportunities = '/opportunities';
  static const String profile = '/profile';

  // ── Nested / Detail ────────────────────────────────────────
  static const String projectDetail = '/project/:id';
  static const String creatorProfile = '/creator/:id';
  static const String jobDetail = '/job/:id';
  static const String portfolio = '/portfolio';
  static const String editProfile = '/profile/edit';
  static const String chat = '/chat/:id';
  static const String conversations = '/conversations';

  // ── AI Sub-screens ─────────────────────────────────────────
  static const String scriptGenerator = '/ai/script';
  static const String costPredictor = '/ai/cost';
  static const String trailerConcept = '/ai/trailer';

  // ── Settings ───────────────────────────────────────────────
  static const String settings = '/settings';

  // ── Helpers ────────────────────────────────────────────────
  static String projectById(String id) => '/project/$id';
  static String creatorById(String id) => '/creator/$id';
  static String jobById(String id) => '/job/$id';
  static String chatById(String id) => '/chat/$id';
}
