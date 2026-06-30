// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
    };

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresIn: json['expiresIn'] as String?,
);

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
  tokens: AuthTokens.fromJson(json['tokens'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{'user': instance.user, 'tokens': instance.tokens};

_ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => _ChangePasswordRequest(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  _ChangePasswordRequest instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
};

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  displayName: json['displayName'] as String?,
  slug: json['slug'] as String?,
  role: json['role'] as String?,
  bio: json['bio'] as String?,
  headline: json['headline'] as String?,
  avatar: json['avatar'] as String?,
  coverImage: json['coverImage'] as String?,
  skills: (json['skills'] as List<dynamic>?)
      ?.map((e) => SkillDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  location: json['location'] == null
      ? null
      : LocationDto.fromJson(json['location'] as Map<String, dynamic>),
  socialLinks: json['socialLinks'] == null
      ? null
      : SocialLinksDto.fromJson(json['socialLinks'] as Map<String, dynamic>),
  followerCount: (json['followerCount'] as num?)?.toInt(),
  followingCount: (json['followingCount'] as num?)?.toInt(),
  projectCount: (json['projectCount'] as num?)?.toInt(),
  isEmailVerified: json['isEmailVerified'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'displayName': instance.displayName,
  'slug': instance.slug,
  'role': instance.role,
  'bio': instance.bio,
  'headline': instance.headline,
  'avatar': instance.avatar,
  'coverImage': instance.coverImage,
  'skills': instance.skills,
  'location': instance.location,
  'socialLinks': instance.socialLinks,
  'followerCount': instance.followerCount,
  'followingCount': instance.followingCount,
  'projectCount': instance.projectCount,
  'isEmailVerified': instance.isEmailVerified,
  'createdAt': instance.createdAt?.toIso8601String(),
};

_SkillDto _$SkillDtoFromJson(Map<String, dynamic> json) => _SkillDto(
  name: json['name'] as String,
  category: json['category'] as String?,
  proficiency: (json['proficiency'] as num?)?.toInt(),
);

Map<String, dynamic> _$SkillDtoToJson(_SkillDto instance) => <String, dynamic>{
  'name': instance.name,
  'category': instance.category,
  'proficiency': instance.proficiency,
};

_LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => _LocationDto(
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
);

Map<String, dynamic> _$LocationDtoToJson(_LocationDto instance) =>
    <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };

_SocialLinksDto _$SocialLinksDtoFromJson(Map<String, dynamic> json) =>
    _SocialLinksDto(
      website: json['website'] as String?,
      imdb: json['imdb'] as String?,
      linkedin: json['linkedin'] as String?,
      instagram: json['instagram'] as String?,
      youtube: json['youtube'] as String?,
      vimeo: json['vimeo'] as String?,
      twitter: json['twitter'] as String?,
    );

Map<String, dynamic> _$SocialLinksDtoToJson(_SocialLinksDto instance) =>
    <String, dynamic>{
      'website': instance.website,
      'imdb': instance.imdb,
      'linkedin': instance.linkedin,
      'instagram': instance.instagram,
      'youtube': instance.youtube,
      'vimeo': instance.vimeo,
      'twitter': instance.twitter,
    };

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequest(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  bio: json['bio'] as String?,
  headline: json['headline'] as String?,
  location: json['location'] == null
      ? null
      : LocationDto.fromJson(json['location'] as Map<String, dynamic>),
  skills: (json['skills'] as List<dynamic>?)
      ?.map((e) => SkillDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  socialLinks: json['socialLinks'] == null
      ? null
      : SocialLinksDto.fromJson(json['socialLinks'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'bio': instance.bio,
  'headline': instance.headline,
  'location': instance.location,
  'skills': instance.skills,
  'socialLinks': instance.socialLinks,
};
