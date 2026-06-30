// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectDto {

 String get id; String get title; String get type; String? get slug; String? get tagline; String? get synopsis; String? get description; String? get status; List<String>? get genres; List<String>? get tags; String? get language; String? get poster; String? get coverImage; String? get visibility; ProjectBudgetDto? get budget; ProjectDurationDto? get duration; UserDto? get owner; String? get team; int? get viewCount; int? get likeCount; bool? get allowApplications; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectDtoCopyWith<ProjectDto> get copyWith => _$ProjectDtoCopyWithImpl<ProjectDto>(this as ProjectDto, _$identity);

  /// Serializes this ProjectDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.genres, genres)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.language, language) || other.language == language)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.team, team) || other.team == team)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.allowApplications, allowApplications) || other.allowApplications == allowApplications)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,type,slug,tagline,synopsis,description,status,const DeepCollectionEquality().hash(genres),const DeepCollectionEquality().hash(tags),language,poster,coverImage,visibility,budget,duration,owner,team,viewCount,likeCount,allowApplications,createdAt,updatedAt]);

@override
String toString() {
  return 'ProjectDto(id: $id, title: $title, type: $type, slug: $slug, tagline: $tagline, synopsis: $synopsis, description: $description, status: $status, genres: $genres, tags: $tags, language: $language, poster: $poster, coverImage: $coverImage, visibility: $visibility, budget: $budget, duration: $duration, owner: $owner, team: $team, viewCount: $viewCount, likeCount: $likeCount, allowApplications: $allowApplications, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ProjectDtoCopyWith<$Res>  {
  factory $ProjectDtoCopyWith(ProjectDto value, $Res Function(ProjectDto) _then) = _$ProjectDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String type, String? slug, String? tagline, String? synopsis, String? description, String? status, List<String>? genres, List<String>? tags, String? language, String? poster, String? coverImage, String? visibility, ProjectBudgetDto? budget, ProjectDurationDto? duration, UserDto? owner, String? team, int? viewCount, int? likeCount, bool? allowApplications, DateTime? createdAt, DateTime? updatedAt
});


