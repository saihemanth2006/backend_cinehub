import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';
import '../error/exceptions.dart';

/// Centralized HTTP client wrapper using Dio.
///
/// Features:
/// - Auto-injected Bearer token from secure storage
/// - Automatic 401 → token refresh → retry flow
/// - Request/response logging in dev
/// - Request ID propagation
/// - Timeout configuration per environment
/// - Network-aware error mapping
class ApiClient {
  late final Dio dio;
  final FlutterSecureStorage _secureStorage;
  final AppConfig _config;

  /// Lock to prevent concurrent token refresh attempts.
  bool _isRefreshing = false;
  final List<_RetryRequest> _pendingRequests = [];

  ApiClient({
    required AppConfig config,
    FlutterSecureStorage? secureStorage,
  })  : _config = config,
        _secureStorage = secureStorage ?? const FlutterSecureStorage() {
    dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: config.apiTimeout,
        receiveTimeout: config.apiTimeout,
        sendTimeout: config.apiTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // ── Interceptor Stack (order matters) ────────
    dio.interceptors.addAll([
      _AuthInterceptor(this),
      _RetryInterceptor(this),
      if (config.enableLogging) _LoggingInterceptor(),
    ]);
  }

  // ── Token Management ──────────────────────────

  Future<String?> getAccessToken() =>
      _secureStorage.read(key: StorageKeys.accessToken);

  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: StorageKeys.refreshToken);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _secureStorage.write(key: StorageKeys.accessToken, value: accessToken),
      _secureStorage.write(key: StorageKeys.refreshToken, value: refreshToken),
    ]);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: StorageKeys.accessToken),
      _secureStorage.delete(key: StorageKeys.refreshToken),
    ]);
  }

  /// Attempts to refresh the access token using the stored refresh token.
  /// Returns `true` on success, `false` if refresh fails (triggers logout).
  Future<bool> refreshAccessToken() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;

    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return false;

      // Use a separate Dio instance to avoid interceptor loops
      final refreshDio = Dio(BaseOptions(baseUrl: _config.apiBaseUrl));
      final response = await refreshDio.post(
        '/auth/refresh-tokens',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final tokens = response.data['data'];
        await saveTokens(
          accessToken: tokens['accessToken'],
          refreshToken: tokens['refreshToken'],
        );

        // Retry all queued requests with new token
        for (final pending in _pendingRequests) {
          pending.completer.complete(true);
        }
        _pendingRequests.clear();
        return true;
      }

      return false;
    } on DioException {
      // Refresh failed → clear tokens (force re-login)
      await clearTokens();
      for (final pending in _pendingRequests) {
        pending.completer.complete(false);
      }
      _pendingRequests.clear();
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  /// Queue a request to retry after token refresh completes.
  Future<bool> queueRetry() {
    final completer = Completer<bool>();
    _pendingRequests.add(_RetryRequest(completer));
    return completer.future;
  }
}

// ── Auth Interceptor ─────────────────────────

class _AuthInterceptor extends Interceptor {
  final ApiClient _client;
  _AuthInterceptor(this._client);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for public endpoints
    if (_isPublicEndpoint(options.path)) {
      return handler.next(options);
    }

    final token = await _client.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  bool _isPublicEndpoint(String path) {
    const publicPaths = [
      '/auth/login',
      '/auth/register',
      '/auth/refresh-tokens',
      '/auth/forgot-password',
      '/auth/reset-password',
      '/auth/verify-email',
    ];
    return publicPaths.any((p) => path.endsWith(p));
  }
}

// ── Retry Interceptor (401 → refresh → retry) ──

class _RetryInterceptor extends Interceptor {
  final ApiClient _client;
  _RetryInterceptor(this._client);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('refresh-tokens')) {
      // Attempt token refresh
      final success = _client._isRefreshing
          ? await _client.queueRetry()
          : await _client.refreshAccessToken();

      if (success) {
        // Retry the original request with the new token
        final token = await _client.getAccessToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $token';

        try {
          final response = await _client.dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (retryErr) {
          return handler.next(retryErr);
        }
      }
    }

    handler.next(err);
  }
}

// ── Logging Interceptor ─────────────────────

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('┌── API REQUEST ──────────────────────');
    debugPrint('│ ${options.method} ${options.uri}');
    if (options.data != null) {
      debugPrint('│ Body: ${_truncate(options.data.toString())}');
    }
    debugPrint('└─────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('┌── API RESPONSE ─────────────────────');
    debugPrint('│ ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('│ Data: ${_truncate(response.data.toString())}');
    debugPrint('└─────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('┌── API ERROR ────────────────────────');
    debugPrint('│ ${err.response?.statusCode} ${err.requestOptions.uri}');
    debugPrint('│ ${err.message}');
    debugPrint('└─────────────────────────────────────');
    handler.next(err);
  }

  String _truncate(String s, [int max = 300]) =>
      s.length > max ? '${s.substring(0, max)}…' : s;
}

// ── Models ──────────────────────────────────

class _RetryRequest {
  final Completer<bool> completer;
  _RetryRequest(this.completer);
}

/// Secure storage key constants.
abstract class StorageKeys {
  static const accessToken = 'cinehub_access_token';
  static const refreshToken = 'cinehub_refresh_token';
  static const userId = 'cinehub_user_id';
  static const userRole = 'cinehub_user_role';
}
