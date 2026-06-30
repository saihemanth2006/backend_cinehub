import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../auth/data/models/auth_models.dart';

part 'project_models.freezed.dart';
part 'project_models.g.dart';

// ── Project DTOs ────────────────────────────────

@freezed
class ProjectDto with _$ProjectDto {
  const factory ProjectDto({
    required String id,
    required String title,
    required String type,
    String? slug,
    String? tagline,
    String? synopsis,
    String? description,
    String? status,
    List<String>? genres,
    List<String>? tags,
    String? language,
    String? poster,
    String? coverImage,
    String? visibility,
    ProjectBudgetDto? budget,
    ProjectDurationDto? duration,
    UserDto? owner,
    String? team,
    int? viewCount,
    int? likeCount,
    bool? allowApplications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProjectDto;

  factory ProjectDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectDtoFromJson(json);
}

@freezed
class ProjectBudgetDto with _$ProjectBudgetDto {
  const factory ProjectBudgetDto({
    double? estimated,
    @Default('USD') String currency,
  }) = _ProjectBudgetDto;

  factory ProjectBudgetDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectBudgetDtoFromJson(json);
}

@freezed
class ProjectDurationDto with _$ProjectDurationDto {
  const factory ProjectDurationDto({
    int? estimated,
  }) = _ProjectDurationDto;

  factory ProjectDurationDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectDurationDtoFromJson(json);
}

@freezed
class CreateProjectRequest with _$CreateProjectRequest {
  const factory CreateProjectRequest({
    required String title,
    required String type,
    String? tagline,
    String? synopsis,
    String? description,
    List<String>? genres,
    String? language,
    String? visibility,
    ProjectBudgetDto? budget,
    ProjectDurationDto? duration,
  }) = _CreateProjectRequest;

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestFromJson(json);
}

@freezed
class UpdateProjectRequest with _$UpdateProjectRequest {
  const factory UpdateProjectRequest({
    String? title,
    String? tagline,
    String? synopsis,
    String? description,
    String? status,
    List<String>? genres,
    String? visibility,
    bool? allowApplications,
  }) = _UpdateProjectRequest;

  factory UpdateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectRequestFromJson(json);
}