$ProjectBudgetDtoCopyWith<$Res>? get budget;$ProjectDurationDtoCopyWith<$Res>? get duration;$UserDtoCopyWith<$Res>? get owner;

}
/// @nodoc
class _$ProjectDtoCopyWithImpl<$Res>
    implements $ProjectDtoCopyWith<$Res> {
  _$ProjectDtoCopyWithImpl(this._self, this._then);

  final ProjectDto _self;
  final $Res Function(ProjectDto) _then;

/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? slug = freezed,Object? tagline = freezed,Object? synopsis = freezed,Object? description = freezed,Object? status = freezed,Object? genres = freezed,Object? tags = freezed,Object? language = freezed,Object? poster = freezed,Object? coverImage = freezed,Object? visibility = freezed,Object? budget = freezed,Object? duration = freezed,Object? owner = freezed,Object? team = freezed,Object? viewCount = freezed,Object? likeCount = freezed,Object? allowApplications = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,genres: freezed == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as String?,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as ProjectBudgetDto?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as ProjectDurationDto?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as UserDto?,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,likeCount: freezed == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int?,allowApplications: freezed == allowApplications ? _self.allowApplications : allowApplications // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectBudgetDtoCopyWith<$Res>? get budget {
    if (_self.budget == null) {
    return null;
  }

  return $ProjectBudgetDtoCopyWith<$Res>(_self.budget!, (value) {
    return _then(_self.copyWith(budget: value));
  });
}/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectDurationDtoCopyWith<$Res>? get duration {
    if (_self.duration == null) {
    return null;
  }

  return $ProjectDurationDtoCopyWith<$Res>(_self.duration!, (value) {
    return _then(_self.copyWith(duration: value));
  });
}/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $UserDtoCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectDto].
extension ProjectDtoPatterns on ProjectDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectDto value)  $default,){
final _that = this;
switch (_that) {
case _ProjectDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String type,  String? slug,  String? tagline,  String? synopsis,  String? description,  String? status,  List<String>? genres,  List<String>? tags,  String? language,  String? poster,  String? coverImage,  String? visibility,  ProjectBudgetDto? budget,  ProjectDurationDto? duration,  UserDto? owner,  String? team,  int? viewCount,  int? likeCount,  bool? allowApplications,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectDto() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.slug,_that.tagline,_that.synopsis,_that.description,_that.status,_that.genres,_that.tags,_that.language,_that.poster,_that.coverImage,_that.visibility,_that.budget,_that.duration,_that.owner,_that.team,_that.viewCount,_that.likeCount,_that.allowApplications,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String type,  String? slug,  String? tagline,  String? synopsis,  String? description,  String? status,  List<String>? genres,  List<String>? tags,  String? language,  String? poster,  String? coverImage,  String? visibility,  ProjectBudgetDto? budget,  ProjectDurationDto? duration,  UserDto? owner,  String? team,  int? viewCount,  int? likeCount,  bool? allowApplications,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ProjectDto():
return $default(_that.id,_that.title,_that.type,_that.slug,_that.tagline,_that.synopsis,_that.description,_that.status,_that.genres,_that.tags,_that.language,_that.poster,_that.coverImage,_that.visibility,_that.budget,_that.duration,_that.owner,_that.team,_that.viewCount,_that.likeCount,_that.allowApplications,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String type,  String? slug,  String? tagline,  String? synopsis,  String? description,  String? status,  List<String>? genres,  List<String>? tags,  String? language,  String? poster,  String? coverImage,  String? visibility,  ProjectBudgetDto? budget,  ProjectDurationDto? duration,  UserDto? owner,  String? team,  int? viewCount,  int? likeCount,  bool? allowApplications,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ProjectDto() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.slug,_that.tagline,_that.synopsis,_that.description,_that.status,_that.genres,_that.tags,_that.language,_that.poster,_that.coverImage,_that.visibility,_that.budget,_that.duration,_that.owner,_that.team,_that.viewCount,_that.likeCount,_that.allowApplications,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectDto implements ProjectDto {
  const _ProjectDto({required this.id, required this.title, required this.type, this.slug, this.tagline, this.synopsis, this.description, this.status, final  List<String>? genres, final  List<String>? tags, this.language, this.poster, this.coverImage, this.visibility, this.budget, this.duration, this.owner, this.team, this.viewCount, this.likeCount, this.allowApplications, this.createdAt, this.updatedAt}): _genres = genres,_tags = tags;
  factory _ProjectDto.fromJson(Map<String, dynamic> json) => _$ProjectDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String type;
@override final  String? slug;
@override final  String? tagline;
@override final  String? synopsis;
@override final  String? description;
@override final  String? status;
 final  List<String>? _genres;
@override List<String>? get genres {
  final value = _genres;
  if (value == null) return null;
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? language;
@override final  String? poster;
@override final  String? coverImage;
@override final  String? visibility;
@override final  ProjectBudgetDto? budget;
@override final  ProjectDurationDto? duration;
@override final  UserDto? owner;
@override final  String? team;
@override final  int? viewCount;
@override final  int? likeCount;
@override final  bool? allowApplications;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectDtoCopyWith<_ProjectDto> get copyWith => __$ProjectDtoCopyWithImpl<_ProjectDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._genres, _genres)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.language, language) || other.language == language)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.team, team) || other.team == team)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.allowApplications, allowApplications) || other.allowApplications == allowApplications)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,type,slug,tagline,synopsis,description,status,const DeepCollectionEquality().hash(_genres),const DeepCollectionEquality().hash(_tags),language,poster,coverImage,visibility,budget,duration,owner,team,viewCount,likeCount,allowApplications,createdAt,updatedAt]);

@override
String toString() {
  return 'ProjectDto(id: $id, title: $title, type: $type, slug: $slug, tagline: $tagline, synopsis: $synopsis, description: $description, status: $status, genres: $genres, tags: $tags, language: $language, poster: $poster, coverImage: $coverImage, visibility: $visibility, budget: $budget, duration: $duration, owner: $owner, team: $team, viewCount: $viewCount, likeCount: $likeCount, allowApplications: $allowApplications, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ProjectDtoCopyWith<$Res> implements $ProjectDtoCopyWith<$Res> {
  factory _$ProjectDtoCopyWith(_ProjectDto value, $Res Function(_ProjectDto) _then) = __$ProjectDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String type, String? slug, String? tagline, String? synopsis, String? description, String? status, List<String>? genres, List<String>? tags, String? language, String? poster, String? coverImage, String? visibility, ProjectBudgetDto? budget, ProjectDurationDto? duration, UserDto? owner, String? team, int? viewCount, int? likeCount, bool? allowApplications, DateTime? createdAt, DateTime? updatedAt
});


