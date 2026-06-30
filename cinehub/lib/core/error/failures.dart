import 'package:equatable/equatable.dart';

/// Base failure class using sealed types for exhaustive matching.
sealed class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server returned an error response.
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

/// No internet connection.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

/// Local cache read/write error.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}

/// Authentication error (expired token, invalid credentials).
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

/// AI service error (Gemini API failure, rate limit, etc).
class AIFailure extends Failure {
  const AIFailure(super.message);
}

/// Validation error on input data.
class ValidationFailure extends Failure {
  final Map<String, String> fieldErrors;

  const ValidationFailure(
    super.message, {
    this.fieldErrors = const {},
  });

  @override
  List<Object?> get props => [message, fieldErrors];
}

/// Unknown / unexpected error.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred']);
}
