import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

// ── DTOs (Data Transfer Objects) ────────────────────────────
// These match the backend's request/response JSON shapes exactly.

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? role,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
    String? expiresIn,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required UserDto user,
    required AuthTokens tokens,
  }) = _AuthResult;

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
}

@freezed
class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

// ── Domain Models ───────────────────────────────────────────

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? displayName,
    String? slug,
    String? role,
    String? bio,
    String? headline,
    String? avatar,
    String? coverImage,
    List<SkillDto>? skills,
    LocationDto? location,
    SocialLinksDto? socialLinks,
    int? followerCount,
    int? followingCount,
    int? projectCount,
    bool? isEmailVerified,
    DateTime? createdAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

@freezed
class SkillDto with _$SkillDto {
  const factory SkillDto({
    required String name,
    String? category,
    int? proficiency,
  }) = _SkillDto;

  factory SkillDto.fromJson(Map<String, dynamic> json) =>
      _$SkillDtoFromJson(json);
}

@freezed
class LocationDto with _$LocationDto {
  const factory LocationDto({
    String? city,
    String? state,
    String? country,
  }) = _LocationDto;

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}

@freezed
class SocialLinksDto with _$SocialLinksDto {
  const factory SocialLinksDto({
    String? website,
    String? imdb,
    String? linkedin,
    String? instagram,
    String? youtube,
    String? vimeo,
    String? twitter,
  }) = _SocialLinksDto;

  factory SocialLinksDto.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkedsDtoFromJson(json);
}

@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    String? firstName,
    String? lastName,
    String? bio,
    String? headline,
    LocationDto? location,
    List<SkillDto>? skills,
    SocialLinksDto? socialLinks,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}
