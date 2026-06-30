// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PortfolioItemDto {

 String get id; String get title; String get type; String? get description; PortfolioMediaDto? get media; List<String>? get tags; List<PortfolioCreditDto>? get credits; int? get viewCount; int? get likeCount; bool? get isFeatured; String? get visibility; String? get owner; DateTime? get createdAt;
/// Create a copy of PortfolioItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioItemDtoCopyWith<PortfolioItemDto> get copyWith => _$PortfolioItemDtoCopyWithImpl<PortfolioItemDto>(this as PortfolioItemDto, _$identity);

  /// Serializes this PortfolioItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.media, media) || other.media == media)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.credits, credits)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,description,media,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(credits),viewCount,likeCount,isFeatured,visibility,owner,createdAt);

@override
String toString() {
  return 'PortfolioItemDto(id: $id, title: $title, type: $type, description: $description, media: $media, tags: $tags, credits: $credits, viewCount: $viewCount, likeCount: $likeCount, isFeatured: $isFeatured, visibility: $visibility, owner: $owner, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PortfolioItemDtoCopyWith<$Res>  {
  factory $PortfolioItemDtoCopyWith(PortfolioItemDto value, $Res Function(PortfolioItemDto) _then) = _$PortfolioItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String type, String? description, PortfolioMediaDto? media, List<String>? tags, List<PortfolioCreditDto>? credits, int? viewCount, int? likeCount, bool? isFeatured, String? visibility, String? owner, DateTime? createdAt
});


