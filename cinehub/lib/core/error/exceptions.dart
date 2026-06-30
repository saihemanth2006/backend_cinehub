// Data-layer exception types.
//
// These are thrown in datasources and caught in repository implementations,
// then mapped to Failure types via BaseApiService.safeRequest().

/// Server returned an error HTTP response (4xx/5xx).
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;

  const ServerException(this.message, {this.statusCode, this.code});

  @override
  String toString() => 'ServerException($statusCode, $code): $message';
}

/// Network-level failure — no connectivity, DNS, timeout.
class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'No internet connection']);
}

/// Local cache read/write error.
class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache read/write failed']);
}

/// Authentication error — expired token, invalid credentials.
class AuthException implements Exception {
  final String message;
  const AuthException([this.message = 'Not authenticated']);
}

/// AI service error — provider failure, rate limit.
class AIException implements Exception {
  final String message;
  const AIException(this.message);
}

/// Validation error with field-level details from backend.
class ValidationException implements Exception {
  final String message;
  final Map<String, String> fieldErrors;

  const ValidationException(this.message, {this.fieldErrors = const {}});

  @override
  String toString() => 'ValidationException: $message ($fieldErrors)';
}
