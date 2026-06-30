// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PortfolioItemDto _$PortfolioItemDtoFromJson(Map<String, dynamic> json) =>
    _PortfolioItemDto(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      description: json['description'] as String?,
      media: json['media'] == null
          ? null
          : PortfolioMediaDto.fromJson(json['media'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      credits: (json['credits'] as List<dynamic>?)
          ?.map((e) => PortfolioCreditDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      viewCount: (json['viewCount'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      isFeatured: json['isFeatured'] as bool?,
      visibility: json['visibility'] as String?,
      owner: json['owner'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PortfolioItemDtoToJson(_PortfolioItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'description': instance.description,
      'media': instance.media,
      'tags': instance.tags,
      'credits': instance.credits,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'isFeatured': instance.isFeatured,
      'visibility': instance.visibility,
      'owner': instance.owner,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_PortfolioMediaDto _$PortfolioMediaDtoFromJson(Map<String, dynamic> json) =>
    _PortfolioMediaDto(
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String?,
      type: json['type'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      resolution: json['resolution'] as String?,
    );

Map<String, dynamic> _$PortfolioMediaDtoToJson(_PortfolioMediaDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'type': instance.type,
      'duration': instance.duration,
      'resolution': instance.resolution,
    };

_PortfolioCreditDto _$PortfolioCreditDtoFromJson(Map<String, dynamic> json) =>
    _PortfolioCreditDto(
      name: json['name'] as String?,
      role: json['role'] as String?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$PortfolioCreditDtoToJson(_PortfolioCreditDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'user': instance.user,
    };

_CreatePortfolioRequest _$CreatePortfolioRequestFromJson(
  Map<String, dynamic> json,
) => _CreatePortfolioRequest(
  title: json['title'] as String,
  type: json['type'] as String,
  description: json['description'] as String?,
  media: PortfolioMediaDto.fromJson(json['media'] as Map<String, dynamic>),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  visibility: json['visibility'] as String?,
);

Map<String, dynamic> _$CreatePortfolioRequestToJson(
  _CreatePortfolioRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'type': instance.type,
  'description': instance.description,
  'media': instance.media,
  'tags': instance.tags,
  'visibility': instance.visibility,
};