@override $ProjectBudgetDtoCopyWith<$Res>? get budget;@override $ProjectDurationDtoCopyWith<$Res>? get duration;@override $UserDtoCopyWith<$Res>? get owner;

}
/// @nodoc
class __$ProjectDtoCopyWithImpl<$Res>
    implements _$ProjectDtoCopyWith<$Res> {
  __$ProjectDtoCopyWithImpl(this._self, this._then);

  final _ProjectDto _self;
  final $Res Function(_ProjectDto) _then;

/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? slug = freezed,Object? tagline = freezed,Object? synopsis = freezed,Object? description = freezed,Object? status = freezed,Object? genres = freezed,Object? tags = freezed,Object? language = freezed,Object? poster = freezed,Object? coverImage = freezed,Object? visibility = freezed,Object? budget = freezed,Object? duration = freezed,Object? owner = freezed,Object? team = freezed,Object? viewCount = freezed,Object? likeCount = freezed,Object? allowApplications = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ProjectDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,genres: freezed == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,poster: freezed == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as String?,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as ProjectBudgetDto?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as ProjectDurationDto?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as UserDto?,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,likeCount: freezed == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int?,allowApplications: freezed == allowApplications ? _self.allowApplications : allowApplications // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectBudgetDtoCopyWith<$Res>? get budget {
    if (_self.budget == null) {
    return null;
  }

  return $ProjectBudgetDtoCopyWith<$Res>(_self.budget!, (value) {
    return _then(_self.copyWith(budget: value));
  });
}/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectDurationDtoCopyWith<$Res>? get duration {
    if (_self.duration == null) {
    return null;
  }

  return $ProjectDurationDtoCopyWith<$Res>(_self.duration!, (value) {
    return _then(_self.copyWith(duration: value));
  });
}/// Create a copy of ProjectDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res>? get owner {
    if (_self.owner == null) {
    return null;
  }

  return $UserDtoCopyWith<$Res>(_self.owner!, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// @nodoc
mixin _$ProjectBudgetDto {

 double? get estimated; String get currency;
/// Create a copy of ProjectBudgetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectBudgetDtoCopyWith<ProjectBudgetDto> get copyWith => _$ProjectBudgetDtoCopyWithImpl<ProjectBudgetDto>(this as ProjectBudgetDto, _$identity);

  /// Serializes this ProjectBudgetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectBudgetDto&&(identical(other.estimated, estimated) || other.estimated == estimated)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimated,currency);

@override
String toString() {
  return 'ProjectBudgetDto(estimated: $estimated, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $ProjectBudgetDtoCopyWith<$Res>  {
  factory $ProjectBudgetDtoCopyWith(ProjectBudgetDto value, $Res Function(ProjectBudgetDto) _then) = _$ProjectBudgetDtoCopyWithImpl;
@useResult
$Res call({
 double? estimated, String currency
});




}
/// @nodoc
class _$ProjectBudgetDtoCopyWithImpl<$Res>
    implements $ProjectBudgetDtoCopyWith<$Res> {
  _$ProjectBudgetDtoCopyWithImpl(this._self, this._then);

  final ProjectBudgetDto _self;
  final $Res Function(ProjectBudgetDto) _then;

/// Create a copy of ProjectBudgetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? estimated = freezed,Object? currency = null,}) {
  return _then(_self.copyWith(
estimated: freezed == estimated ? _self.estimated : estimated // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectBudgetDto].
extension ProjectBudgetDtoPatterns on ProjectBudgetDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectBudgetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectBudgetDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectBudgetDto value)  $default,){
final _that = this;
switch (_that) {
case _ProjectBudgetDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectBudgetDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectBudgetDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? estimated,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectBudgetDto() when $default != null:
return $default(_that.estimated,_that.currency);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? estimated,  String currency)  $default,) {final _that = this;
switch (_that) {
case _ProjectBudgetDto():
return $default(_that.estimated,_that.currency);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? estimated,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _ProjectBudgetDto() when $default != null:
return $default(_that.estimated,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectBudgetDto implements ProjectBudgetDto {
  const _ProjectBudgetDto({this.estimated, this.currency = 'USD'});
  factory _ProjectBudgetDto.fromJson(Map<String, dynamic> json) => _$ProjectBudgetDtoFromJson(json);

@override final  double? estimated;
@override@JsonKey() final  String currency;

/// Create a copy of ProjectBudgetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectBudgetDtoCopyWith<_ProjectBudgetDto> get copyWith => __$ProjectBudgetDtoCopyWithImpl<_ProjectBudgetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectBudgetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectBudgetDto&&(identical(other.estimated, estimated) || other.estimated == estimated)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimated,currency);

@override
String toString() {
  return 'ProjectBudgetDto(estimated: $estimated, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$ProjectBudgetDtoCopyWith<$Res> implements $ProjectBudgetDtoCopyWith<$Res> {
  factory _$ProjectBudgetDtoCopyWith(_ProjectBudgetDto value, $Res Function(_ProjectBudgetDto) _then) = __$ProjectBudgetDtoCopyWithImpl;
@override @useResult
$Res call({
 double? estimated, String currency
});




}
/// @nodoc
class __$ProjectBudgetDtoCopyWithImpl<$Res>
    implements _$ProjectBudgetDtoCopyWith<$Res> {
  __$ProjectBudgetDtoCopyWithImpl(this._self, this._then);

  final _ProjectBudgetDto _self;
  final $Res Function(_ProjectBudgetDto) _then;

/// Create a copy of ProjectBudgetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? estimated = freezed,Object? currency = null,}) {
  return _then(_ProjectBudgetDto(
estimated: freezed == estimated ? _self.estimated : estimated // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProjectDurationDto {

 int? get estimated;
/// Create a copy of ProjectDurationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectDurationDtoCopyWith<ProjectDurationDto> get copyWith => _$ProjectDurationDtoCopyWithImpl<ProjectDurationDto>(this as ProjectDurationDto, _$identity);

  /// Serializes this ProjectDurationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectDurationDto&&(identical(other.estimated, estimated) || other.estimated == estimated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimated);

@override
String toString() {
  return 'ProjectDurationDto(estimated: $estimated)';
}


}

/// @nodoc
abstract mixin class $ProjectDurationDtoCopyWith<$Res>  {
  factory $ProjectDurationDtoCopyWith(ProjectDurationDto value, $Res Function(ProjectDurationDto) _then) = _$ProjectDurationDtoCopyWithImpl;
@useResult
$Res call({
 int? estimated
});




}
/// @nodoc
class _$ProjectDurationDtoCopyWithImpl<$Res>
    implements $ProjectDurationDtoCopyWith<$Res> {
  _$ProjectDurationDtoCopyWithImpl(this._self, this._then);

  final ProjectDurationDto _self;
  final $Res Function(ProjectDurationDto) _then;

/// Create a copy of ProjectDurationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? estimated = freezed,}) {
  return _then(_self.copyWith(
estimated: freezed == estimated ? _self.estimated : estimated // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectDurationDto].
extension ProjectDurationDtoPatterns on ProjectDurationDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectDurationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectDurationDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectDurationDto value)  $default,){
final _that = this;
switch (_that) {
case _ProjectDurationDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectDurationDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectDurationDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? estimated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectDurationDto() when $default != null:
return $default(_that.estimated);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? estimated)  $default,) {final _that = this;
switch (_that) {
case _ProjectDurationDto():
return $default(_that.estimated);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? estimated)?  $default,) {final _that = this;
switch (_that) {
case _ProjectDurationDto() when $default != null:
return $default(_that.estimated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectDurationDto implements ProjectDurationDto {
  const _ProjectDurationDto({this.estimated});
  factory _ProjectDurationDto.fromJson(Map<String, dynamic> json) => _$ProjectDurationDtoFromJson(json);

@override final  int? estimated;

/// Create a copy of ProjectDurationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectDurationDtoCopyWith<_ProjectDurationDto> get copyWith => __$ProjectDurationDtoCopyWithImpl<_ProjectDurationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectDurationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectDurationDto&&(identical(other.estimated, estimated) || other.estimated == estimated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimated);

@override
String toString() {
  return 'ProjectDurationDto(estimated: $estimated)';
}


}

/// @nodoc
abstract mixin class _$ProjectDurationDtoCopyWith<$Res> implements $ProjectDurationDtoCopyWith<$Res> {
  factory _$ProjectDurationDtoCopyWith(_ProjectDurationDto value, $Res Function(_ProjectDurationDto) _then) = __$ProjectDurationDtoCopyWithImpl;
@override @useResult
$Res call({
 int? estimated
});




}
/// @nodoc
class __$ProjectDurationDtoCopyWithImpl<$Res>
    implements _$ProjectDurationDtoCopyWith<$Res> {
  __$ProjectDurationDtoCopyWithImpl(this._self, this._then);

  final _ProjectDurationDto _self;
  final $Res Function(_ProjectDurationDto) _then;

/// Create a copy of ProjectDurationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? estimated = freezed,}) {
  return _then(_ProjectDurationDto(
estimated: freezed == estimated ? _self.estimated : estimated // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CreateProjectRequest {

 String get title; String get type; String? get tagline; String? get synopsis; String? get description; List<String>? get genres; String? get language; String? get visibility; ProjectBudgetDto? get budget; ProjectDurationDto? get duration;
/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateProjectRequestCopyWith<CreateProjectRequest> get copyWith => _$CreateProjectRequestCopyWithImpl<CreateProjectRequest>(this as CreateProjectRequest, _$identity);

  /// Serializes this CreateProjectRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateProjectRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.language, language) || other.language == language)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,type,tagline,synopsis,description,const DeepCollectionEquality().hash(genres),language,visibility,budget,duration);

@override
String toString() {
  return 'CreateProjectRequest(title: $title, type: $type, tagline: $tagline, synopsis: $synopsis, description: $description, genres: $genres, language: $language, visibility: $visibility, budget: $budget, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $CreateProjectRequestCopyWith<$Res>  {
  factory $CreateProjectRequestCopyWith(CreateProjectRequest value, $Res Function(CreateProjectRequest) _then) = _$CreateProjectRequestCopyWithImpl;
@useResult
$Res call({
 String title, String type, String? tagline, String? synopsis, String? description, List<String>? genres, String? language, String? visibility, ProjectBudgetDto? budget, ProjectDurationDto? duration
});


$ProjectBudgetDtoCopyWith<$Res>? get budget;$ProjectDurationDtoCopyWith<$Res>? get duration;

}
/// @nodoc
class _$CreateProjectRequestCopyWithImpl<$Res>
    implements $CreateProjectRequestCopyWith<$Res> {
  _$CreateProjectRequestCopyWithImpl(this._self, this._then);

  final CreateProjectRequest _self;
  final $Res Function(CreateProjectRequest) _then;

/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? type = null,Object? tagline = freezed,Object? synopsis = freezed,Object? description = freezed,Object? genres = freezed,Object? language = freezed,Object? visibility = freezed,Object? budget = freezed,Object? duration = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,genres: freezed == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as ProjectBudgetDto?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as ProjectDurationDto?,
  ));
}
/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectBudgetDtoCopyWith<$Res>? get budget {
    if (_self.budget == null) {
    return null;
  }

  return $ProjectBudgetDtoCopyWith<$Res>(_self.budget!, (value) {
    return _then(_self.copyWith(budget: value));
  });
}/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectDurationDtoCopyWith<$Res>? get duration {
    if (_self.duration == null) {
    return null;
  }

  return $ProjectDurationDtoCopyWith<$Res>(_self.duration!, (value) {
    return _then(_self.copyWith(duration: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateProjectRequest].
extension CreateProjectRequestPatterns on CreateProjectRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateProjectRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateProjectRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateProjectRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateProjectRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateProjectRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateProjectRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String type,  String? tagline,  String? synopsis,  String? description,  List<String>? genres,  String? language,  String? visibility,  ProjectBudgetDto? budget,  ProjectDurationDto? duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateProjectRequest() when $default != null:
return $default(_that.title,_that.type,_that.tagline,_that.synopsis,_that.description,_that.genres,_that.language,_that.visibility,_that.budget,_that.duration);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String type,  String? tagline,  String? synopsis,  String? description,  List<String>? genres,  String? language,  String? visibility,  ProjectBudgetDto? budget,  ProjectDurationDto? duration)  $default,) {final _that = this;
switch (_that) {
case _CreateProjectRequest():
return $default(_that.title,_that.type,_that.tagline,_that.synopsis,_that.description,_that.genres,_that.language,_that.visibility,_that.budget,_that.duration);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String type,  String? tagline,  String? synopsis,  String? description,  List<String>? genres,  String? language,  String? visibility,  ProjectBudgetDto? budget,  ProjectDurationDto? duration)?  $default,) {final _that = this;
switch (_that) {
case _CreateProjectRequest() when $default != null:
return $default(_that.title,_that.type,_that.tagline,_that.synopsis,_that.description,_that.genres,_that.language,_that.visibility,_that.budget,_that.duration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateProjectRequest implements CreateProjectRequest {
  const _CreateProjectRequest({required this.title, required this.type, this.tagline, this.synopsis, this.description, final  List<String>? genres, this.language, this.visibility, this.budget, this.duration}): _genres = genres;
  factory _CreateProjectRequest.fromJson(Map<String, dynamic> json) => _$CreateProjectRequestFromJson(json);

@override final  String title;
@override final  String type;
@override final  String? tagline;
@override final  String? synopsis;
@override final  String? description;
 final  List<String>? _genres;
@override List<String>? get genres {
  final value = _genres;
  if (value == null) return null;
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? language;
@override final  String? visibility;
@override final  ProjectBudgetDto? budget;
@override final  ProjectDurationDto? duration;

/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateProjectRequestCopyWith<_CreateProjectRequest> get copyWith => __$CreateProjectRequestCopyWithImpl<_CreateProjectRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateProjectRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateProjectRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.language, language) || other.language == language)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,type,tagline,synopsis,description,const DeepCollectionEquality().hash(_genres),language,visibility,budget,duration);

@override
String toString() {
  return 'CreateProjectRequest(title: $title, type: $type, tagline: $tagline, synopsis: $synopsis, description: $description, genres: $genres, language: $language, visibility: $visibility, budget: $budget, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$CreateProjectRequestCopyWith<$Res> implements $CreateProjectRequestCopyWith<$Res> {
  factory _$CreateProjectRequestCopyWith(_CreateProjectRequest value, $Res Function(_CreateProjectRequest) _then) = __$CreateProjectRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String type, String? tagline, String? synopsis, String? description, List<String>? genres, String? language, String? visibility, ProjectBudgetDto? budget, ProjectDurationDto? duration
});


@override $ProjectBudgetDtoCopyWith<$Res>? get budget;@override $ProjectDurationDtoCopyWith<$Res>? get duration;

}
/// @nodoc
class __$CreateProjectRequestCopyWithImpl<$Res>
    implements _$CreateProjectRequestCopyWith<$Res> {
  __$CreateProjectRequestCopyWithImpl(this._self, this._then);

  final _CreateProjectRequest _self;
  final $Res Function(_CreateProjectRequest) _then;

/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? type = null,Object? tagline = freezed,Object? synopsis = freezed,Object? description = freezed,Object? genres = freezed,Object? language = freezed,Object? visibility = freezed,Object? budget = freezed,Object? duration = freezed,}) {
  return _then(_CreateProjectRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,genres: freezed == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as ProjectBudgetDto?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as ProjectDurationDto?,
  ));
}

/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectBudgetDtoCopyWith<$Res>? get budget {
    if (_self.budget == null) {
    return null;
  }

  return $ProjectBudgetDtoCopyWith<$Res>(_self.budget!, (value) {
    return _then(_self.copyWith(budget: value));
  });
}/// Create a copy of CreateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectDurationDtoCopyWith<$Res>? get duration {
    if (_self.duration == null) {
    return null;
  }

  return $ProjectDurationDtoCopyWith<$Res>(_self.duration!, (value) {
    return _then(_self.copyWith(duration: value));
  });
}
}


/// @nodoc
mixin _$UpdateProjectRequest {

 String? get title; String? get tagline; String? get synopsis; String? get description; String? get status; List<String>? get genres; String? get visibility; bool? get allowApplications;
/// Create a copy of UpdateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProjectRequestCopyWith<UpdateProjectRequest> get copyWith => _$UpdateProjectRequestCopyWithImpl<UpdateProjectRequest>(this as UpdateProjectRequest, _$identity);

  /// Serializes this UpdateProjectRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProjectRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.allowApplications, allowApplications) || other.allowApplications == allowApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,tagline,synopsis,description,status,const DeepCollectionEquality().hash(genres),visibility,allowApplications);

@override
String toString() {
  return 'UpdateProjectRequest(title: $title, tagline: $tagline, synopsis: $synopsis, description: $description, status: $status, genres: $genres, visibility: $visibility, allowApplications: $allowApplications)';
}


}

/// @nodoc
abstract mixin class $UpdateProjectRequestCopyWith<$Res>  {
  factory $UpdateProjectRequestCopyWith(UpdateProjectRequest value, $Res Function(UpdateProjectRequest) _then) = _$UpdateProjectRequestCopyWithImpl;
@useResult
$Res call({
 String? title, String? tagline, String? synopsis, String? description, String? status, List<String>? genres, String? visibility, bool? allowApplications
});




}
/// @nodoc
class _$UpdateProjectRequestCopyWithImpl<$Res>
    implements $UpdateProjectRequestCopyWith<$Res> {
  _$UpdateProjectRequestCopyWithImpl(this._self, this._then);

  final UpdateProjectRequest _self;
  final $Res Function(UpdateProjectRequest) _then;

/// Create a copy of UpdateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? tagline = freezed,Object? synopsis = freezed,Object? description = freezed,Object? status = freezed,Object? genres = freezed,Object? visibility = freezed,Object? allowApplications = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,genres: freezed == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,allowApplications: freezed == allowApplications ? _self.allowApplications : allowApplications // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateProjectRequest].
extension UpdateProjectRequestPatterns on UpdateProjectRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateProjectRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateProjectRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateProjectRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateProjectRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateProjectRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateProjectRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? tagline,  String? synopsis,  String? description,  String? status,  List<String>? genres,  String? visibility,  bool? allowApplications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateProjectRequest() when $default != null:
return $default(_that.title,_that.tagline,_that.synopsis,_that.description,_that.status,_that.genres,_that.visibility,_that.allowApplications);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? tagline,  String? synopsis,  String? description,  String? status,  List<String>? genres,  String? visibility,  bool? allowApplications)  $default,) {final _that = this;
switch (_that) {
case _UpdateProjectRequest():
return $default(_that.title,_that.tagline,_that.synopsis,_that.description,_that.status,_that.genres,_that.visibility,_that.allowApplications);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? tagline,  String? synopsis,  String? description,  String? status,  List<String>? genres,  String? visibility,  bool? allowApplications)?  $default,) {final _that = this;
switch (_that) {
case _UpdateProjectRequest() when $default != null:
return $default(_that.title,_that.tagline,_that.synopsis,_that.description,_that.status,_that.genres,_that.visibility,_that.allowApplications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateProjectRequest implements UpdateProjectRequest {
  const _UpdateProjectRequest({this.title, this.tagline, this.synopsis, this.description, this.status, final  List<String>? genres, this.visibility, this.allowApplications}): _genres = genres;
  factory _UpdateProjectRequest.fromJson(Map<String, dynamic> json) => _$UpdateProjectRequestFromJson(json);

@override final  String? title;
@override final  String? tagline;
@override final  String? synopsis;
@override final  String? description;
@override final  String? status;
 final  List<String>? _genres;
@override List<String>? get genres {
  final value = _genres;
  if (value == null) return null;
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? visibility;
@override final  bool? allowApplications;

/// Create a copy of UpdateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProjectRequestCopyWith<_UpdateProjectRequest> get copyWith => __$UpdateProjectRequestCopyWithImpl<_UpdateProjectRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateProjectRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProjectRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.allowApplications, allowApplications) || other.allowApplications == allowApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,tagline,synopsis,description,status,const DeepCollectionEquality().hash(_genres),visibility,allowApplications);

@override
String toString() {
  return 'UpdateProjectRequest(title: $title, tagline: $tagline, synopsis: $synopsis, description: $description, status: $status, genres: $genres, visibility: $visibility, allowApplications: $allowApplications)';
}


}

/// @nodoc
abstract mixin class _$UpdateProjectRequestCopyWith<$Res> implements $UpdateProjectRequestCopyWith<$Res> {
  factory _$UpdateProjectRequestCopyWith(_UpdateProjectRequest value, $Res Function(_UpdateProjectRequest) _then) = __$UpdateProjectRequestCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? tagline, String? synopsis, String? description, String? status, List<String>? genres, String? visibility, bool? allowApplications
});




}
/// @nodoc
class __$UpdateProjectRequestCopyWithImpl<$Res>
    implements _$UpdateProjectRequestCopyWith<$Res> {
  __$UpdateProjectRequestCopyWithImpl(this._self, this._then);

  final _UpdateProjectRequest _self;
  final $Res Function(_UpdateProjectRequest) _then;

/// Create a copy of UpdateProjectRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? tagline = freezed,Object? synopsis = freezed,Object? description = freezed,Object? status = freezed,Object? genres = freezed,Object? visibility = freezed,Object? allowApplications = freezed,}) {
  return _then(_UpdateProjectRequest(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,tagline: freezed == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,genres: freezed == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,allowApplications: freezed == allowApplications ? _self.allowApplications : allowApplications // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