$PortfolioMediaDtoCopyWith<$Res>? get media;

}
/// @nodoc
class _$PortfolioItemDtoCopyWithImpl<$Res>
    implements $PortfolioItemDtoCopyWith<$Res> {
  _$PortfolioItemDtoCopyWithImpl(this._self, this._then);

  final PortfolioItemDto _self;
  final $Res Function(PortfolioItemDto) _then;

/// Create a copy of PortfolioItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? description = freezed,Object? media = freezed,Object? tags = freezed,Object? credits = freezed,Object? viewCount = freezed,Object? likeCount = freezed,Object? isFeatured = freezed,Object? visibility = freezed,Object? owner = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as PortfolioMediaDto?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,credits: freezed == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as List<PortfolioCreditDto>?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,likeCount: freezed == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of PortfolioItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioMediaDtoCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $PortfolioMediaDtoCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}


/// Adds pattern-matching-related methods to [PortfolioItemDto].
extension PortfolioItemDtoPatterns on PortfolioItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioItemDto value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String type,  String? description,  PortfolioMediaDto? media,  List<String>? tags,  List<PortfolioCreditDto>? credits,  int? viewCount,  int? likeCount,  bool? isFeatured,  String? visibility,  String? owner,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioItemDto() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.description,_that.media,_that.tags,_that.credits,_that.viewCount,_that.likeCount,_that.isFeatured,_that.visibility,_that.owner,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String type,  String? description,  PortfolioMediaDto? media,  List<String>? tags,  List<PortfolioCreditDto>? credits,  int? viewCount,  int? likeCount,  bool? isFeatured,  String? visibility,  String? owner,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PortfolioItemDto():
return $default(_that.id,_that.title,_that.type,_that.description,_that.media,_that.tags,_that.credits,_that.viewCount,_that.likeCount,_that.isFeatured,_that.visibility,_that.owner,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String type,  String? description,  PortfolioMediaDto? media,  List<String>? tags,  List<PortfolioCreditDto>? credits,  int? viewCount,  int? likeCount,  bool? isFeatured,  String? visibility,  String? owner,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioItemDto() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.description,_that.media,_that.tags,_that.credits,_that.viewCount,_that.likeCount,_that.isFeatured,_that.visibility,_that.owner,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioItemDto implements PortfolioItemDto {
  const _PortfolioItemDto({required this.id, required this.title, required this.type, this.description, this.media, final  List<String>? tags, final  List<PortfolioCreditDto>? credits, this.viewCount, this.likeCount, this.isFeatured, this.visibility, this.owner, this.createdAt}): _tags = tags,_credits = credits;
  factory _PortfolioItemDto.fromJson(Map<String, dynamic> json) => _$PortfolioItemDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String type;
@override final  String? description;
@override final  PortfolioMediaDto? media;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<PortfolioCreditDto>? _credits;
@override List<PortfolioCreditDto>? get credits {
  final value = _credits;
  if (value == null) return null;
  if (_credits is EqualUnmodifiableListView) return _credits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? viewCount;
@override final  int? likeCount;
@override final  bool? isFeatured;
@override final  String? visibility;
@override final  String? owner;
@override final  DateTime? createdAt;

/// Create a copy of PortfolioItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioItemDtoCopyWith<_PortfolioItemDto> get copyWith => __$PortfolioItemDtoCopyWithImpl<_PortfolioItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.media, media) || other.media == media)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._credits, _credits)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,description,media,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_credits),viewCount,likeCount,isFeatured,visibility,owner,createdAt);

@override
String toString() {
  return 'PortfolioItemDto(id: $id, title: $title, type: $type, description: $description, media: $media, tags: $tags, credits: $credits, viewCount: $viewCount, likeCount: $likeCount, isFeatured: $isFeatured, visibility: $visibility, owner: $owner, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PortfolioItemDtoCopyWith<$Res> implements $PortfolioItemDtoCopyWith<$Res> {
  factory _$PortfolioItemDtoCopyWith(_PortfolioItemDto value, $Res Function(_PortfolioItemDto) _then) = __$PortfolioItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String type, String? description, PortfolioMediaDto? media, List<String>? tags, List<PortfolioCreditDto>? credits, int? viewCount, int? likeCount, bool? isFeatured, String? visibility, String? owner, DateTime? createdAt
});


@override $PortfolioMediaDtoCopyWith<$Res>? get media;

}
/// @nodoc
class __$PortfolioItemDtoCopyWithImpl<$Res>
    implements _$PortfolioItemDtoCopyWith<$Res> {
  __$PortfolioItemDtoCopyWithImpl(this._self, this._then);

  final _PortfolioItemDto _self;
  final $Res Function(_PortfolioItemDto) _then;

/// Create a copy of PortfolioItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? description = freezed,Object? media = freezed,Object? tags = freezed,Object? credits = freezed,Object? viewCount = freezed,Object? likeCount = freezed,Object? isFeatured = freezed,Object? visibility = freezed,Object? owner = freezed,Object? createdAt = freezed,}) {
  return _then(_PortfolioItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as PortfolioMediaDto?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,credits: freezed == credits ? _self._credits : credits // ignore: cast_nullable_to_non_nullable
as List<PortfolioCreditDto>?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,likeCount: freezed == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int?,isFeatured: freezed == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of PortfolioItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioMediaDtoCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $PortfolioMediaDtoCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}


/// @nodoc
mixin _$PortfolioMediaDto {

 String get url; String? get thumbnail; String? get type; int? get duration; String? get resolution;
/// Create a copy of PortfolioMediaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioMediaDtoCopyWith<PortfolioMediaDto> get copyWith => _$PortfolioMediaDtoCopyWithImpl<PortfolioMediaDto>(this as PortfolioMediaDto, _$identity);

  /// Serializes this PortfolioMediaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioMediaDto&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.type, type) || other.type == type)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.resolution, resolution) || other.resolution == resolution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,thumbnail,type,duration,resolution);

@override
String toString() {
  return 'PortfolioMediaDto(url: $url, thumbnail: $thumbnail, type: $type, duration: $duration, resolution: $resolution)';
}


}

/// @nodoc
abstract mixin class $PortfolioMediaDtoCopyWith<$Res>  {
  factory $PortfolioMediaDtoCopyWith(PortfolioMediaDto value, $Res Function(PortfolioMediaDto) _then) = _$PortfolioMediaDtoCopyWithImpl;
@useResult
$Res call({
 String url, String? thumbnail, String? type, int? duration, String? resolution
});




}
/// @nodoc
class _$PortfolioMediaDtoCopyWithImpl<$Res>
    implements $PortfolioMediaDtoCopyWith<$Res> {
  _$PortfolioMediaDtoCopyWithImpl(this._self, this._then);

  final PortfolioMediaDto _self;
  final $Res Function(PortfolioMediaDto) _then;

/// Create a copy of PortfolioMediaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? thumbnail = freezed,Object? type = freezed,Object? duration = freezed,Object? resolution = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioMediaDto].
extension PortfolioMediaDtoPatterns on PortfolioMediaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioMediaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioMediaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioMediaDto value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioMediaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioMediaDto value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioMediaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? thumbnail,  String? type,  int? duration,  String? resolution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioMediaDto() when $default != null:
return $default(_that.url,_that.thumbnail,_that.type,_that.duration,_that.resolution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? thumbnail,  String? type,  int? duration,  String? resolution)  $default,) {final _that = this;
switch (_that) {
case _PortfolioMediaDto():
return $default(_that.url,_that.thumbnail,_that.type,_that.duration,_that.resolution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? thumbnail,  String? type,  int? duration,  String? resolution)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioMediaDto() when $default != null:
return $default(_that.url,_that.thumbnail,_that.type,_that.duration,_that.resolution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioMediaDto implements PortfolioMediaDto {
  const _PortfolioMediaDto({required this.url, this.thumbnail, this.type, this.duration, this.resolution});
  factory _PortfolioMediaDto.fromJson(Map<String, dynamic> json) => _$PortfolioMediaDtoFromJson(json);

@override final  String url;
@override final  String? thumbnail;
@override final  String? type;
@override final  int? duration;
@override final  String? resolution;

/// Create a copy of PortfolioMediaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioMediaDtoCopyWith<_PortfolioMediaDto> get copyWith => __$PortfolioMediaDtoCopyWithImpl<_PortfolioMediaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioMediaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioMediaDto&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.type, type) || other.type == type)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.resolution, resolution) || other.resolution == resolution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,thumbnail,type,duration,resolution);

@override
String toString() {
  return 'PortfolioMediaDto(url: $url, thumbnail: $thumbnail, type: $type, duration: $duration, resolution: $resolution)';
}


}

/// @nodoc
abstract mixin class _$PortfolioMediaDtoCopyWith<$Res> implements $PortfolioMediaDtoCopyWith<$Res> {
  factory _$PortfolioMediaDtoCopyWith(_PortfolioMediaDto value, $Res Function(_PortfolioMediaDto) _then) = __$PortfolioMediaDtoCopyWithImpl;
@override @useResult
$Res call({
 String url, String? thumbnail, String? type, int? duration, String? resolution
});




}
/// @nodoc
class __$PortfolioMediaDtoCopyWithImpl<$Res>
    implements _$PortfolioMediaDtoCopyWith<$Res> {
  __$PortfolioMediaDtoCopyWithImpl(this._self, this._then);

  final _PortfolioMediaDto _self;
  final $Res Function(_PortfolioMediaDto) _then;

/// Create a copy of PortfolioMediaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? thumbnail = freezed,Object? type = freezed,Object? duration = freezed,Object? resolution = freezed,}) {
  return _then(_PortfolioMediaDto(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PortfolioCreditDto {

 String? get name; String? get role; String? get user;
/// Create a copy of PortfolioCreditDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioCreditDtoCopyWith<PortfolioCreditDto> get copyWith => _$PortfolioCreditDtoCopyWithImpl<PortfolioCreditDto>(this as PortfolioCreditDto, _$identity);

  /// Serializes this PortfolioCreditDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioCreditDto&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,role,user);

@override
String toString() {
  return 'PortfolioCreditDto(name: $name, role: $role, user: $user)';
}


}

/// @nodoc
abstract mixin class $PortfolioCreditDtoCopyWith<$Res>  {
  factory $PortfolioCreditDtoCopyWith(PortfolioCreditDto value, $Res Function(PortfolioCreditDto) _then) = _$PortfolioCreditDtoCopyWithImpl;
@useResult
$Res call({
 String? name, String? role, String? user
});




}
/// @nodoc
class _$PortfolioCreditDtoCopyWithImpl<$Res>
    implements $PortfolioCreditDtoCopyWith<$Res> {
  _$PortfolioCreditDtoCopyWithImpl(this._self, this._then);

  final PortfolioCreditDto _self;
  final $Res Function(PortfolioCreditDto) _then;

/// Create a copy of PortfolioCreditDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? role = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioCreditDto].
extension PortfolioCreditDtoPatterns on PortfolioCreditDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioCreditDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioCreditDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioCreditDto value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioCreditDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioCreditDto value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioCreditDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? role,  String? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioCreditDto() when $default != null:
return $default(_that.name,_that.role,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? role,  String? user)  $default,) {final _that = this;
switch (_that) {
case _PortfolioCreditDto():
return $default(_that.name,_that.role,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? role,  String? user)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioCreditDto() when $default != null:
return $default(_that.name,_that.role,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioCreditDto implements PortfolioCreditDto {
  const _PortfolioCreditDto({this.name, this.role, this.user});
  factory _PortfolioCreditDto.fromJson(Map<String, dynamic> json) => _$PortfolioCreditDtoFromJson(json);

@override final  String? name;
@override final  String? role;
@override final  String? user;

/// Create a copy of PortfolioCreditDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioCreditDtoCopyWith<_PortfolioCreditDto> get copyWith => __$PortfolioCreditDtoCopyWithImpl<_PortfolioCreditDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioCreditDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioCreditDto&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,role,user);

@override
String toString() {
  return 'PortfolioCreditDto(name: $name, role: $role, user: $user)';
}


}

/// @nodoc
abstract mixin class _$PortfolioCreditDtoCopyWith<$Res> implements $PortfolioCreditDtoCopyWith<$Res> {
  factory _$PortfolioCreditDtoCopyWith(_PortfolioCreditDto value, $Res Function(_PortfolioCreditDto) _then) = __$PortfolioCreditDtoCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? role, String? user
});




}
/// @nodoc
class __$PortfolioCreditDtoCopyWithImpl<$Res>
    implements _$PortfolioCreditDtoCopyWith<$Res> {
  __$PortfolioCreditDtoCopyWithImpl(this._self, this._then);

  final _PortfolioCreditDto _self;
  final $Res Function(_PortfolioCreditDto) _then;

/// Create a copy of PortfolioCreditDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? role = freezed,Object? user = freezed,}) {
  return _then(_PortfolioCreditDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreatePortfolioRequest {

 String get title; String get type; String? get description; PortfolioMediaDto get media; List<String>? get tags; String? get visibility;
/// Create a copy of CreatePortfolioRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePortfolioRequestCopyWith<CreatePortfolioRequest> get copyWith => _$CreatePortfolioRequestCopyWithImpl<CreatePortfolioRequest>(this as CreatePortfolioRequest, _$identity);

  /// Serializes this CreatePortfolioRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePortfolioRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.media, media) || other.media == media)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.visibility, visibility) || other.visibility == visibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,type,description,media,const DeepCollectionEquality().hash(tags),visibility);

@override
String toString() {
  return 'CreatePortfolioRequest(title: $title, type: $type, description: $description, media: $media, tags: $tags, visibility: $visibility)';
}


}

/// @nodoc
abstract mixin class $CreatePortfolioRequestCopyWith<$Res>  {
  factory $CreatePortfolioRequestCopyWith(CreatePortfolioRequest value, $Res Function(CreatePortfolioRequest) _then) = _$CreatePortfolioRequestCopyWithImpl;
@useResult
$Res call({
 String title, String type, String? description, PortfolioMediaDto media, List<String>? tags, String? visibility
});


$PortfolioMediaDtoCopyWith<$Res> get media;

}
/// @nodoc
class _$CreatePortfolioRequestCopyWithImpl<$Res>
    implements $CreatePortfolioRequestCopyWith<$Res> {
  _$CreatePortfolioRequestCopyWithImpl(this._self, this._then);

  final CreatePortfolioRequest _self;
  final $Res Function(CreatePortfolioRequest) _then;

/// Create a copy of CreatePortfolioRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? type = null,Object? description = freezed,Object? media = null,Object? tags = freezed,Object? visibility = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as PortfolioMediaDto,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CreatePortfolioRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioMediaDtoCopyWith<$Res> get media {
  
  return $PortfolioMediaDtoCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatePortfolioRequest].
extension CreatePortfolioRequestPatterns on CreatePortfolioRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePortfolioRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePortfolioRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePortfolioRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreatePortfolioRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePortfolioRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePortfolioRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String type,  String? description,  PortfolioMediaDto media,  List<String>? tags,  String? visibility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePortfolioRequest() when $default != null:
return $default(_that.title,_that.type,_that.description,_that.media,_that.tags,_that.visibility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String type,  String? description,  PortfolioMediaDto media,  List<String>? tags,  String? visibility)  $default,) {final _that = this;
switch (_that) {
case _CreatePortfolioRequest():
return $default(_that.title,_that.type,_that.description,_that.media,_that.tags,_that.visibility);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String type,  String? description,  PortfolioMediaDto media,  List<String>? tags,  String? visibility)?  $default,) {final _that = this;
switch (_that) {
case _CreatePortfolioRequest() when $default != null:
return $default(_that.title,_that.type,_that.description,_that.media,_that.tags,_that.visibility);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePortfolioRequest implements CreatePortfolioRequest {
  const _CreatePortfolioRequest({required this.title, required this.type, this.description, required this.media, final  List<String>? tags, this.visibility}): _tags = tags;
  factory _CreatePortfolioRequest.fromJson(Map<String, dynamic> json) => _$CreatePortfolioRequestFromJson(json);

@override final  String title;
@override final  String type;
@override final  String? description;
@override final  PortfolioMediaDto media;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? visibility;

/// Create a copy of CreatePortfolioRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePortfolioRequestCopyWith<_CreatePortfolioRequest> get copyWith => __$CreatePortfolioRequestCopyWithImpl<_CreatePortfolioRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePortfolioRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePortfolioRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.media, media) || other.media == media)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.visibility, visibility) || other.visibility == visibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,type,description,media,const DeepCollectionEquality().hash(_tags),visibility);

@override
String toString() {
  return 'CreatePortfolioRequest(title: $title, type: $type, description: $description, media: $media, tags: $tags, visibility: $visibility)';
}


}

/// @nodoc
abstract mixin class _$CreatePortfolioRequestCopyWith<$Res> implements $CreatePortfolioRequestCopyWith<$Res> {
  factory _$CreatePortfolioRequestCopyWith(_CreatePortfolioRequest value, $Res Function(_CreatePortfolioRequest) _then) = __$CreatePortfolioRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String type, String? description, PortfolioMediaDto media, List<String>? tags, String? visibility
});


@override $PortfolioMediaDtoCopyWith<$Res> get media;

}
/// @nodoc
class __$CreatePortfolioRequestCopyWithImpl<$Res>
    implements _$CreatePortfolioRequestCopyWith<$Res> {
  __$CreatePortfolioRequestCopyWithImpl(this._self, this._then);

  final _CreatePortfolioRequest _self;
  final $Res Function(_CreatePortfolioRequest) _then;

/// Create a copy of CreatePortfolioRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? type = null,Object? description = freezed,Object? media = null,Object? tags = freezed,Object? visibility = freezed,}) {
  return _then(_CreatePortfolioRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as PortfolioMediaDto,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CreatePortfolioRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PortfolioMediaDtoCopyWith<$Res> get media {
  
  return $PortfolioMediaDtoCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}

// dart format on
