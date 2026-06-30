import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/auth_models.dart';
import '../data/repositories/auth_repository.dart';

part 'auth_provider.freezed.dart';

// ── Auth State ──────────────────────────────────

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserDto user) = _Authenticated;
  const factory AuthState.unauthenticated([String? message]) = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

// ── Auth Notifier ───────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initial());

  /// Check if user has an existing session on app start.
  Future<void> checkSession() async {
    final hasSession = await _repository.hasStoredSession();
    if (!hasSession) {
      state = const AuthState.unauthenticated();
      return;
    }

    // Try to validate the stored token by fetching user
    state = const AuthState.loading();
    final result = await _repository.getMe();
    state = result.fold(
      (failure) => const AuthState.unauthenticated(),
      (user) => AuthState.authenticated(user),
    );
  }

  /// Login with email and password.
  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();
    final result = await _repository.login(
      LoginRequest(email: email, password: password),
    );
    state = result.fold(
      (failure) => AuthState.error(failure.message),
      (user) => AuthState.authenticated(user),
    );
  }

  /// Register a new account.
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? role,
  }) async {
    state = const AuthState.loading();
    final result = await _repository.register(
      RegisterRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        role: role,
      ),
    );
    state = result.fold(
      (failure) => AuthState.error(failure.message),
      (user) => AuthState.authenticated(user),
    );
  }

  /// Logout.
  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.unauthenticated('Logged out');
  }

  /// Forgot password.
  Future<String?> forgotPassword(String email) async {
    final result = await _repository.forgotPassword(email);
    return result.fold(
      (failure) => failure.message,
      (message) => null, // null = success
    );
  }
}

// ── Provider ────────────────────────────────────

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

/// Convenience provider for checking if user is authenticated.
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState is _Authenticated;
});

/// Convenience provider for getting current user (null if not authenticated).
final currentUserProvider = Provider<UserDto?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.mapOrNull(
    authenticated: (state) => state.user,
  );
});
