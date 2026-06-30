import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../network/api_client.dart';
import '../network/socket_service.dart';

/// ── Core DI Providers ──────────────────────────────────────
///
/// Single source of truth for app-wide dependencies.
/// All feature providers depend on these.

/// Application configuration provider.
final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

/// Singleton API client — shared across all data sources.
final apiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.watch(appConfigProvider);
  return ApiClient(config: config);
});

/// Socket service provider — exposes a singleton SocketService wired to AppConfig.
final socketServiceProvider = Provider<SocketService>((ref) {
  final config = ref.watch(appConfigProvider);
  final api = ref.watch(apiClientProvider);
  return SocketService(config: config, apiClient: api);
});
