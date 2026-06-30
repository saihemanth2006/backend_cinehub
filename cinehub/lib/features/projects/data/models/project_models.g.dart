// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectDto _$ProjectDtoFromJson(Map<String, dynamic> json) => _ProjectDto(
  id: json['id'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
  slug: json['slug'] as String?,
  tagline: json['tagline'] as String?,
  synopsis: json['synopsis'] as String?,
  description: json['description'] as String?,
  status: json['status'] as String?,
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  language: json['language'] as String?,
  poster: json['poster'] as String?,
  coverImage: json['coverImage'] as String?,
  visibility: json['visibility'] as String?,
  budget: json['budget'] == null
      ? null
      : ProjectBudgetDto.fromJson(json['budget'] as Map<String, dynamic>),
  duration: json['duration'] == null
      ? null
      : ProjectDurationDto.fromJson(json['duration'] as Map<String, dynamic>),
  owner: json['owner'] == null
      ? null
      : UserDto.fromJson(json['owner'] as Map<String, dynamic>),
  team: json['team'] as String?,
  viewCount: (json['viewCount'] as num?)?.toInt(),
  likeCount: (json['likeCount'] as num?)?.toInt(),
  allowApplications: json['allowApplications'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProjectDtoToJson(_ProjectDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'slug': instance.slug,
      'tagline': instance.tagline,
      'synopsis': instance.synopsis,
      'description': instance.description,
      'status': instance.status,
      'genres': instance.genres,
      'tags': instance.tags,
      'language': instance.language,
      'poster': instance.poster,
      'coverImage': instance.coverImage,
      'visibility': instance.visibility,
      'budget': instance.budget,
      'duration': instance.duration,
      'owner': instance.owner,
      'team': instance.team,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'allowApplications': instance.allowApplications,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_ProjectBudgetDto _$ProjectBudgetDtoFromJson(Map<String, dynamic> json) =>
    _ProjectBudgetDto(
      estimated: (json['estimated'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$ProjectBudgetDtoToJson(_ProjectBudgetDto instance) =>
    <String, dynamic>{
      'estimated': instance.estimated,
      'currency': instance.currency,
    };

_ProjectDurationDto _$ProjectDurationDtoFromJson(Map<String, dynamic> json) =>
    _ProjectDurationDto(estimated: (json['estimated'] as num?)?.toInt());

Map<String, dynamic> _$ProjectDurationDtoToJson(_ProjectDurationDto instance) =>
    <String, dynamic>{'estimated': instance.estimated};

_CreateProjectRequest _$CreateProjectRequestFromJson(
  Map<String, dynamic> json,
) => _CreateProjectRequest(
  title: json['title'] as String,
  type: json['type'] as String,
  tagline: json['tagline'] as String?,
  synopsis: json['synopsis'] as String?,
  description: json['description'] as String?,
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  language: json['language'] as String?,
  visibility: json['visibility'] as String?,
  budget: json['budget'] == null
      ? null
      : ProjectBudgetDto.fromJson(json['budget'] as Map<String, dynamic>),
  duration: json['duration'] == null
      ? null
      : ProjectDurationDto.fromJson(json['duration'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateProjectRequestToJson(
  _CreateProjectRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'type': instance.type,
  'tagline': instance.tagline,
  'synopsis': instance.synopsis,
  'description': instance.description,
  'genres': instance.genres,
  'language': instance.language,
  'visibility': instance.visibility,
  'budget': instance.budget,
  'duration': instance.duration,
};

_UpdateProjectRequest _$UpdateProjectRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProjectRequest(
  title: json['title'] as String?,
  tagline: json['tagline'] as String?,
  synopsis: json['synopsis'] as String?,
  description: json['description'] as String?,
  status: json['status'] as String?,
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  visibility: json['visibility'] as String?,
  allowApplications: json['allowApplications'] as bool?,
);

Map<String, dynamic> _$UpdateProjectRequestToJson(
  _UpdateProjectRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'tagline': instance.tagline,
  'synopsis': instance.synopsis,
  'description': instance.description,
  'status': instance.status,
  'genres': instance.genres,
  'visibility': instance.visibility,
  'allowApplications': instance.allowApplications,
};
