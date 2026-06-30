import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../datasources/auth_datasource.dart';
import '../models/auth_models.dart';

/// Auth repository — orchestrates data source + token storage.
///
/// This is the layer that UI/state management interacts with.
/// It coordinates between the API data source and local secure storage.
class AuthRepository {
  final AuthDataSource _dataSource;
  final ApiClient _apiClient;

  AuthRepository(this._dataSource, this._apiClient);

  /// Register → save tokens → return user.
  Future<Either<Failure, UserDto>> register(RegisterRequest request) async {
    final result = await _dataSource.register(request);
    return result.fold(
      (failure) => Left(failure),
      (authResult) async {
        await _apiClient.saveTokens(
          accessToken: authResult.tokens.accessToken,
          refreshToken: authResult.tokens.refreshToken,
        );
        return Right(authResult.user);
      },
    );
  }

  /// Login → save tokens → return user.
  Future<Either<Failure, UserDto>> login(LoginRequest request) async {
    final result = await _dataSource.login(request);
    return result.fold(
      (failure) => Left(failure),
      (authResult) async {
        await _apiClient.saveTokens(
          accessToken: authResult.tokens.accessToken,
          refreshToken: authResult.tokens.refreshToken,
        );
        return Right(authResult.user);
      },
    );
  }

  /// Get the current authenticated user.
  Future<Either<Failure, UserDto>> getMe() => _dataSource.getMe();

  /// Logout → clear tokens.
  Future<Either<Failure, void>> logout() async {
    final result = await _dataSource.logout();
    await _apiClient.clearTokens();
    return result;
  }

  /// Check if user has stored tokens (persisted login).
  Future<bool> hasStoredSession() async {
    final token = await _apiClient.getAccessToken();
    return token != null;
  }

  Future<Either<Failure, String>> forgotPassword(String email) =>
      _dataSource.forgotPassword(email);

  Future<Either<Failure, void>> resetPassword(String token, String password) =>
      _dataSource.resetPassword(token, password);

  Future<Either<Failure, void>> changePassword(
    ChangePasswordRequest request,
  ) =>
      _dataSource.changePassword(request);
}

// ── Riverpod Providers ──────────────────────────

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSource(ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(authDataSourceProvider),
    ref.watch(apiClientProvider),
  );
});
