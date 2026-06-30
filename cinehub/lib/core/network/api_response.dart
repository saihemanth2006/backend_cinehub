import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Standardized API response envelope matching the Node.js backend shape.
///
/// Every backend response follows:
/// ```json
/// {
///   "status": "success" | "error",
///   "statusCode": 200,
///   "message": "...",
///   "data": { ... },
///   "meta": { "pagination": { ... } }
/// }
/// ```
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required String status,
    required int statusCode,
    required String message,
    T? data,
    ApiMeta? meta,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

@freezed
class ApiMeta with _$ApiMeta {
  const factory ApiMeta({
    PaginationMeta? pagination,
  }) = _ApiMeta;

  factory ApiMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaFromJson(json);
}

@freezed
class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    required int totalDocs,
    required int totalPages,
    required int page,
    required int limit,
    required bool hasNextPage,
    required bool hasPrevPage,
    int? nextPage,
    int? prevPage,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}

/// API error response shape for structured error handling.
@freezed
class ApiErrorResponse with _$ApiErrorResponse {
  const factory ApiErrorResponse({
    required String status,
    required int statusCode,
    required String message,
    String? code,
    List<FieldError>? errors,
  }) = _ApiErrorResponse;

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);
}

@freezed
class FieldError with _$FieldError {
  const factory FieldError({
    required String field,
    required String message,
    String? type,
  }) = _FieldError;

  factory FieldError.fromJson(Map<String, dynamic> json) =>
      _$FieldErrorFromJson(json);
}
