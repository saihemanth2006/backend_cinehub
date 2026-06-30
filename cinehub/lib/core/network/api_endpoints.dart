/// API endpoint constants — aligned with Node.js backend v1 routes.
///
/// All paths are relative to the base URL configured in [AppConfig].
/// Pattern: static methods for parameterized endpoints.
class ApiEndpoints {
  ApiEndpoints._();

  // ── Auth ───────────────────────────────────────────────────
  static const String register = '/register';
  static const String login = '/login';
  static const String sendOtp = '/send-otp';
  static const String verifyOtp = '/verify-otp';

  static const String refreshTokens = '/auth/refresh-tokens';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String me = '/me';

  // ── Users ──────────────────────────────────────────────────
  static const String users = '/users';
  static const String updateProfile = '/users/profile';
  static String userById(String id) => '/users/$id';
  static String followUser(String id) => '/users/$id/follow';
  static String userFollowers(String id) => '/users/$id/followers';
  static String userFollowing(String id) => '/users/$id/following';

  // ── Projects ───────────────────────────────────────────────
  static const String projects = '/projects';
  static const String myProjects = '/projects/me';
  static String projectById(String id) => '/projects/$id';
  static String projectBySlug(String slug) => '/projects/slug/$slug';

  // ── Scripts ────────────────────────────────────────────────
  static const String scripts = '/scripts';
  static const String myScripts = '/scripts/me';
  static String scriptById(String id) => '/scripts/$id';
  static String projectScripts(String projectId) =>
      '/scripts/project/$projectId';

  // ── Teams ──────────────────────────────────────────────────
  static const String myTeams = '/teams/me';
  static String teamByProject(String projectId) =>
      '/teams/project/$projectId';
  static String inviteMember(String teamId) => '/teams/$teamId/invite';
  static String respondToInvite(String teamId) => '/teams/$teamId/respond';
  static String removeMember(String teamId, String userId) =>
      '/teams/$teamId/members/$userId';

  // ── Portfolio ──────────────────────────────────────────────
  static const String portfolios = '/portfolios';
  static const String myPortfolio = '/portfolios/me';
  static const String featuredPortfolios = '/portfolios/featured';
  static const String trendingPortfolios = '/portfolios/trending';
  static String portfolioById(String id) => '/portfolios/$id';
  static String portfolioByUser(String userId) => '/portfolios/user/$userId';
  static String likePortfolio(String id) => '/portfolios/$id/like';
  static String portfolioComments(String id) => '/portfolios/$id/comments';

  // ── Discovery ──────────────────────────────────────────────
  static const String discoverCreators = '/discovery/creators';
  static const String topCreators = '/discovery/creators/top';
  static const String suggestions = '/discovery/suggestions';
  static const String discoverProjects = '/discovery/projects';
  static const String trending = '/discovery/trending';

  // ── Notifications ──────────────────────────────────────────
  static const String notifications = '/notifications';
  static const String unreadCount = '/notifications/unread-count';
  static const String markAllRead = '/notifications/read-all';
  static String markRead(String id) => '/notifications/$id/read';
  static String deleteNotification(String id) => '/notifications/$id';

  // ── Media ──────────────────────────────────────────────────
  static const String mediaUpload = '/media/upload';
  static const String myMedia = '/media/me';
  static const String storageUsage = '/media/storage-usage';
  static String mediaById(String id) => '/media/$id';
  static String mediaByProject(String projectId) =>
      '/media/project/$projectId';

  // ── AI ─────────────────────────────────────────────────────

  /// Centralized AI generation endpoint
  static const String aiGenerate = '/ai/generate';
  static const String aiCapabilities = '/ai/capabilities';
  static const String aiModules = '/ai/modules';
  static String aiModuleTasks(String module) => '/ai/modules/$module/tasks';

  /// Legacy endpoints (backward compatible)
  static const String generateScript = '/ai/generate-script';
  static const String enhanceStory = '/ai/enhance-story';
  static const String analyzeGenre = '/ai/analyze-genre';
  static const String estimateBudget = '/ai/estimate-budget';
  static const String recommendTalent = '/ai/recommend-talent';
  static const String creativeAssist = '/ai/creative-assist';
  static const String projectInsights = '/ai/project-insights';
  static const String aiRecommendations = '/ai/recommendations';
  static const String aiProviders = '/ai/providers';
  static const String aiHealth = '/ai/health';
  static const String aiDashboard = '/ai/dashboard';
  static const String aiUsage = '/ai/usage';
  static String aiJobStatus(String jobId) => '/ai/jobs/$jobId';

  // ── Health ─────────────────────────────────────────────────
  static const String health = '/health';
}
