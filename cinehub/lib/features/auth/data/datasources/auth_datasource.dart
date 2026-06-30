import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/base_api_service.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_models.dart';

/// Auth data source — handles all authentication HTTP requests.
///
/// Extends [BaseApiService] to inherit error mapping and typed HTTP methods.
/// Every method returns `Either<Failure, T>` for exhaustive error handling.
class AuthDataSource extends BaseApiService {
  AuthDataSource(super.client);

  /// Register a new user account.
  Future<Either<Failure, AuthResult>> register(RegisterRequest request) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.register,
        data: request.toJson(),
      );
      return extractData(response, AuthResult.fromJson);
    });
  }

  /// Login with email and password.
  Future<Either<Failure, AuthResult>> login(LoginRequest request) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.login,
        data: request.toJson(),
      );
      return extractData(response, AuthResult.fromJson);
    });
  }

  /// Refresh access token using stored refresh token.
  Future<Either<Failure, AuthTokens>> refreshTokens(String refreshToken) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.refreshTokens,
        data: {'refreshToken': refreshToken},
      );
      return extractData(response, AuthTokens.fromJson);
    });
  }

  /// Get current authenticated user.
  Future<Either<Failure, UserDto>> getMe() {
    return safeRequest(() async {
      final response = await get(ApiEndpoints.me);
      return extractData(response, UserDto.fromJson);
    });
  }

  /// Logout (invalidate refresh token on server).
  Future<Either<Failure, void>> logout() {
    return safeRequest(() async {
      await post(ApiEndpoints.logout);
    });
  }

  /// Request password reset email.
  Future<Either<Failure, String>> forgotPassword(String email) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
      return extractMessage(response);
    });
  }

  /// Reset password with token.
  Future<Either<Failure, void>> resetPassword(String token, String password) {
    return safeRequest(() async {
      await post(
        ApiEndpoints.resetPassword,
        data: {'token': token, 'password': password},
      );
    });
  }

  /// Change password (authenticated).
  Future<Either<Failure, void>> changePassword(ChangePasswordRequest request) {
    return safeRequest(() async {
      await post(
        ApiEndpoints.changePassword,
        data: request.toJson(),
      );
    });
  }


  /// Send OTP to email address.
  Future<Either<Failure, String>> sendOtp(String email) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.sendOtp,
        data: {'email': email},
      );
      return extractMessage(response);
    });
  }

  /// Verify OTP for email.
  Future<Either<Failure, AuthResult>> verifyOtp(String email, String otp) {
    return safeRequest(() async {
      final response = await post(
        ApiEndpoints.verifyOtp,
        data: {'email': email, 'otp': otp},
      );
      return extractData(response, AuthResult.fromJson);
    });
  }
}
