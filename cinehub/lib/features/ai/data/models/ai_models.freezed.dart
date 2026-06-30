// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerateScriptRequest {

 String get projectId; String get format; String get prompt; String? get genre; String? get tone; String get length; List<ScriptCharacterInput>? get characters; String? get additionalContext; String? get provider;
/// Create a copy of GenerateScriptRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerateScriptRequestCopyWith<GenerateScriptRequest> get copyWith => _$GenerateScriptRequestCopyWithImpl<GenerateScriptRequest>(this as GenerateScriptRequest, _$identity);

  /// Serializes this GenerateScriptRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerateScriptRequest&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.format, format) || other.format == format)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.length, length) || other.length == length)&&const DeepCollectionEquality().equals(other.characters, characters)&&(identical(other.additionalContext, additionalContext) || other.additionalContext == additionalContext)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,format,prompt,genre,tone,length,const DeepCollectionEquality().hash(characters),additionalContext,provider);

@override
String toString() {
  return 'GenerateScriptRequest(projectId: $projectId, format: $format, prompt: $prompt, genre: $genre, tone: $tone, length: $length, characters: $characters, additionalContext: $additionalContext, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $GenerateScriptRequestCopyWith<$Res>  {
  factory $GenerateScriptRequestCopyWith(GenerateScriptRequest value, $Res Function(GenerateScriptRequest) _then) = _$GenerateScriptRequestCopyWithImpl;
@useResult
$Res call({
 String projectId, String format, String prompt, String? genre, String? tone, String length, List<ScriptCharacterInput>? characters, String? additionalContext, String? provider
});




}
/// @nodoc
class _$GenerateScriptRequestCopyWithImpl<$Res>
    implements $GenerateScriptRequestCopyWith<$Res> {
  _$GenerateScriptRequestCopyWithImpl(this._self, this._then);

  final GenerateScriptRequest _self;
  final $Res Function(GenerateScriptRequest) _then;

/// Create a copy of GenerateScriptRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? format = null,Object? prompt = null,Object? genre = freezed,Object? tone = freezed,Object? length = null,Object? characters = freezed,Object? additionalContext = freezed,Object? provider = freezed,}) {
  return _then(_self.copyWith(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,tone: freezed == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as String?,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String,characters: freezed == characters ? _self.characters : characters // ignore: cast_nullable_to_non_nullable
as List<ScriptCharacterInput>?,additionalContext: freezed == additionalContext ? _self.additionalContext : additionalContext // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerateScriptRequest].
extension GenerateScriptRequestPatterns on GenerateScriptRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerateScriptRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerateScriptRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerateScriptRequest value)  $default,){
final _that = this;
switch (_that) {
case _GenerateScriptRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerateScriptRequest value)?  $default,){
final _that = this;
switch (_that) {
case _GenerateScriptRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectId,  String format,  String prompt,  String? genre,  String? tone,  String length,  List<ScriptCharacterInput>? characters,  String? additionalContext,  String? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerateScriptRequest() when $default != null:
return $default(_that.projectId,_that.format,_that.prompt,_that.genre,_that.tone,_that.length,_that.characters,_that.additionalContext,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectId,  String format,  String prompt,  String? genre,  String? tone,  String length,  List<ScriptCharacterInput>? characters,  String? additionalContext,  String? provider)  $default,) {final _that = this;
switch (_that) {
case _GenerateScriptRequest():
return $default(_that.projectId,_that.format,_that.prompt,_that.genre,_that.tone,_that.length,_that.characters,_that.additionalContext,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectId,  String format,  String prompt,  String? genre,  String? tone,  String length,  List<ScriptCharacterInput>? characters,  String? additionalContext,  String? provider)?  $default,) {final _that = this;
switch (_that) {
case _GenerateScriptRequest() when $default != null:
return $default(_that.projectId,_that.format,_that.prompt,_that.genre,_that.tone,_that.length,_that.characters,_that.additionalContext,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenerateScriptRequest implements GenerateScriptRequest {
  const _GenerateScriptRequest({required this.projectId, required this.format, required this.prompt, this.genre, this.tone, this.length = 'medium', final  List<ScriptCharacterInput>? characters, this.additionalContext, this.provider}): _characters = characters;
  factory _GenerateScriptRequest.fromJson(Map<String, dynamic> json) => _$GenerateScriptRequestFromJson(json);

@override final  String projectId;
@override final  String format;
@override final  String prompt;
@override final  String? genre;
@override final  String? tone;
@override@JsonKey() final  String length;
 final  List<ScriptCharacterInput>? _characters;
@override List<ScriptCharacterInput>? get characters {
  final value = _characters;
  if (value == null) return null;
  if (_characters is EqualUnmodifiableListView) return _characters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? additionalContext;
@override final  String? provider;

/// Create a copy of GenerateScriptRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerateScriptRequestCopyWith<_GenerateScriptRequest> get copyWith => __$GenerateScriptRequestCopyWithImpl<_GenerateScriptRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerateScriptRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateScriptRequest&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.format, format) || other.format == format)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.length, length) || other.length == length)&&const DeepCollectionEquality().equals(other._characters, _characters)&&(identical(other.additionalContext, additionalContext) || other.additionalContext == additionalContext)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,format,prompt,genre,tone,length,const DeepCollectionEquality().hash(_characters),additionalContext,provider);

@override
String toString() {
  return 'GenerateScriptRequest(projectId: $projectId, format: $format, prompt: $prompt, genre: $genre, tone: $tone, length: $length, characters: $characters, additionalContext: $additionalContext, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$GenerateScriptRequestCopyWith<$Res> implements $GenerateScriptRequestCopyWith<$Res> {
  factory _$GenerateScriptRequestCopyWith(_GenerateScriptRequest value, $Res Function(_GenerateScriptRequest) _then) = __$GenerateScriptRequestCopyWithImpl;
@override @useResult
$Res call({
 String projectId, String format, String prompt, String? genre, String? tone, String length, List<ScriptCharacterInput>? characters, String? additionalContext, String? provider
});




}
/// @nodoc
class __$GenerateScriptRequestCopyWithImpl<$Res>
    implements _$GenerateScriptRequestCopyWith<$Res> {
  __$GenerateScriptRequestCopyWithImpl(this._self, this._then);

  final _GenerateScriptRequest _self;
  final $Res Function(_GenerateScriptRequest) _then;

/// Create a copy of GenerateScriptRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? format = null,Object? prompt = null,Object? genre = freezed,Object? tone = freezed,Object? length = null,Object? characters = freezed,Object? additionalContext = freezed,Object? provider = freezed,}) {
  return _then(_GenerateScriptRequest(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,tone: freezed == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as String?,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String,characters: freezed == characters ? _self._characters : characters // ignore: cast_nullable_to_non_nullable
as List<ScriptCharacterInput>?,additionalContext: freezed == additionalContext ? _self.additionalContext : additionalContext // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ScriptCharacterInput {

 String get name; String? get description;
/// Create a copy of ScriptCharacterInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScriptCharacterInputCopyWith<ScriptCharacterInput> get copyWith => _$ScriptCharacterInputCopyWithImpl<ScriptCharacterInput>(this as ScriptCharacterInput, _$identity);

  /// Serializes this ScriptCharacterInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScriptCharacterInput&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'ScriptCharacterInput(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $ScriptCharacterInputCopyWith<$Res>  {
  factory $ScriptCharacterInputCopyWith(ScriptCharacterInput value, $Res Function(ScriptCharacterInput) _then) = _$ScriptCharacterInputCopyWithImpl;
@useResult
$Res call({
 String name, String? description
});




}
/// @nodoc
class _$ScriptCharacterInputCopyWithImpl<$Res>
    implements $ScriptCharacterInputCopyWith<$Res> {
  _$ScriptCharacterInputCopyWithImpl(this._self, this._then);

  final ScriptCharacterInput _self;
  final $Res Function(ScriptCharacterInput) _then;

/// Create a copy of ScriptCharacterInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScriptCharacterInput].
extension ScriptCharacterInputPatterns on ScriptCharacterInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScriptCharacterInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScriptCharacterInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScriptCharacterInput value)  $default,){
final _that = this;
switch (_that) {
case _ScriptCharacterInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScriptCharacterInput value)?  $default,){
final _that = this;
switch (_that) {
case _ScriptCharacterInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScriptCharacterInput() when $default != null:
return $default(_that.name,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description)  $default,) {final _that = this;
switch (_that) {
case _ScriptCharacterInput():
return $default(_that.name,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _ScriptCharacterInput() when $default != null:
return $default(_that.name,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScriptCharacterInput implements ScriptCharacterInput {
  const _ScriptCharacterInput({required this.name, this.description});
  factory _ScriptCharacterInput.fromJson(Map<String, dynamic> json) => _$ScriptCharacterInputFromJson(json);

@override final  String name;
@override final  String? description;

/// Create a copy of ScriptCharacterInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScriptCharacterInputCopyWith<_ScriptCharacterInput> get copyWith => __$ScriptCharacterInputCopyWithImpl<_ScriptCharacterInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScriptCharacterInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScriptCharacterInput&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'ScriptCharacterInput(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ScriptCharacterInputCopyWith<$Res> implements $ScriptCharacterInputCopyWith<$Res> {
  factory _$ScriptCharacterInputCopyWith(_ScriptCharacterInput value, $Res Function(_ScriptCharacterInput) _then) = __$ScriptCharacterInputCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description
});




}
/// @nodoc
class __$ScriptCharacterInputCopyWithImpl<$Res>
    implements _$ScriptCharacterInputCopyWith<$Res> {
  __$ScriptCharacterInputCopyWithImpl(this._self, this._then);

  final _ScriptCharacterInput _self;
  final $Res Function(_ScriptCharacterInput) _then;

/// Create a copy of ScriptCharacterInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,}) {
  return _then(_ScriptCharacterInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EnhanceStoryRequest {

 String get content; String? get logline; String? get genre; List<String>? get focusAreas; String? get provider;
/// Create a copy of EnhanceStoryRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnhanceStoryRequestCopyWith<EnhanceStoryRequest> get copyWith => _$EnhanceStoryRequestCopyWithImpl<EnhanceStoryRequest>(this as EnhanceStoryRequest, _$identity);

  /// Serializes this EnhanceStoryRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnhanceStoryRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.logline, logline) || other.logline == logline)&&(identical(other.genre, genre) || other.genre == genre)&&const DeepCollectionEquality().equals(other.focusAreas, focusAreas)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,logline,genre,const DeepCollectionEquality().hash(focusAreas),provider);

@override
String toString() {
  return 'EnhanceStoryRequest(content: $content, logline: $logline, genre: $genre, focusAreas: $focusAreas, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $EnhanceStoryRequestCopyWith<$Res>  {
  factory $EnhanceStoryRequestCopyWith(EnhanceStoryRequest value, $Res Function(EnhanceStoryRequest) _then) = _$EnhanceStoryRequestCopyWithImpl;
@useResult
$Res call({
 String content, String? logline, String? genre, List<String>? focusAreas, String? provider
});




}
/// @nodoc
class _$EnhanceStoryRequestCopyWithImpl<$Res>
    implements $EnhanceStoryRequestCopyWith<$Res> {
  _$EnhanceStoryRequestCopyWithImpl(this._self, this._then);

  final EnhanceStoryRequest _self;
  final $Res Function(EnhanceStoryRequest) _then;

/// Create a copy of EnhanceStoryRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? logline = freezed,Object? genre = freezed,Object? focusAreas = freezed,Object? provider = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,logline: freezed == logline ? _self.logline : logline // ignore: cast_nullable_to_non_nullable
as String?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,focusAreas: freezed == focusAreas ? _self.focusAreas : focusAreas // ignore: cast_nullable_to_non_nullable
as List<String>?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EnhanceStoryRequest].
extension EnhanceStoryRequestPatterns on EnhanceStoryRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnhanceStoryRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnhanceStoryRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnhanceStoryRequest value)  $default,){
final _that = this;
switch (_that) {
case _EnhanceStoryRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnhanceStoryRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EnhanceStoryRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  String? logline,  String? genre,  List<String>? focusAreas,  String? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnhanceStoryRequest() when $default != null:
return $default(_that.content,_that.logline,_that.genre,_that.focusAreas,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  String? logline,  String? genre,  List<String>? focusAreas,  String? provider)  $default,) {final _that = this;
switch (_that) {
case _EnhanceStoryRequest():
return $default(_that.content,_that.logline,_that.genre,_that.focusAreas,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  String? logline,  String? genre,  List<String>? focusAreas,  String? provider)?  $default,) {final _that = this;
switch (_that) {
case _EnhanceStoryRequest() when $default != null:
return $default(_that.content,_that.logline,_that.genre,_that.focusAreas,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnhanceStoryRequest implements EnhanceStoryRequest {
  const _EnhanceStoryRequest({required this.content, this.logline, this.genre, final  List<String>? focusAreas, this.provider}): _focusAreas = focusAreas;
  factory _EnhanceStoryRequest.fromJson(Map<String, dynamic> json) => _$EnhanceStoryRequestFromJson(json);

@override final  String content;
@override final  String? logline;
@override final  String? genre;
 final  List<String>? _focusAreas;
@override List<String>? get focusAreas {
  final value = _focusAreas;
  if (value == null) return null;
  if (_focusAreas is EqualUnmodifiableListView) return _focusAreas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? provider;

/// Create a copy of EnhanceStoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnhanceStoryRequestCopyWith<_EnhanceStoryRequest> get copyWith => __$EnhanceStoryRequestCopyWithImpl<_EnhanceStoryRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnhanceStoryRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnhanceStoryRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.logline, logline) || other.logline == logline)&&(identical(other.genre, genre) || other.genre == genre)&&const DeepCollectionEquality().equals(other._focusAreas, _focusAreas)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,logline,genre,const DeepCollectionEquality().hash(_focusAreas),provider);

@override
String toString() {
  return 'EnhanceStoryRequest(content: $content, logline: $logline, genre: $genre, focusAreas: $focusAreas, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$EnhanceStoryRequestCopyWith<$Res> implements $EnhanceStoryRequestCopyWith<$Res> {
  factory _$EnhanceStoryRequestCopyWith(_EnhanceStoryRequest value, $Res Function(_EnhanceStoryRequest) _then) = __$EnhanceStoryRequestCopyWithImpl;
@override @useResult
$Res call({
 String content, String? logline, String? genre, List<String>? focusAreas, String? provider
});




}
/// @nodoc
class __$EnhanceStoryRequestCopyWithImpl<$Res>
    implements _$EnhanceStoryRequestCopyWith<$Res> {
  __$EnhanceStoryRequestCopyWithImpl(this._self, this._then);

  final _EnhanceStoryRequest _self;
  final $Res Function(_EnhanceStoryRequest) _then;

/// Create a copy of EnhanceStoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? logline = freezed,Object? genre = freezed,Object? focusAreas = freezed,Object? provider = freezed,}) {
  return _then(_EnhanceStoryRequest(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,logline: freezed == logline ? _self.logline : logline // ignore: cast_nullable_to_non_nullable
as String?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,focusAreas: freezed == focusAreas ? _self._focusAreas : focusAreas // ignore: cast_nullable_to_non_nullable
as List<String>?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AnalyzeGenreRequest {

 String get logline; String? get synopsis; String? get content; String? get provider;
/// Create a copy of AnalyzeGenreRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyzeGenreRequestCopyWith<AnalyzeGenreRequest> get copyWith => _$AnalyzeGenreRequestCopyWithImpl<AnalyzeGenreRequest>(this as AnalyzeGenreRequest, _$identity);

  /// Serializes this AnalyzeGenreRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyzeGenreRequest&&(identical(other.logline, logline) || other.logline == logline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.content, content) || other.content == content)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,logline,synopsis,content,provider);

@override
String toString() {
  return 'AnalyzeGenreRequest(logline: $logline, synopsis: $synopsis, content: $content, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $AnalyzeGenreRequestCopyWith<$Res>  {
  factory $AnalyzeGenreRequestCopyWith(AnalyzeGenreRequest value, $Res Function(AnalyzeGenreRequest) _then) = _$AnalyzeGenreRequestCopyWithImpl;
@useResult
$Res call({
 String logline, String? synopsis, String? content, String? provider
});




}
/// @nodoc
class _$AnalyzeGenreRequestCopyWithImpl<$Res>
    implements $AnalyzeGenreRequestCopyWith<$Res> {
  _$AnalyzeGenreRequestCopyWithImpl(this._self, this._then);

  final AnalyzeGenreRequest _self;
  final $Res Function(AnalyzeGenreRequest) _then;

/// Create a copy of AnalyzeGenreRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logline = null,Object? synopsis = freezed,Object? content = freezed,Object? provider = freezed,}) {
  return _then(_self.copyWith(
logline: null == logline ? _self.logline : logline // ignore: cast_nullable_to_non_nullable
as String,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalyzeGenreRequest].
extension AnalyzeGenreRequestPatterns on AnalyzeGenreRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyzeGenreRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyzeGenreRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyzeGenreRequest value)  $default,){
final _that = this;
switch (_that) {
case _AnalyzeGenreRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyzeGenreRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyzeGenreRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String logline,  String? synopsis,  String? content,  String? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyzeGenreRequest() when $default != null:
return $default(_that.logline,_that.synopsis,_that.content,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String logline,  String? synopsis,  String? content,  String? provider)  $default,) {final _that = this;
switch (_that) {
case _AnalyzeGenreRequest():
return $default(_that.logline,_that.synopsis,_that.content,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String logline,  String? synopsis,  String? content,  String? provider)?  $default,) {final _that = this;
switch (_that) {
case _AnalyzeGenreRequest() when $default != null:
return $default(_that.logline,_that.synopsis,_that.content,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnalyzeGenreRequest implements AnalyzeGenreRequest {
  const _AnalyzeGenreRequest({required this.logline, this.synopsis, this.content, this.provider});
  factory _AnalyzeGenreRequest.fromJson(Map<String, dynamic> json) => _$AnalyzeGenreRequestFromJson(json);

@override final  String logline;
@override final  String? synopsis;
@override final  String? content;
@override final  String? provider;

/// Create a copy of AnalyzeGenreRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyzeGenreRequestCopyWith<_AnalyzeGenreRequest> get copyWith => __$AnalyzeGenreRequestCopyWithImpl<_AnalyzeGenreRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalyzeGenreRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyzeGenreRequest&&(identical(other.logline, logline) || other.logline == logline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.content, content) || other.content == content)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,logline,synopsis,content,provider);

@override
String toString() {
  return 'AnalyzeGenreRequest(logline: $logline, synopsis: $synopsis, content: $content, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$AnalyzeGenreRequestCopyWith<$Res> implements $AnalyzeGenreRequestCopyWith<$Res> {
  factory _$AnalyzeGenreRequestCopyWith(_AnalyzeGenreRequest value, $Res Function(_AnalyzeGenreRequest) _then) = __$AnalyzeGenreRequestCopyWithImpl;
@override @useResult
$Res call({
 String logline, String? synopsis, String? content, String? provider
});




}
/// @nodoc
class __$AnalyzeGenreRequestCopyWithImpl<$Res>
    implements _$AnalyzeGenreRequestCopyWith<$Res> {
  __$AnalyzeGenreRequestCopyWithImpl(this._self, this._then);

  final _AnalyzeGenreRequest _self;
  final $Res Function(_AnalyzeGenreRequest) _then;

/// Create a copy of AnalyzeGenreRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logline = null,Object? synopsis = freezed,Object? content = freezed,Object? provider = freezed,}) {
  return _then(_AnalyzeGenreRequest(
logline: null == logline ? _self.logline : logline // ignore: cast_nullable_to_non_nullable
as String,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EstimateBudgetRequest {

 String get projectType; String? get location; String? get duration; int? get scenes; int? get characters; String? get content; String? get provider;
/// Create a copy of EstimateBudgetRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimateBudgetRequestCopyWith<EstimateBudgetRequest> get copyWith => _$EstimateBudgetRequestCopyWithImpl<EstimateBudgetRequest>(this as EstimateBudgetRequest, _$identity);

  /// Serializes this EstimateBudgetRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimateBudgetRequest&&(identical(other.projectType, projectType) || other.projectType == projectType)&&(identical(other.location, location) || other.location == location)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.scenes, scenes) || other.scenes == scenes)&&(identical(other.characters, characters) || other.characters == characters)&&(identical(other.content, content) || other.content == content)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectType,location,duration,scenes,characters,content,provider);

@override
String toString() {
  return 'EstimateBudgetRequest(projectType: $projectType, location: $location, duration: $duration, scenes: $scenes, characters: $characters, content: $content, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $EstimateBudgetRequestCopyWith<$Res>  {
  factory $EstimateBudgetRequestCopyWith(EstimateBudgetRequest value, $Res Function(EstimateBudgetRequest) _then) = _$EstimateBudgetRequestCopyWithImpl;
@useResult
$Res call({
 String projectType, String? location, String? duration, int? scenes, int? characters, String? content, String? provider
});




}
/// @nodoc
class _$EstimateBudgetRequestCopyWithImpl<$Res>
    implements $EstimateBudgetRequestCopyWith<$Res> {
  _$EstimateBudgetRequestCopyWithImpl(this._self, this._then);

  final EstimateBudgetRequest _self;
  final $Res Function(EstimateBudgetRequest) _then;

/// Create a copy of EstimateBudgetRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectType = null,Object? location = freezed,Object? duration = freezed,Object? scenes = freezed,Object? characters = freezed,Object? content = freezed,Object? provider = freezed,}) {
  return _then(_self.copyWith(
projectType: null == projectType ? _self.projectType : projectType // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,scenes: freezed == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as int?,characters: freezed == characters ? _self.characters : characters // ignore: cast_nullable_to_non_nullable
as int?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimateBudgetRequest].
extension EstimateBudgetRequestPatterns on EstimateBudgetRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimateBudgetRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimateBudgetRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimateBudgetRequest value)  $default,){
final _that = this;
switch (_that) {
case _EstimateBudgetRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimateBudgetRequest value)?  $default,){
final _that = this;
switch (_that) {
case _EstimateBudgetRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectType,  String? location,  String? duration,  int? scenes,  int? characters,  String? content,  String? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimateBudgetRequest() when $default != null:
return $default(_that.projectType,_that.location,_that.duration,_that.scenes,_that.characters,_that.content,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectType,  String? location,  String? duration,  int? scenes,  int? characters,  String? content,  String? provider)  $default,) {final _that = this;
switch (_that) {
case _EstimateBudgetRequest():
return $default(_that.projectType,_that.location,_that.duration,_that.scenes,_that.characters,_that.content,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectType,  String? location,  String? duration,  int? scenes,  int? characters,  String? content,  String? provider)?  $default,) {final _that = this;
switch (_that) {
case _EstimateBudgetRequest() when $default != null:
return $default(_that.projectType,_that.location,_that.duration,_that.scenes,_that.characters,_that.content,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimateBudgetRequest implements EstimateBudgetRequest {
  const _EstimateBudgetRequest({required this.projectType, this.location, this.duration, this.scenes, this.characters, this.content, this.provider});
  factory _EstimateBudgetRequest.fromJson(Map<String, dynamic> json) => _$EstimateBudgetRequestFromJson(json);

@override final  String projectType;
@override final  String? location;
@override final  String? duration;
@override final  int? scenes;
@override final  int? characters;
@override final  String? content;
@override final  String? provider;

/// Create a copy of EstimateBudgetRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimateBudgetRequestCopyWith<_EstimateBudgetRequest> get copyWith => __$EstimateBudgetRequestCopyWithImpl<_EstimateBudgetRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimateBudgetRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimateBudgetRequest&&(identical(other.projectType, projectType) || other.projectType == projectType)&&(identical(other.location, location) || other.location == location)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.scenes, scenes) || other.scenes == scenes)&&(identical(other.characters, characters) || other.characters == characters)&&(identical(other.content, content) || other.content == content)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectType,location,duration,scenes,characters,content,provider);

@override
String toString() {
  return 'EstimateBudgetRequest(projectType: $projectType, location: $location, duration: $duration, scenes: $scenes, characters: $characters, content: $content, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$EstimateBudgetRequestCopyWith<$Res> implements $EstimateBudgetRequestCopyWith<$Res> {
  factory _$EstimateBudgetRequestCopyWith(_EstimateBudgetRequest value, $Res Function(_EstimateBudgetRequest) _then) = __$EstimateBudgetRequestCopyWithImpl;
@override @useResult
$Res call({
 String projectType, String? location, String? duration, int? scenes, int? characters, String? content, String? provider
});




}
/// @nodoc
class __$EstimateBudgetRequestCopyWithImpl<$Res>
    implements _$EstimateBudgetRequestCopyWith<$Res> {
  __$EstimateBudgetRequestCopyWithImpl(this._self, this._then);

  final _EstimateBudgetRequest _self;
  final $Res Function(_EstimateBudgetRequest) _then;

/// Create a copy of EstimateBudgetRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectType = null,Object? location = freezed,Object? duration = freezed,Object? scenes = freezed,Object? characters = freezed,Object? content = freezed,Object? provider = freezed,}) {
  return _then(_EstimateBudgetRequest(
projectType: null == projectType ? _self.projectType : projectType // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,scenes: freezed == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as int?,characters: freezed == characters ? _self.characters : characters // ignore: cast_nullable_to_non_nullable
as int?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RecommendTalentRequest {

 String get projectType; String? get genre; String? get budget; String get scale; String? get requirements; String? get provider;
/// Create a copy of RecommendTalentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecommendTalentRequestCopyWith<RecommendTalentRequest> get copyWith => _$RecommendTalentRequestCopyWithImpl<RecommendTalentRequest>(this as RecommendTalentRequest, _$identity);

  /// Serializes this RecommendTalentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecommendTalentRequest&&(identical(other.projectType, projectType) || other.projectType == projectType)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.requirements, requirements) || other.requirements == requirements)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectType,genre,budget,scale,requirements,provider);

@override
String toString() {
  return 'RecommendTalentRequest(projectType: $projectType, genre: $genre, budget: $budget, scale: $scale, requirements: $requirements, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $RecommendTalentRequestCopyWith<$Res>  {
  factory $RecommendTalentRequestCopyWith(RecommendTalentRequest value, $Res Function(RecommendTalentRequest) _then) = _$RecommendTalentRequestCopyWithImpl;
@useResult
$Res call({
 String projectType, String? genre, String? budget, String scale, String? requirements, String? provider
});




}
/// @nodoc
class _$RecommendTalentRequestCopyWithImpl<$Res>
    implements $RecommendTalentRequestCopyWith<$Res> {
  _$RecommendTalentRequestCopyWithImpl(this._self, this._then);

  final RecommendTalentRequest _self;
  final $Res Function(RecommendTalentRequest) _then;

/// Create a copy of RecommendTalentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectType = null,Object? genre = freezed,Object? budget = freezed,Object? scale = null,Object? requirements = freezed,Object? provider = freezed,}) {
  return _then(_self.copyWith(
projectType: null == projectType ? _self.projectType : projectType // ignore: cast_nullable_to_non_nullable
as String,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as String?,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as String,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecommendTalentRequest].
extension RecommendTalentRequestPatterns on RecommendTalentRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecommendTalentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecommendTalentRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecommendTalentRequest value)  $default,){
final _that = this;
switch (_that) {
case _RecommendTalentRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecommendTalentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RecommendTalentRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectType,  String? genre,  String? budget,  String scale,  String? requirements,  String? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecommendTalentRequest() when $default != null:
return $default(_that.projectType,_that.genre,_that.budget,_that.scale,_that.requirements,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectType,  String? genre,  String? budget,  String scale,  String? requirements,  String? provider)  $default,) {final _that = this;
switch (_that) {
case _RecommendTalentRequest():
return $default(_that.projectType,_that.genre,_that.budget,_that.scale,_that.requirements,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectType,  String? genre,  String? budget,  String scale,  String? requirements,  String? provider)?  $default,) {final _that = this;
switch (_that) {
case _RecommendTalentRequest() when $default != null:
return $default(_that.projectType,_that.genre,_that.budget,_that.scale,_that.requirements,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecommendTalentRequest implements RecommendTalentRequest {
  const _RecommendTalentRequest({required this.projectType, this.genre, this.budget, this.scale = 'independent', this.requirements, this.provider});
  factory _RecommendTalentRequest.fromJson(Map<String, dynamic> json) => _$RecommendTalentRequestFromJson(json);

@override final  String projectType;
@override final  String? genre;
@override final  String? budget;
@override@JsonKey() final  String scale;
@override final  String? requirements;
@override final  String? provider;

/// Create a copy of RecommendTalentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecommendTalentRequestCopyWith<_RecommendTalentRequest> get copyWith => __$RecommendTalentRequestCopyWithImpl<_RecommendTalentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecommendTalentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecommendTalentRequest&&(identical(other.projectType, projectType) || other.projectType == projectType)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.requirements, requirements) || other.requirements == requirements)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectType,genre,budget,scale,requirements,provider);

@override
String toString() {
  return 'RecommendTalentRequest(projectType: $projectType, genre: $genre, budget: $budget, scale: $scale, requirements: $requirements, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$RecommendTalentRequestCopyWith<$Res> implements $RecommendTalentRequestCopyWith<$Res> {
  factory _$RecommendTalentRequestCopyWith(_RecommendTalentRequest value, $Res Function(_RecommendTalentRequest) _then) = __$RecommendTalentRequestCopyWithImpl;
@override @useResult
$Res call({
 String projectType, String? genre, String? budget, String scale, String? requirements, String? provider
});




}
/// @nodoc
class __$RecommendTalentRequestCopyWithImpl<$Res>
    implements _$RecommendTalentRequestCopyWith<$Res> {
  __$RecommendTalentRequestCopyWithImpl(this._self, this._then);

  final _RecommendTalentRequest _self;
  final $Res Function(_RecommendTalentRequest) _then;

/// Create a copy of RecommendTalentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectType = null,Object? genre = freezed,Object? budget = freezed,Object? scale = null,Object? requirements = freezed,Object? provider = freezed,}) {
  return _then(_RecommendTalentRequest(
projectType: null == projectType ? _self.projectType : projectType // ignore: cast_nullable_to_non_nullable
as String,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as String?,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as String,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreativeAssistRequest {

 String get query; String? get projectContext; String? get context; String? get provider;
/// Create a copy of CreativeAssistRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreativeAssistRequestCopyWith<CreativeAssistRequest> get copyWith => _$CreativeAssistRequestCopyWithImpl<CreativeAssistRequest>(this as CreativeAssistRequest, _$identity);

  /// Serializes this CreativeAssistRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreativeAssistRequest&&(identical(other.query, query) || other.query == query)&&(identical(other.projectContext, projectContext) || other.projectContext == projectContext)&&(identical(other.context, context) || other.context == context)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,projectContext,context,provider);

@override
String toString() {
  return 'CreativeAssistRequest(query: $query, projectContext: $projectContext, context: $context, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $CreativeAssistRequestCopyWith<$Res>  {
  factory $CreativeAssistRequestCopyWith(CreativeAssistRequest value, $Res Function(CreativeAssistRequest) _then) = _$CreativeAssistRequestCopyWithImpl;
@useResult
$Res call({
 String query, String? projectContext, String? context, String? provider
});




}
/// @nodoc
class _$CreativeAssistRequestCopyWithImpl<$Res>
    implements $CreativeAssistRequestCopyWith<$Res> {
  _$CreativeAssistRequestCopyWithImpl(this._self, this._then);

  final CreativeAssistRequest _self;
  final $Res Function(CreativeAssistRequest) _then;

/// Create a copy of CreativeAssistRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? projectContext = freezed,Object? context = freezed,Object? provider = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,projectContext: freezed == projectContext ? _self.projectContext : projectContext // ignore: cast_nullable_to_non_nullable
as String?,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreativeAssistRequest].
extension CreativeAssistRequestPatterns on CreativeAssistRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreativeAssistRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreativeAssistRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreativeAssistRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreativeAssistRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreativeAssistRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreativeAssistRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  String? projectContext,  String? context,  String? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreativeAssistRequest() when $default != null:
return $default(_that.query,_that.projectContext,_that.context,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  String? projectContext,  String? context,  String? provider)  $default,) {final _that = this;
switch (_that) {
case _CreativeAssistRequest():
return $default(_that.query,_that.projectContext,_that.context,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  String? projectContext,  String? context,  String? provider)?  $default,) {final _that = this;
switch (_that) {
case _CreativeAssistRequest() when $default != null:
return $default(_that.query,_that.projectContext,_that.context,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreativeAssistRequest implements CreativeAssistRequest {
  const _CreativeAssistRequest({required this.query, this.projectContext, this.context, this.provider});
  factory _CreativeAssistRequest.fromJson(Map<String, dynamic> json) => _$CreativeAssistRequestFromJson(json);

@override final  String query;
@override final  String? projectContext;
@override final  String? context;
@override final  String? provider;

/// Create a copy of CreativeAssistRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreativeAssistRequestCopyWith<_CreativeAssistRequest> get copyWith => __$CreativeAssistRequestCopyWithImpl<_CreativeAssistRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreativeAssistRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreativeAssistRequest&&(identical(other.query, query) || other.query == query)&&(identical(other.projectContext, projectContext) || other.projectContext == projectContext)&&(identical(other.context, context) || other.context == context)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,projectContext,context,provider);

@override
String toString() {
  return 'CreativeAssistRequest(query: $query, projectContext: $projectContext, context: $context, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$CreativeAssistRequestCopyWith<$Res> implements $CreativeAssistRequestCopyWith<$Res> {
  factory _$CreativeAssistRequestCopyWith(_CreativeAssistRequest value, $Res Function(_CreativeAssistRequest) _then) = __$CreativeAssistRequestCopyWithImpl;
@override @useResult
$Res call({
 String query, String? projectContext, String? context, String? provider
});




}
/// @nodoc
class __$CreativeAssistRequestCopyWithImpl<$Res>
    implements _$CreativeAssistRequestCopyWith<$Res> {
  __$CreativeAssistRequestCopyWithImpl(this._self, this._then);

  final _CreativeAssistRequest _self;
  final $Res Function(_CreativeAssistRequest) _then;

/// Create a copy of CreativeAssistRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? projectContext = freezed,Object? context = freezed,Object? provider = freezed,}) {
  return _then(_CreativeAssistRequest(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,projectContext: freezed == projectContext ? _self.projectContext : projectContext // ignore: cast_nullable_to_non_nullable
as String?,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProjectInsightsRequest {

 String get projectId; String? get provider;
/// Create a copy of ProjectInsightsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectInsightsRequestCopyWith<ProjectInsightsRequest> get copyWith => _$ProjectInsightsRequestCopyWithImpl<ProjectInsightsRequest>(this as ProjectInsightsRequest, _$identity);

  /// Serializes this ProjectInsightsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectInsightsRequest&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,provider);

@override
String toString() {
  return 'ProjectInsightsRequest(projectId: $projectId, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $ProjectInsightsRequestCopyWith<$Res>  {
  factory $ProjectInsightsRequestCopyWith(ProjectInsightsRequest value, $Res Function(ProjectInsightsRequest) _then) = _$ProjectInsightsRequestCopyWithImpl;
@useResult
$Res call({
 String projectId, String? provider
});




}
/// @nodoc
class _$ProjectInsightsRequestCopyWithImpl<$Res>
    implements $ProjectInsightsRequestCopyWith<$Res> {
  _$ProjectInsightsRequestCopyWithImpl(this._self, this._then);

  final ProjectInsightsRequest _self;
  final $Res Function(ProjectInsightsRequest) _then;

/// Create a copy of ProjectInsightsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? provider = freezed,}) {
  return _then(_self.copyWith(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectInsightsRequest].
extension ProjectInsightsRequestPatterns on ProjectInsightsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectInsightsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectInsightsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectInsightsRequest value)  $default,){
final _that = this;
switch (_that) {
case _ProjectInsightsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectInsightsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectInsightsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectId,  String? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectInsightsRequest() when $default != null:
return $default(_that.projectId,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectId,  String? provider)  $default,) {final _that = this;
switch (_that) {
case _ProjectInsightsRequest():
return $default(_that.projectId,_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectId,  String? provider)?  $default,) {final _that = this;
switch (_that) {
case _ProjectInsightsRequest() when $default != null:
return $default(_that.projectId,_that.provider);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectInsightsRequest implements ProjectInsightsRequest {
  const _ProjectInsightsRequest({required this.projectId, this.provider});
  factory _ProjectInsightsRequest.fromJson(Map<String, dynamic> json) => _$ProjectInsightsRequestFromJson(json);

@override final  String projectId;
@override final  String? provider;

/// Create a copy of ProjectInsightsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectInsightsRequestCopyWith<_ProjectInsightsRequest> get copyWith => __$ProjectInsightsRequestCopyWithImpl<_ProjectInsightsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectInsightsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectInsightsRequest&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.provider, provider) || other.provider == provider));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,provider);

@override
String toString() {
  return 'ProjectInsightsRequest(projectId: $projectId, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$ProjectInsightsRequestCopyWith<$Res> implements $ProjectInsightsRequestCopyWith<$Res> {
  factory _$ProjectInsightsRequestCopyWith(_ProjectInsightsRequest value, $Res Function(_ProjectInsightsRequest) _then) = __$ProjectInsightsRequestCopyWithImpl;
@override @useResult
$Res call({
 String projectId, String? provider
});




}
/// @nodoc
class __$ProjectInsightsRequestCopyWithImpl<$Res>
    implements _$ProjectInsightsRequestCopyWith<$Res> {
  __$ProjectInsightsRequestCopyWithImpl(this._self, this._then);

  final _ProjectInsightsRequest _self;
  final $Res Function(_ProjectInsightsRequest) _then;

/// Create a copy of ProjectInsightsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? provider = freezed,}) {
  return _then(_ProjectInsightsRequest(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ScriptDto {

 String get id; String get title; String get format; String? get status; String? get content; String? get logline; String? get synopsis; bool? get aiGenerated; AiMetadataDto? get aiMetadata; int? get version; int? get wordCount; int? get pageCount; int? get estimatedDuration; String? get project; String? get author; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of ScriptDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScriptDtoCopyWith<ScriptDto> get copyWith => _$ScriptDtoCopyWithImpl<ScriptDto>(this as ScriptDto, _$identity);

  /// Serializes this ScriptDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScriptDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.content, content) || other.content == content)&&(identical(other.logline, logline) || other.logline == logline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.aiGenerated, aiGenerated) || other.aiGenerated == aiGenerated)&&(identical(other.aiMetadata, aiMetadata) || other.aiMetadata == aiMetadata)&&(identical(other.version, version) || other.version == version)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&(identical(other.project, project) || other.project == project)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,format,status,content,logline,synopsis,aiGenerated,aiMetadata,version,wordCount,pageCount,estimatedDuration,project,author,createdAt,updatedAt);

@override
String toString() {
  return 'ScriptDto(id: $id, title: $title, format: $format, status: $status, content: $content, logline: $logline, synopsis: $synopsis, aiGenerated: $aiGenerated, aiMetadata: $aiMetadata, version: $version, wordCount: $wordCount, pageCount: $pageCount, estimatedDuration: $estimatedDuration, project: $project, author: $author, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ScriptDtoCopyWith<$Res>  {
  factory $ScriptDtoCopyWith(ScriptDto value, $Res Function(ScriptDto) _then) = _$ScriptDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String format, String? status, String? content, String? logline, String? synopsis, bool? aiGenerated, AiMetadataDto? aiMetadata, int? version, int? wordCount, int? pageCount, int? estimatedDuration, String? project, String? author, DateTime? createdAt, DateTime? updatedAt
});


$AiMetadataDtoCopyWith<$Res>? get aiMetadata;

}
/// @nodoc
class _$ScriptDtoCopyWithImpl<$Res>
    implements $ScriptDtoCopyWith<$Res> {
  _$ScriptDtoCopyWithImpl(this._self, this._then);

  final ScriptDto _self;
  final $Res Function(ScriptDto) _then;

/// Create a copy of ScriptDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? format = null,Object? status = freezed,Object? content = freezed,Object? logline = freezed,Object? synopsis = freezed,Object? aiGenerated = freezed,Object? aiMetadata = freezed,Object? version = freezed,Object? wordCount = freezed,Object? pageCount = freezed,Object? estimatedDuration = freezed,Object? project = freezed,Object? author = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,logline: freezed == logline ? _self.logline : logline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,aiGenerated: freezed == aiGenerated ? _self.aiGenerated : aiGenerated // ignore: cast_nullable_to_non_nullable
as bool?,aiMetadata: freezed == aiMetadata ? _self.aiMetadata : aiMetadata // ignore: cast_nullable_to_non_nullable
as AiMetadataDto?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,estimatedDuration: freezed == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int?,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ScriptDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiMetadataDtoCopyWith<$Res>? get aiMetadata {
    if (_self.aiMetadata == null) {
    return null;
  }

  return $AiMetadataDtoCopyWith<$Res>(_self.aiMetadata!, (value) {
    return _then(_self.copyWith(aiMetadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScriptDto].
extension ScriptDtoPatterns on ScriptDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScriptDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScriptDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScriptDto value)  $default,){
final _that = this;
switch (_that) {
case _ScriptDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScriptDto value)?  $default,){
final _that = this;
switch (_that) {
case _ScriptDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String format,  String? status,  String? content,  String? logline,  String? synopsis,  bool? aiGenerated,  AiMetadataDto? aiMetadata,  int? version,  int? wordCount,  int? pageCount,  int? estimatedDuration,  String? project,  String? author,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScriptDto() when $default != null:
return $default(_that.id,_that.title,_that.format,_that.status,_that.content,_that.logline,_that.synopsis,_that.aiGenerated,_that.aiMetadata,_that.version,_that.wordCount,_that.pageCount,_that.estimatedDuration,_that.project,_that.author,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String format,  String? status,  String? content,  String? logline,  String? synopsis,  bool? aiGenerated,  AiMetadataDto? aiMetadata,  int? version,  int? wordCount,  int? pageCount,  int? estimatedDuration,  String? project,  String? author,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ScriptDto():
return $default(_that.id,_that.title,_that.format,_that.status,_that.content,_that.logline,_that.synopsis,_that.aiGenerated,_that.aiMetadata,_that.version,_that.wordCount,_that.pageCount,_that.estimatedDuration,_that.project,_that.author,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String format,  String? status,  String? content,  String? logline,  String? synopsis,  bool? aiGenerated,  AiMetadataDto? aiMetadata,  int? version,  int? wordCount,  int? pageCount,  int? estimatedDuration,  String? project,  String? author,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ScriptDto() when $default != null:
return $default(_that.id,_that.title,_that.format,_that.status,_that.content,_that.logline,_that.synopsis,_that.aiGenerated,_that.aiMetadata,_that.version,_that.wordCount,_that.pageCount,_that.estimatedDuration,_that.project,_that.author,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScriptDto implements ScriptDto {
  const _ScriptDto({required this.id, required this.title, required this.format, this.status, this.content, this.logline, this.synopsis, this.aiGenerated, this.aiMetadata, this.version, this.wordCount, this.pageCount, this.estimatedDuration, this.project, this.author, this.createdAt, this.updatedAt});
  factory _ScriptDto.fromJson(Map<String, dynamic> json) => _$ScriptDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String format;
@override final  String? status;
@override final  String? content;
@override final  String? logline;
@override final  String? synopsis;
@override final  bool? aiGenerated;
@override final  AiMetadataDto? aiMetadata;
@override final  int? version;
@override final  int? wordCount;
@override final  int? pageCount;
@override final  int? estimatedDuration;
@override final  String? project;
@override final  String? author;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of ScriptDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScriptDtoCopyWith<_ScriptDto> get copyWith => __$ScriptDtoCopyWithImpl<_ScriptDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScriptDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScriptDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.content, content) || other.content == content)&&(identical(other.logline, logline) || other.logline == logline)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&(identical(other.aiGenerated, aiGenerated) || other.aiGenerated == aiGenerated)&&(identical(other.aiMetadata, aiMetadata) || other.aiMetadata == aiMetadata)&&(identical(other.version, version) || other.version == version)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&(identical(other.project, project) || other.project == project)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,format,status,content,logline,synopsis,aiGenerated,aiMetadata,version,wordCount,pageCount,estimatedDuration,project,author,createdAt,updatedAt);

@override
String toString() {
  return 'ScriptDto(id: $id, title: $title, format: $format, status: $status, content: $content, logline: $logline, synopsis: $synopsis, aiGenerated: $aiGenerated, aiMetadata: $aiMetadata, version: $version, wordCount: $wordCount, pageCount: $pageCount, estimatedDuration: $estimatedDuration, project: $project, author: $author, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ScriptDtoCopyWith<$Res> implements $ScriptDtoCopyWith<$Res> {
  factory _$ScriptDtoCopyWith(_ScriptDto value, $Res Function(_ScriptDto) _then) = __$ScriptDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String format, String? status, String? content, String? logline, String? synopsis, bool? aiGenerated, AiMetadataDto? aiMetadata, int? version, int? wordCount, int? pageCount, int? estimatedDuration, String? project, String? author, DateTime? createdAt, DateTime? updatedAt
});


@override $AiMetadataDtoCopyWith<$Res>? get aiMetadata;

}
/// @nodoc
class __$ScriptDtoCopyWithImpl<$Res>
    implements _$ScriptDtoCopyWith<$Res> {
  __$ScriptDtoCopyWithImpl(this._self, this._then);

  final _ScriptDto _self;
  final $Res Function(_ScriptDto) _then;

/// Create a copy of ScriptDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? format = null,Object? status = freezed,Object? content = freezed,Object? logline = freezed,Object? synopsis = freezed,Object? aiGenerated = freezed,Object? aiMetadata = freezed,Object? version = freezed,Object? wordCount = freezed,Object? pageCount = freezed,Object? estimatedDuration = freezed,Object? project = freezed,Object? author = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ScriptDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,logline: freezed == logline ? _self.logline : logline // ignore: cast_nullable_to_non_nullable
as String?,synopsis: freezed == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as String?,aiGenerated: freezed == aiGenerated ? _self.aiGenerated : aiGenerated // ignore: cast_nullable_to_non_nullable
as bool?,aiMetadata: freezed == aiMetadata ? _self.aiMetadata : aiMetadata // ignore: cast_nullable_to_non_nullable
as AiMetadataDto?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,estimatedDuration: freezed == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int?,project: freezed == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ScriptDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiMetadataDtoCopyWith<$Res>? get aiMetadata {
    if (_self.aiMetadata == null) {
    return null;
  }

  return $AiMetadataDtoCopyWith<$Res>(_self.aiMetadata!, (value) {
    return _then(_self.copyWith(aiMetadata: value));
  });
}
}


/// @nodoc
mixin _$AiMetadataDto {

 String? get provider; String? get model; int? get tokensUsed; int? get generationTimeMs; DateTime? get generatedAt;
/// Create a copy of AiMetadataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiMetadataDtoCopyWith<AiMetadataDto> get copyWith => _$AiMetadataDtoCopyWithImpl<AiMetadataDto>(this as AiMetadataDto, _$identity);

  /// Serializes this AiMetadataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiMetadataDto&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.tokensUsed, tokensUsed) || other.tokensUsed == tokensUsed)&&(identical(other.generationTimeMs, generationTimeMs) || other.generationTimeMs == generationTimeMs)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,model,tokensUsed,generationTimeMs,generatedAt);

@override
String toString() {
  return 'AiMetadataDto(provider: $provider, model: $model, tokensUsed: $tokensUsed, generationTimeMs: $generationTimeMs, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $AiMetadataDtoCopyWith<$Res>  {
  factory $AiMetadataDtoCopyWith(AiMetadataDto value, $Res Function(AiMetadataDto) _then) = _$AiMetadataDtoCopyWithImpl;
@useResult
$Res call({
 String? provider, String? model, int? tokensUsed, int? generationTimeMs, DateTime? generatedAt
});




}
/// @nodoc
class _$AiMetadataDtoCopyWithImpl<$Res>
    implements $AiMetadataDtoCopyWith<$Res> {
  _$AiMetadataDtoCopyWithImpl(this._self, this._then);

  final AiMetadataDto _self;
  final $Res Function(AiMetadataDto) _then;

/// Create a copy of AiMetadataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = freezed,Object? model = freezed,Object? tokensUsed = freezed,Object? generationTimeMs = freezed,Object? generatedAt = freezed,}) {
  return _then(_self.copyWith(
provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,tokensUsed: freezed == tokensUsed ? _self.tokensUsed : tokensUsed // ignore: cast_nullable_to_non_nullable
as int?,generationTimeMs: freezed == generationTimeMs ? _self.generationTimeMs : generationTimeMs // ignore: cast_nullable_to_non_nullable
as int?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiMetadataDto].
extension AiMetadataDtoPatterns on AiMetadataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiMetadataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiMetadataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiMetadataDto value)  $default,){
final _that = this;
switch (_that) {
case _AiMetadataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiMetadataDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiMetadataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? provider,  String? model,  int? tokensUsed,  int? generationTimeMs,  DateTime? generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiMetadataDto() when $default != null:
return $default(_that.provider,_that.model,_that.tokensUsed,_that.generationTimeMs,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? provider,  String? model,  int? tokensUsed,  int? generationTimeMs,  DateTime? generatedAt)  $default,) {final _that = this;
switch (_that) {
case _AiMetadataDto():
return $default(_that.provider,_that.model,_that.tokensUsed,_that.generationTimeMs,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? provider,  String? model,  int? tokensUsed,  int? generationTimeMs,  DateTime? generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AiMetadataDto() when $default != null:
return $default(_that.provider,_that.model,_that.tokensUsed,_that.generationTimeMs,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiMetadataDto implements AiMetadataDto {
  const _AiMetadataDto({this.provider, this.model, this.tokensUsed, this.generationTimeMs, this.generatedAt});
  factory _AiMetadataDto.fromJson(Map<String, dynamic> json) => _$AiMetadataDtoFromJson(json);

@override final  String? provider;
@override final  String? model;
@override final  int? tokensUsed;
@override final  int? generationTimeMs;
@override final  DateTime? generatedAt;

/// Create a copy of AiMetadataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiMetadataDtoCopyWith<_AiMetadataDto> get copyWith => __$AiMetadataDtoCopyWithImpl<_AiMetadataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiMetadataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiMetadataDto&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.tokensUsed, tokensUsed) || other.tokensUsed == tokensUsed)&&(identical(other.generationTimeMs, generationTimeMs) || other.generationTimeMs == generationTimeMs)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,model,tokensUsed,generationTimeMs,generatedAt);

@override
String toString() {
  return 'AiMetadataDto(provider: $provider, model: $model, tokensUsed: $tokensUsed, generationTimeMs: $generationTimeMs, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$AiMetadataDtoCopyWith<$Res> implements $AiMetadataDtoCopyWith<$Res> {
  factory _$AiMetadataDtoCopyWith(_AiMetadataDto value, $Res Function(_AiMetadataDto) _then) = __$AiMetadataDtoCopyWithImpl;
@override @useResult
$Res call({
 String? provider, String? model, int? tokensUsed, int? generationTimeMs, DateTime? generatedAt
});




}
/// @nodoc
class __$AiMetadataDtoCopyWithImpl<$Res>
    implements _$AiMetadataDtoCopyWith<$Res> {
  __$AiMetadataDtoCopyWithImpl(this._self, this._then);

  final _AiMetadataDto _self;
  final $Res Function(_AiMetadataDto) _then;

/// Create a copy of AiMetadataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = freezed,Object? model = freezed,Object? tokensUsed = freezed,Object? generationTimeMs = freezed,Object? generatedAt = freezed,}) {
  return _then(_AiMetadataDto(
provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,tokensUsed: freezed == tokensUsed ? _self.tokensUsed : tokensUsed // ignore: cast_nullable_to_non_nullable
as int?,generationTimeMs: freezed == generationTimeMs ? _self.generationTimeMs : generationTimeMs // ignore: cast_nullable_to_non_nullable
as int?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$AiResponseEnvelope<T> {

 T get data; AiResponseMeta get meta;
/// Create a copy of AiResponseEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResponseEnvelopeCopyWith<T, AiResponseEnvelope<T>> get copyWith => _$AiResponseEnvelopeCopyWithImpl<T, AiResponseEnvelope<T>>(this as AiResponseEnvelope<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResponseEnvelope<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.meta, meta) || other.meta == meta));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),meta);

@override
String toString() {
  return 'AiResponseEnvelope<$T>(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $AiResponseEnvelopeCopyWith<T,$Res>  {
  factory $AiResponseEnvelopeCopyWith(AiResponseEnvelope<T> value, $Res Function(AiResponseEnvelope<T>) _then) = _$AiResponseEnvelopeCopyWithImpl;
@useResult
$Res call({
 T data, AiResponseMeta meta
});


$AiResponseMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$AiResponseEnvelopeCopyWithImpl<T,$Res>
    implements $AiResponseEnvelopeCopyWith<T, $Res> {
  _$AiResponseEnvelopeCopyWithImpl(this._self, this._then);

  final AiResponseEnvelope<T> _self;
  final $Res Function(AiResponseEnvelope<T>) _then;

/// Create a copy of AiResponseEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? meta = null,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as AiResponseMeta,
  ));
}
/// Create a copy of AiResponseEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiResponseMetaCopyWith<$Res> get meta {
  
  return $AiResponseMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiResponseEnvelope].
extension AiResponseEnvelopePatterns<T> on AiResponseEnvelope<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiResponseEnvelope<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiResponseEnvelope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiResponseEnvelope<T> value)  $default,){
final _that = this;
switch (_that) {
case _AiResponseEnvelope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiResponseEnvelope<T> value)?  $default,){
final _that = this;
switch (_that) {
case _AiResponseEnvelope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T data,  AiResponseMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiResponseEnvelope() when $default != null:
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T data,  AiResponseMeta meta)  $default,) {final _that = this;
switch (_that) {
case _AiResponseEnvelope():
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T data,  AiResponseMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _AiResponseEnvelope() when $default != null:
return $default(_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc


class _AiResponseEnvelope<T> implements AiResponseEnvelope<T> {
  const _AiResponseEnvelope({required this.data, required this.meta});
  

@override final  T data;
@override final  AiResponseMeta meta;

/// Create a copy of AiResponseEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiResponseEnvelopeCopyWith<T, _AiResponseEnvelope<T>> get copyWith => __$AiResponseEnvelopeCopyWithImpl<T, _AiResponseEnvelope<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiResponseEnvelope<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.meta, meta) || other.meta == meta));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),meta);

@override
String toString() {
  return 'AiResponseEnvelope<$T>(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$AiResponseEnvelopeCopyWith<T,$Res> implements $AiResponseEnvelopeCopyWith<T, $Res> {
  factory _$AiResponseEnvelopeCopyWith(_AiResponseEnvelope<T> value, $Res Function(_AiResponseEnvelope<T>) _then) = __$AiResponseEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 T data, AiResponseMeta meta
});


@override $AiResponseMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$AiResponseEnvelopeCopyWithImpl<T,$Res>
    implements _$AiResponseEnvelopeCopyWith<T, $Res> {
  __$AiResponseEnvelopeCopyWithImpl(this._self, this._then);

  final _AiResponseEnvelope<T> _self;
  final $Res Function(_AiResponseEnvelope<T>) _then;

/// Create a copy of AiResponseEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? meta = null,}) {
  return _then(_AiResponseEnvelope<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as AiResponseMeta,
  ));
}

/// Create a copy of AiResponseEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiResponseMetaCopyWith<$Res> get meta {
  
  return $AiResponseMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$AiResponseMeta {

 String? get templateId; String? get provider; String? get model; int? get tokensUsed; int? get generationTimeMs; bool get cached; List<String>? get warnings;
/// Create a copy of AiResponseMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResponseMetaCopyWith<AiResponseMeta> get copyWith => _$AiResponseMetaCopyWithImpl<AiResponseMeta>(this as AiResponseMeta, _$identity);

  /// Serializes this AiResponseMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResponseMeta&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.tokensUsed, tokensUsed) || other.tokensUsed == tokensUsed)&&(identical(other.generationTimeMs, generationTimeMs) || other.generationTimeMs == generationTimeMs)&&(identical(other.cached, cached) || other.cached == cached)&&const DeepCollectionEquality().equals(other.warnings, warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,templateId,provider,model,tokensUsed,generationTimeMs,cached,const DeepCollectionEquality().hash(warnings));

@override
String toString() {
  return 'AiResponseMeta(templateId: $templateId, provider: $provider, model: $model, tokensUsed: $tokensUsed, generationTimeMs: $generationTimeMs, cached: $cached, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class $AiResponseMetaCopyWith<$Res>  {
  factory $AiResponseMetaCopyWith(AiResponseMeta value, $Res Function(AiResponseMeta) _then) = _$AiResponseMetaCopyWithImpl;
@useResult
$Res call({
 String? templateId, String? provider, String? model, int? tokensUsed, int? generationTimeMs, bool cached, List<String>? warnings
});




}
/// @nodoc
class _$AiResponseMetaCopyWithImpl<$Res>
    implements $AiResponseMetaCopyWith<$Res> {
  _$AiResponseMetaCopyWithImpl(this._self, this._then);

  final AiResponseMeta _self;
  final $Res Function(AiResponseMeta) _then;

/// Create a copy of AiResponseMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? templateId = freezed,Object? provider = freezed,Object? model = freezed,Object? tokensUsed = freezed,Object? generationTimeMs = freezed,Object? cached = null,Object? warnings = freezed,}) {
  return _then(_self.copyWith(
templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,tokensUsed: freezed == tokensUsed ? _self.tokensUsed : tokensUsed // ignore: cast_nullable_to_non_nullable
as int?,generationTimeMs: freezed == generationTimeMs ? _self.generationTimeMs : generationTimeMs // ignore: cast_nullable_to_non_nullable
as int?,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,warnings: freezed == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiResponseMeta].
extension AiResponseMetaPatterns on AiResponseMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiResponseMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiResponseMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiResponseMeta value)  $default,){
final _that = this;
switch (_that) {
case _AiResponseMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiResponseMeta value)?  $default,){
final _that = this;
switch (_that) {
case _AiResponseMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? templateId,  String? provider,  String? model,  int? tokensUsed,  int? generationTimeMs,  bool cached,  List<String>? warnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiResponseMeta() when $default != null:
return $default(_that.templateId,_that.provider,_that.model,_that.tokensUsed,_that.generationTimeMs,_that.cached,_that.warnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? templateId,  String? provider,  String? model,  int? tokensUsed,  int? generationTimeMs,  bool cached,  List<String>? warnings)  $default,) {final _that = this;
switch (_that) {
case _AiResponseMeta():
return $default(_that.templateId,_that.provider,_that.model,_that.tokensUsed,_that.generationTimeMs,_that.cached,_that.warnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? templateId,  String? provider,  String? model,  int? tokensUsed,  int? generationTimeMs,  bool cached,  List<String>? warnings)?  $default,) {final _that = this;
switch (_that) {
case _AiResponseMeta() when $default != null:
return $default(_that.templateId,_that.provider,_that.model,_that.tokensUsed,_that.generationTimeMs,_that.cached,_that.warnings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiResponseMeta implements AiResponseMeta {
  const _AiResponseMeta({this.templateId, this.provider, this.model, this.tokensUsed, this.generationTimeMs, this.cached = false, final  List<String>? warnings}): _warnings = warnings;
  factory _AiResponseMeta.fromJson(Map<String, dynamic> json) => _$AiResponseMetaFromJson(json);

@override final  String? templateId;
@override final  String? provider;
@override final  String? model;
@override final  int? tokensUsed;
@override final  int? generationTimeMs;
@override@JsonKey() final  bool cached;
 final  List<String>? _warnings;
@override List<String>? get warnings {
  final value = _warnings;
  if (value == null) return null;
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AiResponseMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiResponseMetaCopyWith<_AiResponseMeta> get copyWith => __$AiResponseMetaCopyWithImpl<_AiResponseMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiResponseMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiResponseMeta&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.tokensUsed, tokensUsed) || other.tokensUsed == tokensUsed)&&(identical(other.generationTimeMs, generationTimeMs) || other.generationTimeMs == generationTimeMs)&&(identical(other.cached, cached) || other.cached == cached)&&const DeepCollectionEquality().equals(other._warnings, _warnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,templateId,provider,model,tokensUsed,generationTimeMs,cached,const DeepCollectionEquality().hash(_warnings));

@override
String toString() {
  return 'AiResponseMeta(templateId: $templateId, provider: $provider, model: $model, tokensUsed: $tokensUsed, generationTimeMs: $generationTimeMs, cached: $cached, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class _$AiResponseMetaCopyWith<$Res> implements $AiResponseMetaCopyWith<$Res> {
  factory _$AiResponseMetaCopyWith(_AiResponseMeta value, $Res Function(_AiResponseMeta) _then) = __$AiResponseMetaCopyWithImpl;
@override @useResult
$Res call({
 String? templateId, String? provider, String? model, int? tokensUsed, int? generationTimeMs, bool cached, List<String>? warnings
});




}
/// @nodoc
class __$AiResponseMetaCopyWithImpl<$Res>
    implements _$AiResponseMetaCopyWith<$Res> {
  __$AiResponseMetaCopyWithImpl(this._self, this._then);

  final _AiResponseMeta _self;
  final $Res Function(_AiResponseMeta) _then;

/// Create a copy of AiResponseMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? templateId = freezed,Object? provider = freezed,Object? model = freezed,Object? tokensUsed = freezed,Object? generationTimeMs = freezed,Object? cached = null,Object? warnings = freezed,}) {
  return _then(_AiResponseMeta(
templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,tokensUsed: freezed == tokensUsed ? _self.tokensUsed : tokensUsed // ignore: cast_nullable_to_non_nullable
as int?,generationTimeMs: freezed == generationTimeMs ? _self.generationTimeMs : generationTimeMs // ignore: cast_nullable_to_non_nullable
as int?,cached: null == cached ? _self.cached : cached // ignore: cast_nullable_to_non_nullable
as bool,warnings: freezed == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$StoryEnhancementDto {

 int? get overallScore; List<String>? get strengths; List<String>? get weaknesses; List<EnhancementSuggestionDto>? get suggestions; String? get enhancedLogline; Map<String, dynamic>? get paceAnalysis; List<CharacterNoteDto>? get characterNotes;
/// Create a copy of StoryEnhancementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryEnhancementDtoCopyWith<StoryEnhancementDto> get copyWith => _$StoryEnhancementDtoCopyWithImpl<StoryEnhancementDto>(this as StoryEnhancementDto, _$identity);

  /// Serializes this StoryEnhancementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryEnhancementDto&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&const DeepCollectionEquality().equals(other.strengths, strengths)&&const DeepCollectionEquality().equals(other.weaknesses, weaknesses)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.enhancedLogline, enhancedLogline) || other.enhancedLogline == enhancedLogline)&&const DeepCollectionEquality().equals(other.paceAnalysis, paceAnalysis)&&const DeepCollectionEquality().equals(other.characterNotes, characterNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallScore,const DeepCollectionEquality().hash(strengths),const DeepCollectionEquality().hash(weaknesses),const DeepCollectionEquality().hash(suggestions),enhancedLogline,const DeepCollectionEquality().hash(paceAnalysis),const DeepCollectionEquality().hash(characterNotes));

@override
String toString() {
  return 'StoryEnhancementDto(overallScore: $overallScore, strengths: $strengths, weaknesses: $weaknesses, suggestions: $suggestions, enhancedLogline: $enhancedLogline, paceAnalysis: $paceAnalysis, characterNotes: $characterNotes)';
}


}

/// @nodoc
abstract mixin class $StoryEnhancementDtoCopyWith<$Res>  {
  factory $StoryEnhancementDtoCopyWith(StoryEnhancementDto value, $Res Function(StoryEnhancementDto) _then) = _$StoryEnhancementDtoCopyWithImpl;
@useResult
$Res call({
 int? overallScore, List<String>? strengths, List<String>? weaknesses, List<EnhancementSuggestionDto>? suggestions, String? enhancedLogline, Map<String, dynamic>? paceAnalysis, List<CharacterNoteDto>? characterNotes
});




}
/// @nodoc
class _$StoryEnhancementDtoCopyWithImpl<$Res>
    implements $StoryEnhancementDtoCopyWith<$Res> {
  _$StoryEnhancementDtoCopyWithImpl(this._self, this._then);

  final StoryEnhancementDto _self;
  final $Res Function(StoryEnhancementDto) _then;

/// Create a copy of StoryEnhancementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overallScore = freezed,Object? strengths = freezed,Object? weaknesses = freezed,Object? suggestions = freezed,Object? enhancedLogline = freezed,Object? paceAnalysis = freezed,Object? characterNotes = freezed,}) {
  return _then(_self.copyWith(
overallScore: freezed == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as int?,strengths: freezed == strengths ? _self.strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>?,weaknesses: freezed == weaknesses ? _self.weaknesses : weaknesses // ignore: cast_nullable_to_non_nullable
as List<String>?,suggestions: freezed == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<EnhancementSuggestionDto>?,enhancedLogline: freezed == enhancedLogline ? _self.enhancedLogline : enhancedLogline // ignore: cast_nullable_to_non_nullable
as String?,paceAnalysis: freezed == paceAnalysis ? _self.paceAnalysis : paceAnalysis // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,characterNotes: freezed == characterNotes ? _self.characterNotes : characterNotes // ignore: cast_nullable_to_non_nullable
as List<CharacterNoteDto>?,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryEnhancementDto].
extension StoryEnhancementDtoPatterns on StoryEnhancementDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryEnhancementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryEnhancementDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryEnhancementDto value)  $default,){
final _that = this;
switch (_that) {
case _StoryEnhancementDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryEnhancementDto value)?  $default,){
final _that = this;
switch (_that) {
case _StoryEnhancementDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? overallScore,  List<String>? strengths,  List<String>? weaknesses,  List<EnhancementSuggestionDto>? suggestions,  String? enhancedLogline,  Map<String, dynamic>? paceAnalysis,  List<CharacterNoteDto>? characterNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryEnhancementDto() when $default != null:
return $default(_that.overallScore,_that.strengths,_that.weaknesses,_that.suggestions,_that.enhancedLogline,_that.paceAnalysis,_that.characterNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? overallScore,  List<String>? strengths,  List<String>? weaknesses,  List<EnhancementSuggestionDto>? suggestions,  String? enhancedLogline,  Map<String, dynamic>? paceAnalysis,  List<CharacterNoteDto>? characterNotes)  $default,) {final _that = this;
switch (_that) {
case _StoryEnhancementDto():
return $default(_that.overallScore,_that.strengths,_that.weaknesses,_that.suggestions,_that.enhancedLogline,_that.paceAnalysis,_that.characterNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? overallScore,  List<String>? strengths,  List<String>? weaknesses,  List<EnhancementSuggestionDto>? suggestions,  String? enhancedLogline,  Map<String, dynamic>? paceAnalysis,  List<CharacterNoteDto>? characterNotes)?  $default,) {final _that = this;
switch (_that) {
case _StoryEnhancementDto() when $default != null:
return $default(_that.overallScore,_that.strengths,_that.weaknesses,_that.suggestions,_that.enhancedLogline,_that.paceAnalysis,_that.characterNotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryEnhancementDto implements StoryEnhancementDto {
  const _StoryEnhancementDto({this.overallScore, final  List<String>? strengths, final  List<String>? weaknesses, final  List<EnhancementSuggestionDto>? suggestions, this.enhancedLogline, final  Map<String, dynamic>? paceAnalysis, final  List<CharacterNoteDto>? characterNotes}): _strengths = strengths,_weaknesses = weaknesses,_suggestions = suggestions,_paceAnalysis = paceAnalysis,_characterNotes = characterNotes;
  factory _StoryEnhancementDto.fromJson(Map<String, dynamic> json) => _$StoryEnhancementDtoFromJson(json);

@override final  int? overallScore;
 final  List<String>? _strengths;
@override List<String>? get strengths {
  final value = _strengths;
  if (value == null) return null;
  if (_strengths is EqualUnmodifiableListView) return _strengths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _weaknesses;
@override List<String>? get weaknesses {
  final value = _weaknesses;
  if (value == null) return null;
  if (_weaknesses is EqualUnmodifiableListView) return _weaknesses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EnhancementSuggestionDto>? _suggestions;
@override List<EnhancementSuggestionDto>? get suggestions {
  final value = _suggestions;
  if (value == null) return null;
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? enhancedLogline;
 final  Map<String, dynamic>? _paceAnalysis;
@override Map<String, dynamic>? get paceAnalysis {
  final value = _paceAnalysis;
  if (value == null) return null;
  if (_paceAnalysis is EqualUnmodifiableMapView) return _paceAnalysis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<CharacterNoteDto>? _characterNotes;
@override List<CharacterNoteDto>? get characterNotes {
  final value = _characterNotes;
  if (value == null) return null;
  if (_characterNotes is EqualUnmodifiableListView) return _characterNotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of StoryEnhancementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryEnhancementDtoCopyWith<_StoryEnhancementDto> get copyWith => __$StoryEnhancementDtoCopyWithImpl<_StoryEnhancementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryEnhancementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryEnhancementDto&&(identical(other.overallScore, overallScore) || other.overallScore == overallScore)&&const DeepCollectionEquality().equals(other._strengths, _strengths)&&const DeepCollectionEquality().equals(other._weaknesses, _weaknesses)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.enhancedLogline, enhancedLogline) || other.enhancedLogline == enhancedLogline)&&const DeepCollectionEquality().equals(other._paceAnalysis, _paceAnalysis)&&const DeepCollectionEquality().equals(other._characterNotes, _characterNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallScore,const DeepCollectionEquality().hash(_strengths),const DeepCollectionEquality().hash(_weaknesses),const DeepCollectionEquality().hash(_suggestions),enhancedLogline,const DeepCollectionEquality().hash(_paceAnalysis),const DeepCollectionEquality().hash(_characterNotes));

@override
String toString() {
  return 'StoryEnhancementDto(overallScore: $overallScore, strengths: $strengths, weaknesses: $weaknesses, suggestions: $suggestions, enhancedLogline: $enhancedLogline, paceAnalysis: $paceAnalysis, characterNotes: $characterNotes)';
}


}

/// @nodoc
abstract mixin class _$StoryEnhancementDtoCopyWith<$Res> implements $StoryEnhancementDtoCopyWith<$Res> {
  factory _$StoryEnhancementDtoCopyWith(_StoryEnhancementDto value, $Res Function(_StoryEnhancementDto) _then) = __$StoryEnhancementDtoCopyWithImpl;
@override @useResult
$Res call({
 int? overallScore, List<String>? strengths, List<String>? weaknesses, List<EnhancementSuggestionDto>? suggestions, String? enhancedLogline, Map<String, dynamic>? paceAnalysis, List<CharacterNoteDto>? characterNotes
});




}
/// @nodoc
class __$StoryEnhancementDtoCopyWithImpl<$Res>
    implements _$StoryEnhancementDtoCopyWith<$Res> {
  __$StoryEnhancementDtoCopyWithImpl(this._self, this._then);

  final _StoryEnhancementDto _self;
  final $Res Function(_StoryEnhancementDto) _then;

/// Create a copy of StoryEnhancementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overallScore = freezed,Object? strengths = freezed,Object? weaknesses = freezed,Object? suggestions = freezed,Object? enhancedLogline = freezed,Object? paceAnalysis = freezed,Object? characterNotes = freezed,}) {
  return _then(_StoryEnhancementDto(
overallScore: freezed == overallScore ? _self.overallScore : overallScore // ignore: cast_nullable_to_non_nullable
as int?,strengths: freezed == strengths ? _self._strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>?,weaknesses: freezed == weaknesses ? _self._weaknesses : weaknesses // ignore: cast_nullable_to_non_nullable
as List<String>?,suggestions: freezed == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<EnhancementSuggestionDto>?,enhancedLogline: freezed == enhancedLogline ? _self.enhancedLogline : enhancedLogline // ignore: cast_nullable_to_non_nullable
as String?,paceAnalysis: freezed == paceAnalysis ? _self._paceAnalysis : paceAnalysis // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,characterNotes: freezed == characterNotes ? _self._characterNotes : characterNotes // ignore: cast_nullable_to_non_nullable
as List<CharacterNoteDto>?,
  ));
}


}


/// @nodoc
mixin _$EnhancementSuggestionDto {

 String? get area; String? get severity; String? get description; List<int>? get affectedScenes; String? get example;
/// Create a copy of EnhancementSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnhancementSuggestionDtoCopyWith<EnhancementSuggestionDto> get copyWith => _$EnhancementSuggestionDtoCopyWithImpl<EnhancementSuggestionDto>(this as EnhancementSuggestionDto, _$identity);

  /// Serializes this EnhancementSuggestionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnhancementSuggestionDto&&(identical(other.area, area) || other.area == area)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.affectedScenes, affectedScenes)&&(identical(other.example, example) || other.example == example));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area,severity,description,const DeepCollectionEquality().hash(affectedScenes),example);

@override
String toString() {
  return 'EnhancementSuggestionDto(area: $area, severity: $severity, description: $description, affectedScenes: $affectedScenes, example: $example)';
}


}

/// @nodoc
abstract mixin class $EnhancementSuggestionDtoCopyWith<$Res>  {
  factory $EnhancementSuggestionDtoCopyWith(EnhancementSuggestionDto value, $Res Function(EnhancementSuggestionDto) _then) = _$EnhancementSuggestionDtoCopyWithImpl;
@useResult
$Res call({
 String? area, String? severity, String? description, List<int>? affectedScenes, String? example
});




}
/// @nodoc
class _$EnhancementSuggestionDtoCopyWithImpl<$Res>
    implements $EnhancementSuggestionDtoCopyWith<$Res> {
  _$EnhancementSuggestionDtoCopyWithImpl(this._self, this._then);

  final EnhancementSuggestionDto _self;
  final $Res Function(EnhancementSuggestionDto) _then;

/// Create a copy of EnhancementSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? area = freezed,Object? severity = freezed,Object? description = freezed,Object? affectedScenes = freezed,Object? example = freezed,}) {
  return _then(_self.copyWith(
area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,affectedScenes: freezed == affectedScenes ? _self.affectedScenes : affectedScenes // ignore: cast_nullable_to_non_nullable
as List<int>?,example: freezed == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EnhancementSuggestionDto].
extension EnhancementSuggestionDtoPatterns on EnhancementSuggestionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnhancementSuggestionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnhancementSuggestionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnhancementSuggestionDto value)  $default,){
final _that = this;
switch (_that) {
case _EnhancementSuggestionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnhancementSuggestionDto value)?  $default,){
final _that = this;
switch (_that) {
case _EnhancementSuggestionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? area,  String? severity,  String? description,  List<int>? affectedScenes,  String? example)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnhancementSuggestionDto() when $default != null:
return $default(_that.area,_that.severity,_that.description,_that.affectedScenes,_that.example);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? area,  String? severity,  String? description,  List<int>? affectedScenes,  String? example)  $default,) {final _that = this;
switch (_that) {
case _EnhancementSuggestionDto():
return $default(_that.area,_that.severity,_that.description,_that.affectedScenes,_that.example);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? area,  String? severity,  String? description,  List<int>? affectedScenes,  String? example)?  $default,) {final _that = this;
switch (_that) {
case _EnhancementSuggestionDto() when $default != null:
return $default(_that.area,_that.severity,_that.description,_that.affectedScenes,_that.example);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnhancementSuggestionDto implements EnhancementSuggestionDto {
  const _EnhancementSuggestionDto({this.area, this.severity, this.description, final  List<int>? affectedScenes, this.example}): _affectedScenes = affectedScenes;
  factory _EnhancementSuggestionDto.fromJson(Map<String, dynamic> json) => _$EnhancementSuggestionDtoFromJson(json);

@override final  String? area;
@override final  String? severity;
@override final  String? description;
 final  List<int>? _affectedScenes;
@override List<int>? get affectedScenes {
  final value = _affectedScenes;
  if (value == null) return null;
  if (_affectedScenes is EqualUnmodifiableListView) return _affectedScenes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? example;

/// Create a copy of EnhancementSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnhancementSuggestionDtoCopyWith<_EnhancementSuggestionDto> get copyWith => __$EnhancementSuggestionDtoCopyWithImpl<_EnhancementSuggestionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnhancementSuggestionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnhancementSuggestionDto&&(identical(other.area, area) || other.area == area)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._affectedScenes, _affectedScenes)&&(identical(other.example, example) || other.example == example));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,area,severity,description,const DeepCollectionEquality().hash(_affectedScenes),example);

@override
String toString() {
  return 'EnhancementSuggestionDto(area: $area, severity: $severity, description: $description, affectedScenes: $affectedScenes, example: $example)';
}


}

/// @nodoc
abstract mixin class _$EnhancementSuggestionDtoCopyWith<$Res> implements $EnhancementSuggestionDtoCopyWith<$Res> {
  factory _$EnhancementSuggestionDtoCopyWith(_EnhancementSuggestionDto value, $Res Function(_EnhancementSuggestionDto) _then) = __$EnhancementSuggestionDtoCopyWithImpl;
@override @useResult
$Res call({
 String? area, String? severity, String? description, List<int>? affectedScenes, String? example
});




}
/// @nodoc
class __$EnhancementSuggestionDtoCopyWithImpl<$Res>
    implements _$EnhancementSuggestionDtoCopyWith<$Res> {
  __$EnhancementSuggestionDtoCopyWithImpl(this._self, this._then);

  final _EnhancementSuggestionDto _self;
  final $Res Function(_EnhancementSuggestionDto) _then;

/// Create a copy of EnhancementSuggestionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? area = freezed,Object? severity = freezed,Object? description = freezed,Object? affectedScenes = freezed,Object? example = freezed,}) {
  return _then(_EnhancementSuggestionDto(
area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,affectedScenes: freezed == affectedScenes ? _self._affectedScenes : affectedScenes // ignore: cast_nullable_to_non_nullable
as List<int>?,example: freezed == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CharacterNoteDto {

 String? get character; String? get note;
/// Create a copy of CharacterNoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharacterNoteDtoCopyWith<CharacterNoteDto> get copyWith => _$CharacterNoteDtoCopyWithImpl<CharacterNoteDto>(this as CharacterNoteDto, _$identity);

  /// Serializes this CharacterNoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterNoteDto&&(identical(other.character, character) || other.character == character)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,character,note);

@override
String toString() {
  return 'CharacterNoteDto(character: $character, note: $note)';
}


}

/// @nodoc
abstract mixin class $CharacterNoteDtoCopyWith<$Res>  {
  factory $CharacterNoteDtoCopyWith(CharacterNoteDto value, $Res Function(CharacterNoteDto) _then) = _$CharacterNoteDtoCopyWithImpl;
@useResult
$Res call({
 String? character, String? note
});




}
/// @nodoc
class _$CharacterNoteDtoCopyWithImpl<$Res>
    implements $CharacterNoteDtoCopyWith<$Res> {
  _$CharacterNoteDtoCopyWithImpl(this._self, this._then);

  final CharacterNoteDto _self;
  final $Res Function(CharacterNoteDto) _then;

/// Create a copy of CharacterNoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? character = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
character: freezed == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CharacterNoteDto].
extension CharacterNoteDtoPatterns on CharacterNoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CharacterNoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CharacterNoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CharacterNoteDto value)  $default,){
final _that = this;
switch (_that) {
case _CharacterNoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CharacterNoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _CharacterNoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? character,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CharacterNoteDto() when $default != null:
return $default(_that.character,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? character,  String? note)  $default,) {final _that = this;
switch (_that) {
case _CharacterNoteDto():
return $default(_that.character,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? character,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _CharacterNoteDto() when $default != null:
return $default(_that.character,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CharacterNoteDto implements CharacterNoteDto {
  const _CharacterNoteDto({this.character, this.note});
  factory _CharacterNoteDto.fromJson(Map<String, dynamic> json) => _$CharacterNoteDtoFromJson(json);

@override final  String? character;
@override final  String? note;

/// Create a copy of CharacterNoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CharacterNoteDtoCopyWith<_CharacterNoteDto> get copyWith => __$CharacterNoteDtoCopyWithImpl<_CharacterNoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CharacterNoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CharacterNoteDto&&(identical(other.character, character) || other.character == character)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,character,note);

@override
String toString() {
  return 'CharacterNoteDto(character: $character, note: $note)';
}


}

/// @nodoc
abstract mixin class _$CharacterNoteDtoCopyWith<$Res> implements $CharacterNoteDtoCopyWith<$Res> {
  factory _$CharacterNoteDtoCopyWith(_CharacterNoteDto value, $Res Function(_CharacterNoteDto) _then) = __$CharacterNoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String? character, String? note
});




}
/// @nodoc
class __$CharacterNoteDtoCopyWithImpl<$Res>
    implements _$CharacterNoteDtoCopyWith<$Res> {
  __$CharacterNoteDtoCopyWithImpl(this._self, this._then);

  final _CharacterNoteDto _self;
  final $Res Function(_CharacterNoteDto) _then;

/// Create a copy of CharacterNoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? character = freezed,Object? note = freezed,}) {
  return _then(_CharacterNoteDto(
character: freezed == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GenreAnalysisDto {

 String? get primaryGenre; List<String>? get subGenres; double? get genreConfidence; List<GenreElementDto>? get genreElements; List<ComparableFilmDto>? get comparableFilms; Map<String, dynamic>? get audienceProfile; Map<String, dynamic>? get marketViability; Map<String, dynamic>? get toneAnalysis;
/// Create a copy of GenreAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenreAnalysisDtoCopyWith<GenreAnalysisDto> get copyWith => _$GenreAnalysisDtoCopyWithImpl<GenreAnalysisDto>(this as GenreAnalysisDto, _$identity);

  /// Serializes this GenreAnalysisDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenreAnalysisDto&&(identical(other.primaryGenre, primaryGenre) || other.primaryGenre == primaryGenre)&&const DeepCollectionEquality().equals(other.subGenres, subGenres)&&(identical(other.genreConfidence, genreConfidence) || other.genreConfidence == genreConfidence)&&const DeepCollectionEquality().equals(other.genreElements, genreElements)&&const DeepCollectionEquality().equals(other.comparableFilms, comparableFilms)&&const DeepCollectionEquality().equals(other.audienceProfile, audienceProfile)&&const DeepCollectionEquality().equals(other.marketViability, marketViability)&&const DeepCollectionEquality().equals(other.toneAnalysis, toneAnalysis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primaryGenre,const DeepCollectionEquality().hash(subGenres),genreConfidence,const DeepCollectionEquality().hash(genreElements),const DeepCollectionEquality().hash(comparableFilms),const DeepCollectionEquality().hash(audienceProfile),const DeepCollectionEquality().hash(marketViability),const DeepCollectionEquality().hash(toneAnalysis));

@override
String toString() {
  return 'GenreAnalysisDto(primaryGenre: $primaryGenre, subGenres: $subGenres, genreConfidence: $genreConfidence, genreElements: $genreElements, comparableFilms: $comparableFilms, audienceProfile: $audienceProfile, marketViability: $marketViability, toneAnalysis: $toneAnalysis)';
}


}

/// @nodoc
abstract mixin class $GenreAnalysisDtoCopyWith<$Res>  {
  factory $GenreAnalysisDtoCopyWith(GenreAnalysisDto value, $Res Function(GenreAnalysisDto) _then) = _$GenreAnalysisDtoCopyWithImpl;
@useResult
$Res call({
 String? primaryGenre, List<String>? subGenres, double? genreConfidence, List<GenreElementDto>? genreElements, List<ComparableFilmDto>? comparableFilms, Map<String, dynamic>? audienceProfile, Map<String, dynamic>? marketViability, Map<String, dynamic>? toneAnalysis
});




}
/// @nodoc
class _$GenreAnalysisDtoCopyWithImpl<$Res>
    implements $GenreAnalysisDtoCopyWith<$Res> {
  _$GenreAnalysisDtoCopyWithImpl(this._self, this._then);

  final GenreAnalysisDto _self;
  final $Res Function(GenreAnalysisDto) _then;

/// Create a copy of GenreAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primaryGenre = freezed,Object? subGenres = freezed,Object? genreConfidence = freezed,Object? genreElements = freezed,Object? comparableFilms = freezed,Object? audienceProfile = freezed,Object? marketViability = freezed,Object? toneAnalysis = freezed,}) {
  return _then(_self.copyWith(
primaryGenre: freezed == primaryGenre ? _self.primaryGenre : primaryGenre // ignore: cast_nullable_to_non_nullable
as String?,subGenres: freezed == subGenres ? _self.subGenres : subGenres // ignore: cast_nullable_to_non_nullable
as List<String>?,genreConfidence: freezed == genreConfidence ? _self.genreConfidence : genreConfidence // ignore: cast_nullable_to_non_nullable
as double?,genreElements: freezed == genreElements ? _self.genreElements : genreElements // ignore: cast_nullable_to_non_nullable
as List<GenreElementDto>?,comparableFilms: freezed == comparableFilms ? _self.comparableFilms : comparableFilms // ignore: cast_nullable_to_non_nullable
as List<ComparableFilmDto>?,audienceProfile: freezed == audienceProfile ? _self.audienceProfile : audienceProfile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,marketViability: freezed == marketViability ? _self.marketViability : marketViability // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,toneAnalysis: freezed == toneAnalysis ? _self.toneAnalysis : toneAnalysis // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenreAnalysisDto].
extension GenreAnalysisDtoPatterns on GenreAnalysisDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenreAnalysisDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenreAnalysisDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenreAnalysisDto value)  $default,){
final _that = this;
switch (_that) {
case _GenreAnalysisDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenreAnalysisDto value)?  $default,){
final _that = this;
switch (_that) {
case _GenreAnalysisDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? primaryGenre,  List<String>? subGenres,  double? genreConfidence,  List<GenreElementDto>? genreElements,  List<ComparableFilmDto>? comparableFilms,  Map<String, dynamic>? audienceProfile,  Map<String, dynamic>? marketViability,  Map<String, dynamic>? toneAnalysis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenreAnalysisDto() when $default != null:
return $default(_that.primaryGenre,_that.subGenres,_that.genreConfidence,_that.genreElements,_that.comparableFilms,_that.audienceProfile,_that.marketViability,_that.toneAnalysis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? primaryGenre,  List<String>? subGenres,  double? genreConfidence,  List<GenreElementDto>? genreElements,  List<ComparableFilmDto>? comparableFilms,  Map<String, dynamic>? audienceProfile,  Map<String, dynamic>? marketViability,  Map<String, dynamic>? toneAnalysis)  $default,) {final _that = this;
switch (_that) {
case _GenreAnalysisDto():
return $default(_that.primaryGenre,_that.subGenres,_that.genreConfidence,_that.genreElements,_that.comparableFilms,_that.audienceProfile,_that.marketViability,_that.toneAnalysis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? primaryGenre,  List<String>? subGenres,  double? genreConfidence,  List<GenreElementDto>? genreElements,  List<ComparableFilmDto>? comparableFilms,  Map<String, dynamic>? audienceProfile,  Map<String, dynamic>? marketViability,  Map<String, dynamic>? toneAnalysis)?  $default,) {final _that = this;
switch (_that) {
case _GenreAnalysisDto() when $default != null:
return $default(_that.primaryGenre,_that.subGenres,_that.genreConfidence,_that.genreElements,_that.comparableFilms,_that.audienceProfile,_that.marketViability,_that.toneAnalysis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenreAnalysisDto implements GenreAnalysisDto {
  const _GenreAnalysisDto({this.primaryGenre, final  List<String>? subGenres, this.genreConfidence, final  List<GenreElementDto>? genreElements, final  List<ComparableFilmDto>? comparableFilms, final  Map<String, dynamic>? audienceProfile, final  Map<String, dynamic>? marketViability, final  Map<String, dynamic>? toneAnalysis}): _subGenres = subGenres,_genreElements = genreElements,_comparableFilms = comparableFilms,_audienceProfile = audienceProfile,_marketViability = marketViability,_toneAnalysis = toneAnalysis;
  factory _GenreAnalysisDto.fromJson(Map<String, dynamic> json) => _$GenreAnalysisDtoFromJson(json);

@override final  String? primaryGenre;
 final  List<String>? _subGenres;
@override List<String>? get subGenres {
  final value = _subGenres;
  if (value == null) return null;
  if (_subGenres is EqualUnmodifiableListView) return _subGenres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  double? genreConfidence;
 final  List<GenreElementDto>? _genreElements;
@override List<GenreElementDto>? get genreElements {
  final value = _genreElements;
  if (value == null) return null;
  if (_genreElements is EqualUnmodifiableListView) return _genreElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ComparableFilmDto>? _comparableFilms;
@override List<ComparableFilmDto>? get comparableFilms {
  final value = _comparableFilms;
  if (value == null) return null;
  if (_comparableFilms is EqualUnmodifiableListView) return _comparableFilms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _audienceProfile;
@override Map<String, dynamic>? get audienceProfile {
  final value = _audienceProfile;
  if (value == null) return null;
  if (_audienceProfile is EqualUnmodifiableMapView) return _audienceProfile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _marketViability;
@override Map<String, dynamic>? get marketViability {
  final value = _marketViability;
  if (value == null) return null;
  if (_marketViability is EqualUnmodifiableMapView) return _marketViability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _toneAnalysis;
@override Map<String, dynamic>? get toneAnalysis {
  final value = _toneAnalysis;
  if (value == null) return null;
  if (_toneAnalysis is EqualUnmodifiableMapView) return _toneAnalysis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of GenreAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenreAnalysisDtoCopyWith<_GenreAnalysisDto> get copyWith => __$GenreAnalysisDtoCopyWithImpl<_GenreAnalysisDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenreAnalysisDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenreAnalysisDto&&(identical(other.primaryGenre, primaryGenre) || other.primaryGenre == primaryGenre)&&const DeepCollectionEquality().equals(other._subGenres, _subGenres)&&(identical(other.genreConfidence, genreConfidence) || other.genreConfidence == genreConfidence)&&const DeepCollectionEquality().equals(other._genreElements, _genreElements)&&const DeepCollectionEquality().equals(other._comparableFilms, _comparableFilms)&&const DeepCollectionEquality().equals(other._audienceProfile, _audienceProfile)&&const DeepCollectionEquality().equals(other._marketViability, _marketViability)&&const DeepCollectionEquality().equals(other._toneAnalysis, _toneAnalysis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primaryGenre,const DeepCollectionEquality().hash(_subGenres),genreConfidence,const DeepCollectionEquality().hash(_genreElements),const DeepCollectionEquality().hash(_comparableFilms),const DeepCollectionEquality().hash(_audienceProfile),const DeepCollectionEquality().hash(_marketViability),const DeepCollectionEquality().hash(_toneAnalysis));

@override
String toString() {
  return 'GenreAnalysisDto(primaryGenre: $primaryGenre, subGenres: $subGenres, genreConfidence: $genreConfidence, genreElements: $genreElements, comparableFilms: $comparableFilms, audienceProfile: $audienceProfile, marketViability: $marketViability, toneAnalysis: $toneAnalysis)';
}


}

/// @nodoc
abstract mixin class _$GenreAnalysisDtoCopyWith<$Res> implements $GenreAnalysisDtoCopyWith<$Res> {
  factory _$GenreAnalysisDtoCopyWith(_GenreAnalysisDto value, $Res Function(_GenreAnalysisDto) _then) = __$GenreAnalysisDtoCopyWithImpl;
@override @useResult
$Res call({
 String? primaryGenre, List<String>? subGenres, double? genreConfidence, List<GenreElementDto>? genreElements, List<ComparableFilmDto>? comparableFilms, Map<String, dynamic>? audienceProfile, Map<String, dynamic>? marketViability, Map<String, dynamic>? toneAnalysis
});




}
/// @nodoc
class __$GenreAnalysisDtoCopyWithImpl<$Res>
    implements _$GenreAnalysisDtoCopyWith<$Res> {
  __$GenreAnalysisDtoCopyWithImpl(this._self, this._then);

  final _GenreAnalysisDto _self;
  final $Res Function(_GenreAnalysisDto) _then;

/// Create a copy of GenreAnalysisDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primaryGenre = freezed,Object? subGenres = freezed,Object? genreConfidence = freezed,Object? genreElements = freezed,Object? comparableFilms = freezed,Object? audienceProfile = freezed,Object? marketViability = freezed,Object? toneAnalysis = freezed,}) {
  return _then(_GenreAnalysisDto(
primaryGenre: freezed == primaryGenre ? _self.primaryGenre : primaryGenre // ignore: cast_nullable_to_non_nullable
as String?,subGenres: freezed == subGenres ? _self._subGenres : subGenres // ignore: cast_nullable_to_non_nullable
as List<String>?,genreConfidence: freezed == genreConfidence ? _self.genreConfidence : genreConfidence // ignore: cast_nullable_to_non_nullable
as double?,genreElements: freezed == genreElements ? _self._genreElements : genreElements // ignore: cast_nullable_to_non_nullable
as List<GenreElementDto>?,comparableFilms: freezed == comparableFilms ? _self._comparableFilms : comparableFilms // ignore: cast_nullable_to_non_nullable
as List<ComparableFilmDto>?,audienceProfile: freezed == audienceProfile ? _self._audienceProfile : audienceProfile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,marketViability: freezed == marketViability ? _self._marketViability : marketViability // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,toneAnalysis: freezed == toneAnalysis ? _self._toneAnalysis : toneAnalysis // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$GenreElementDto {

 String? get element; bool? get present; String? get strength;
/// Create a copy of GenreElementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenreElementDtoCopyWith<GenreElementDto> get copyWith => _$GenreElementDtoCopyWithImpl<GenreElementDto>(this as GenreElementDto, _$identity);

  /// Serializes this GenreElementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenreElementDto&&(identical(other.element, element) || other.element == element)&&(identical(other.present, present) || other.present == present)&&(identical(other.strength, strength) || other.strength == strength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,element,present,strength);

@override
String toString() {
  return 'GenreElementDto(element: $element, present: $present, strength: $strength)';
}


}

/// @nodoc
abstract mixin class $GenreElementDtoCopyWith<$Res>  {
  factory $GenreElementDtoCopyWith(GenreElementDto value, $Res Function(GenreElementDto) _then) = _$GenreElementDtoCopyWithImpl;
@useResult
$Res call({
 String? element, bool? present, String? strength
});




}
/// @nodoc
class _$GenreElementDtoCopyWithImpl<$Res>
    implements $GenreElementDtoCopyWith<$Res> {
  _$GenreElementDtoCopyWithImpl(this._self, this._then);

  final GenreElementDto _self;
  final $Res Function(GenreElementDto) _then;

/// Create a copy of GenreElementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? element = freezed,Object? present = freezed,Object? strength = freezed,}) {
  return _then(_self.copyWith(
element: freezed == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String?,present: freezed == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as bool?,strength: freezed == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenreElementDto].
extension GenreElementDtoPatterns on GenreElementDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenreElementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenreElementDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenreElementDto value)  $default,){
final _that = this;
switch (_that) {
case _GenreElementDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenreElementDto value)?  $default,){
final _that = this;
switch (_that) {
case _GenreElementDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? element,  bool? present,  String? strength)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenreElementDto() when $default != null:
return $default(_that.element,_that.present,_that.strength);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? element,  bool? present,  String? strength)  $default,) {final _that = this;
switch (_that) {
case _GenreElementDto():
return $default(_that.element,_that.present,_that.strength);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? element,  bool? present,  String? strength)?  $default,) {final _that = this;
switch (_that) {
case _GenreElementDto() when $default != null:
return $default(_that.element,_that.present,_that.strength);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenreElementDto implements GenreElementDto {
  const _GenreElementDto({this.element, this.present, this.strength});
  factory _GenreElementDto.fromJson(Map<String, dynamic> json) => _$GenreElementDtoFromJson(json);

@override final  String? element;
@override final  bool? present;
@override final  String? strength;

/// Create a copy of GenreElementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenreElementDtoCopyWith<_GenreElementDto> get copyWith => __$GenreElementDtoCopyWithImpl<_GenreElementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenreElementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenreElementDto&&(identical(other.element, element) || other.element == element)&&(identical(other.present, present) || other.present == present)&&(identical(other.strength, strength) || other.strength == strength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,element,present,strength);

@override
String toString() {
  return 'GenreElementDto(element: $element, present: $present, strength: $strength)';
}


}

/// @nodoc
abstract mixin class _$GenreElementDtoCopyWith<$Res> implements $GenreElementDtoCopyWith<$Res> {
  factory _$GenreElementDtoCopyWith(_GenreElementDto value, $Res Function(_GenreElementDto) _then) = __$GenreElementDtoCopyWithImpl;
@override @useResult
$Res call({
 String? element, bool? present, String? strength
});




}
/// @nodoc
class __$GenreElementDtoCopyWithImpl<$Res>
    implements _$GenreElementDtoCopyWith<$Res> {
  __$GenreElementDtoCopyWithImpl(this._self, this._then);

  final _GenreElementDto _self;
  final $Res Function(_GenreElementDto) _then;

/// Create a copy of GenreElementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? element = freezed,Object? present = freezed,Object? strength = freezed,}) {
  return _then(_GenreElementDto(
element: freezed == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String?,present: freezed == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as bool?,strength: freezed == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ComparableFilmDto {

 String? get title; int? get year; double? get similarity; String? get reason;
/// Create a copy of ComparableFilmDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComparableFilmDtoCopyWith<ComparableFilmDto> get copyWith => _$ComparableFilmDtoCopyWithImpl<ComparableFilmDto>(this as ComparableFilmDto, _$identity);

  /// Serializes this ComparableFilmDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComparableFilmDto&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,year,similarity,reason);

@override
String toString() {
  return 'ComparableFilmDto(title: $title, year: $year, similarity: $similarity, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ComparableFilmDtoCopyWith<$Res>  {
  factory $ComparableFilmDtoCopyWith(ComparableFilmDto value, $Res Function(ComparableFilmDto) _then) = _$ComparableFilmDtoCopyWithImpl;
@useResult
$Res call({
 String? title, int? year, double? similarity, String? reason
});




}
/// @nodoc
class _$ComparableFilmDtoCopyWithImpl<$Res>
    implements $ComparableFilmDtoCopyWith<$Res> {
  _$ComparableFilmDtoCopyWithImpl(this._self, this._then);

  final ComparableFilmDto _self;
  final $Res Function(ComparableFilmDto) _then;

/// Create a copy of ComparableFilmDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? year = freezed,Object? similarity = freezed,Object? reason = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,similarity: freezed == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComparableFilmDto].
extension ComparableFilmDtoPatterns on ComparableFilmDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComparableFilmDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComparableFilmDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComparableFilmDto value)  $default,){
final _that = this;
switch (_that) {
case _ComparableFilmDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComparableFilmDto value)?  $default,){
final _that = this;
switch (_that) {
case _ComparableFilmDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  int? year,  double? similarity,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComparableFilmDto() when $default != null:
return $default(_that.title,_that.year,_that.similarity,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  int? year,  double? similarity,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _ComparableFilmDto():
return $default(_that.title,_that.year,_that.similarity,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  int? year,  double? similarity,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _ComparableFilmDto() when $default != null:
return $default(_that.title,_that.year,_that.similarity,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComparableFilmDto implements ComparableFilmDto {
  const _ComparableFilmDto({this.title, this.year, this.similarity, this.reason});
  factory _ComparableFilmDto.fromJson(Map<String, dynamic> json) => _$ComparableFilmDtoFromJson(json);

@override final  String? title;
@override final  int? year;
@override final  double? similarity;
@override final  String? reason;

/// Create a copy of ComparableFilmDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComparableFilmDtoCopyWith<_ComparableFilmDto> get copyWith => __$ComparableFilmDtoCopyWithImpl<_ComparableFilmDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComparableFilmDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComparableFilmDto&&(identical(other.title, title) || other.title == title)&&(identical(other.year, year) || other.year == year)&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,year,similarity,reason);

@override
String toString() {
  return 'ComparableFilmDto(title: $title, year: $year, similarity: $similarity, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$ComparableFilmDtoCopyWith<$Res> implements $ComparableFilmDtoCopyWith<$Res> {
  factory _$ComparableFilmDtoCopyWith(_ComparableFilmDto value, $Res Function(_ComparableFilmDto) _then) = __$ComparableFilmDtoCopyWithImpl;
@override @useResult
$Res call({
 String? title, int? year, double? similarity, String? reason
});




}
/// @nodoc
class __$ComparableFilmDtoCopyWithImpl<$Res>
    implements _$ComparableFilmDtoCopyWith<$Res> {
  __$ComparableFilmDtoCopyWithImpl(this._self, this._then);

  final _ComparableFilmDto _self;
  final $Res Function(_ComparableFilmDto) _then;

/// Create a copy of ComparableFilmDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? year = freezed,Object? similarity = freezed,Object? reason = freezed,}) {
  return _then(_ComparableFilmDto(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,similarity: freezed == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BudgetEstimationDto {

 BudgetTotalDto? get totalEstimate; List<BudgetItemDto>? get breakdown; List<String>? get assumptions; List<String>? get costDrivers; List<String>? get savingOpportunities; Map<String, dynamic>? get productionSchedule; List<BudgetRiskDto>? get riskFactors;
/// Create a copy of BudgetEstimationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetEstimationDtoCopyWith<BudgetEstimationDto> get copyWith => _$BudgetEstimationDtoCopyWithImpl<BudgetEstimationDto>(this as BudgetEstimationDto, _$identity);

  /// Serializes this BudgetEstimationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetEstimationDto&&(identical(other.totalEstimate, totalEstimate) || other.totalEstimate == totalEstimate)&&const DeepCollectionEquality().equals(other.breakdown, breakdown)&&const DeepCollectionEquality().equals(other.assumptions, assumptions)&&const DeepCollectionEquality().equals(other.costDrivers, costDrivers)&&const DeepCollectionEquality().equals(other.savingOpportunities, savingOpportunities)&&const DeepCollectionEquality().equals(other.productionSchedule, productionSchedule)&&const DeepCollectionEquality().equals(other.riskFactors, riskFactors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalEstimate,const DeepCollectionEquality().hash(breakdown),const DeepCollectionEquality().hash(assumptions),const DeepCollectionEquality().hash(costDrivers),const DeepCollectionEquality().hash(savingOpportunities),const DeepCollectionEquality().hash(productionSchedule),const DeepCollectionEquality().hash(riskFactors));

@override
String toString() {
  return 'BudgetEstimationDto(totalEstimate: $totalEstimate, breakdown: $breakdown, assumptions: $assumptions, costDrivers: $costDrivers, savingOpportunities: $savingOpportunities, productionSchedule: $productionSchedule, riskFactors: $riskFactors)';
}


}

/// @nodoc
abstract mixin class $BudgetEstimationDtoCopyWith<$Res>  {
  factory $BudgetEstimationDtoCopyWith(BudgetEstimationDto value, $Res Function(BudgetEstimationDto) _then) = _$BudgetEstimationDtoCopyWithImpl;
@useResult
$Res call({
 BudgetTotalDto? totalEstimate, List<BudgetItemDto>? breakdown, List<String>? assumptions, List<String>? costDrivers, List<String>? savingOpportunities, Map<String, dynamic>? productionSchedule, List<BudgetRiskDto>? riskFactors
});


$BudgetTotalDtoCopyWith<$Res>? get totalEstimate;

}
/// @nodoc
class _$BudgetEstimationDtoCopyWithImpl<$Res>
    implements $BudgetEstimationDtoCopyWith<$Res> {
  _$BudgetEstimationDtoCopyWithImpl(this._self, this._then);

  final BudgetEstimationDto _self;
  final $Res Function(BudgetEstimationDto) _then;

/// Create a copy of BudgetEstimationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalEstimate = freezed,Object? breakdown = freezed,Object? assumptions = freezed,Object? costDrivers = freezed,Object? savingOpportunities = freezed,Object? productionSchedule = freezed,Object? riskFactors = freezed,}) {
  return _then(_self.copyWith(
totalEstimate: freezed == totalEstimate ? _self.totalEstimate : totalEstimate // ignore: cast_nullable_to_non_nullable
as BudgetTotalDto?,breakdown: freezed == breakdown ? _self.breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as List<BudgetItemDto>?,assumptions: freezed == assumptions ? _self.assumptions : assumptions // ignore: cast_nullable_to_non_nullable
as List<String>?,costDrivers: freezed == costDrivers ? _self.costDrivers : costDrivers // ignore: cast_nullable_to_non_nullable
as List<String>?,savingOpportunities: freezed == savingOpportunities ? _self.savingOpportunities : savingOpportunities // ignore: cast_nullable_to_non_nullable
as List<String>?,productionSchedule: freezed == productionSchedule ? _self.productionSchedule : productionSchedule // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,riskFactors: freezed == riskFactors ? _self.riskFactors : riskFactors // ignore: cast_nullable_to_non_nullable
as List<BudgetRiskDto>?,
  ));
}
/// Create a copy of BudgetEstimationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetTotalDtoCopyWith<$Res>? get totalEstimate {
    if (_self.totalEstimate == null) {
    return null;
  }

  return $BudgetTotalDtoCopyWith<$Res>(_self.totalEstimate!, (value) {
    return _then(_self.copyWith(totalEstimate: value));
  });
}
}


/// Adds pattern-matching-related methods to [BudgetEstimationDto].
extension BudgetEstimationDtoPatterns on BudgetEstimationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetEstimationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetEstimationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetEstimationDto value)  $default,){
final _that = this;
switch (_that) {
case _BudgetEstimationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetEstimationDto value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetEstimationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BudgetTotalDto? totalEstimate,  List<BudgetItemDto>? breakdown,  List<String>? assumptions,  List<String>? costDrivers,  List<String>? savingOpportunities,  Map<String, dynamic>? productionSchedule,  List<BudgetRiskDto>? riskFactors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetEstimationDto() when $default != null:
return $default(_that.totalEstimate,_that.breakdown,_that.assumptions,_that.costDrivers,_that.savingOpportunities,_that.productionSchedule,_that.riskFactors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BudgetTotalDto? totalEstimate,  List<BudgetItemDto>? breakdown,  List<String>? assumptions,  List<String>? costDrivers,  List<String>? savingOpportunities,  Map<String, dynamic>? productionSchedule,  List<BudgetRiskDto>? riskFactors)  $default,) {final _that = this;
switch (_that) {
case _BudgetEstimationDto():
return $default(_that.totalEstimate,_that.breakdown,_that.assumptions,_that.costDrivers,_that.savingOpportunities,_that.productionSchedule,_that.riskFactors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BudgetTotalDto? totalEstimate,  List<BudgetItemDto>? breakdown,  List<String>? assumptions,  List<String>? costDrivers,  List<String>? savingOpportunities,  Map<String, dynamic>? productionSchedule,  List<BudgetRiskDto>? riskFactors)?  $default,) {final _that = this;
switch (_that) {
case _BudgetEstimationDto() when $default != null:
return $default(_that.totalEstimate,_that.breakdown,_that.assumptions,_that.costDrivers,_that.savingOpportunities,_that.productionSchedule,_that.riskFactors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetEstimationDto implements BudgetEstimationDto {
  const _BudgetEstimationDto({this.totalEstimate, final  List<BudgetItemDto>? breakdown, final  List<String>? assumptions, final  List<String>? costDrivers, final  List<String>? savingOpportunities, final  Map<String, dynamic>? productionSchedule, final  List<BudgetRiskDto>? riskFactors}): _breakdown = breakdown,_assumptions = assumptions,_costDrivers = costDrivers,_savingOpportunities = savingOpportunities,_productionSchedule = productionSchedule,_riskFactors = riskFactors;
  factory _BudgetEstimationDto.fromJson(Map<String, dynamic> json) => _$BudgetEstimationDtoFromJson(json);

@override final  BudgetTotalDto? totalEstimate;
 final  List<BudgetItemDto>? _breakdown;
@override List<BudgetItemDto>? get breakdown {
  final value = _breakdown;
  if (value == null) return null;
  if (_breakdown is EqualUnmodifiableListView) return _breakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _assumptions;
@override List<String>? get assumptions {
  final value = _assumptions;
  if (value == null) return null;
  if (_assumptions is EqualUnmodifiableListView) return _assumptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _costDrivers;
@override List<String>? get costDrivers {
  final value = _costDrivers;
  if (value == null) return null;
  if (_costDrivers is EqualUnmodifiableListView) return _costDrivers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _savingOpportunities;
@override List<String>? get savingOpportunities {
  final value = _savingOpportunities;
  if (value == null) return null;
  if (_savingOpportunities is EqualUnmodifiableListView) return _savingOpportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _productionSchedule;
@override Map<String, dynamic>? get productionSchedule {
  final value = _productionSchedule;
  if (value == null) return null;
  if (_productionSchedule is EqualUnmodifiableMapView) return _productionSchedule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<BudgetRiskDto>? _riskFactors;
@override List<BudgetRiskDto>? get riskFactors {
  final value = _riskFactors;
  if (value == null) return null;
  if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BudgetEstimationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetEstimationDtoCopyWith<_BudgetEstimationDto> get copyWith => __$BudgetEstimationDtoCopyWithImpl<_BudgetEstimationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetEstimationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetEstimationDto&&(identical(other.totalEstimate, totalEstimate) || other.totalEstimate == totalEstimate)&&const DeepCollectionEquality().equals(other._breakdown, _breakdown)&&const DeepCollectionEquality().equals(other._assumptions, _assumptions)&&const DeepCollectionEquality().equals(other._costDrivers, _costDrivers)&&const DeepCollectionEquality().equals(other._savingOpportunities, _savingOpportunities)&&const DeepCollectionEquality().equals(other._productionSchedule, _productionSchedule)&&const DeepCollectionEquality().equals(other._riskFactors, _riskFactors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalEstimate,const DeepCollectionEquality().hash(_breakdown),const DeepCollectionEquality().hash(_assumptions),const DeepCollectionEquality().hash(_costDrivers),const DeepCollectionEquality().hash(_savingOpportunities),const DeepCollectionEquality().hash(_productionSchedule),const DeepCollectionEquality().hash(_riskFactors));

@override
String toString() {
  return 'BudgetEstimationDto(totalEstimate: $totalEstimate, breakdown: $breakdown, assumptions: $assumptions, costDrivers: $costDrivers, savingOpportunities: $savingOpportunities, productionSchedule: $productionSchedule, riskFactors: $riskFactors)';
}


}

/// @nodoc
abstract mixin class _$BudgetEstimationDtoCopyWith<$Res> implements $BudgetEstimationDtoCopyWith<$Res> {
  factory _$BudgetEstimationDtoCopyWith(_BudgetEstimationDto value, $Res Function(_BudgetEstimationDto) _then) = __$BudgetEstimationDtoCopyWithImpl;
@override @useResult
$Res call({
 BudgetTotalDto? totalEstimate, List<BudgetItemDto>? breakdown, List<String>? assumptions, List<String>? costDrivers, List<String>? savingOpportunities, Map<String, dynamic>? productionSchedule, List<BudgetRiskDto>? riskFactors
});


@override $BudgetTotalDtoCopyWith<$Res>? get totalEstimate;

}
/// @nodoc
class __$BudgetEstimationDtoCopyWithImpl<$Res>
    implements _$BudgetEstimationDtoCopyWith<$Res> {
  __$BudgetEstimationDtoCopyWithImpl(this._self, this._then);

  final _BudgetEstimationDto _self;
  final $Res Function(_BudgetEstimationDto) _then;

/// Create a copy of BudgetEstimationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalEstimate = freezed,Object? breakdown = freezed,Object? assumptions = freezed,Object? costDrivers = freezed,Object? savingOpportunities = freezed,Object? productionSchedule = freezed,Object? riskFactors = freezed,}) {
  return _then(_BudgetEstimationDto(
totalEstimate: freezed == totalEstimate ? _self.totalEstimate : totalEstimate // ignore: cast_nullable_to_non_nullable
as BudgetTotalDto?,breakdown: freezed == breakdown ? _self._breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as List<BudgetItemDto>?,assumptions: freezed == assumptions ? _self._assumptions : assumptions // ignore: cast_nullable_to_non_nullable
as List<String>?,costDrivers: freezed == costDrivers ? _self._costDrivers : costDrivers // ignore: cast_nullable_to_non_nullable
as List<String>?,savingOpportunities: freezed == savingOpportunities ? _self._savingOpportunities : savingOpportunities // ignore: cast_nullable_to_non_nullable
as List<String>?,productionSchedule: freezed == productionSchedule ? _self._productionSchedule : productionSchedule // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,riskFactors: freezed == riskFactors ? _self._riskFactors : riskFactors // ignore: cast_nullable_to_non_nullable
as List<BudgetRiskDto>?,
  ));
}

/// Create a copy of BudgetEstimationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetTotalDtoCopyWith<$Res>? get totalEstimate {
    if (_self.totalEstimate == null) {
    return null;
  }

  return $BudgetTotalDtoCopyWith<$Res>(_self.totalEstimate!, (value) {
    return _then(_self.copyWith(totalEstimate: value));
  });
}
}


/// @nodoc
mixin _$BudgetTotalDto {

 double? get low; double? get mid; double? get high; String get currency;
/// Create a copy of BudgetTotalDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetTotalDtoCopyWith<BudgetTotalDto> get copyWith => _$BudgetTotalDtoCopyWithImpl<BudgetTotalDto>(this as BudgetTotalDto, _$identity);

  /// Serializes this BudgetTotalDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetTotalDto&&(identical(other.low, low) || other.low == low)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.high, high) || other.high == high)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,low,mid,high,currency);

@override
String toString() {
  return 'BudgetTotalDto(low: $low, mid: $mid, high: $high, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $BudgetTotalDtoCopyWith<$Res>  {
  factory $BudgetTotalDtoCopyWith(BudgetTotalDto value, $Res Function(BudgetTotalDto) _then) = _$BudgetTotalDtoCopyWithImpl;
@useResult
$Res call({
 double? low, double? mid, double? high, String currency
});




}
/// @nodoc
class _$BudgetTotalDtoCopyWithImpl<$Res>
    implements $BudgetTotalDtoCopyWith<$Res> {
  _$BudgetTotalDtoCopyWithImpl(this._self, this._then);

  final BudgetTotalDto _self;
  final $Res Function(BudgetTotalDto) _then;

/// Create a copy of BudgetTotalDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? low = freezed,Object? mid = freezed,Object? high = freezed,Object? currency = null,}) {
  return _then(_self.copyWith(
low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetTotalDto].
extension BudgetTotalDtoPatterns on BudgetTotalDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetTotalDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetTotalDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetTotalDto value)  $default,){
final _that = this;
switch (_that) {
case _BudgetTotalDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetTotalDto value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetTotalDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? low,  double? mid,  double? high,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetTotalDto() when $default != null:
return $default(_that.low,_that.mid,_that.high,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? low,  double? mid,  double? high,  String currency)  $default,) {final _that = this;
switch (_that) {
case _BudgetTotalDto():
return $default(_that.low,_that.mid,_that.high,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? low,  double? mid,  double? high,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _BudgetTotalDto() when $default != null:
return $default(_that.low,_that.mid,_that.high,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetTotalDto implements BudgetTotalDto {
  const _BudgetTotalDto({this.low, this.mid, this.high, this.currency = 'USD'});
  factory _BudgetTotalDto.fromJson(Map<String, dynamic> json) => _$BudgetTotalDtoFromJson(json);

@override final  double? low;
@override final  double? mid;
@override final  double? high;
@override@JsonKey() final  String currency;

/// Create a copy of BudgetTotalDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetTotalDtoCopyWith<_BudgetTotalDto> get copyWith => __$BudgetTotalDtoCopyWithImpl<_BudgetTotalDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetTotalDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetTotalDto&&(identical(other.low, low) || other.low == low)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.high, high) || other.high == high)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,low,mid,high,currency);

@override
String toString() {
  return 'BudgetTotalDto(low: $low, mid: $mid, high: $high, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$BudgetTotalDtoCopyWith<$Res> implements $BudgetTotalDtoCopyWith<$Res> {
  factory _$BudgetTotalDtoCopyWith(_BudgetTotalDto value, $Res Function(_BudgetTotalDto) _then) = __$BudgetTotalDtoCopyWithImpl;
@override @useResult
$Res call({
 double? low, double? mid, double? high, String currency
});




}
/// @nodoc
class __$BudgetTotalDtoCopyWithImpl<$Res>
    implements _$BudgetTotalDtoCopyWith<$Res> {
  __$BudgetTotalDtoCopyWithImpl(this._self, this._then);

  final _BudgetTotalDto _self;
  final $Res Function(_BudgetTotalDto) _then;

/// Create a copy of BudgetTotalDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? low = freezed,Object? mid = freezed,Object? high = freezed,Object? currency = null,}) {
  return _then(_BudgetTotalDto(
low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BudgetItemDto {

 String? get category; String? get description; double? get low; double? get mid; double? get high; double? get percentage; String? get notes;
/// Create a copy of BudgetItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetItemDtoCopyWith<BudgetItemDto> get copyWith => _$BudgetItemDtoCopyWithImpl<BudgetItemDto>(this as BudgetItemDto, _$identity);

  /// Serializes this BudgetItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetItemDto&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.low, low) || other.low == low)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.high, high) || other.high == high)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,description,low,mid,high,percentage,notes);

@override
String toString() {
  return 'BudgetItemDto(category: $category, description: $description, low: $low, mid: $mid, high: $high, percentage: $percentage, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $BudgetItemDtoCopyWith<$Res>  {
  factory $BudgetItemDtoCopyWith(BudgetItemDto value, $Res Function(BudgetItemDto) _then) = _$BudgetItemDtoCopyWithImpl;
@useResult
$Res call({
 String? category, String? description, double? low, double? mid, double? high, double? percentage, String? notes
});




}
/// @nodoc
class _$BudgetItemDtoCopyWithImpl<$Res>
    implements $BudgetItemDtoCopyWith<$Res> {
  _$BudgetItemDtoCopyWithImpl(this._self, this._then);

  final BudgetItemDto _self;
  final $Res Function(BudgetItemDto) _then;

/// Create a copy of BudgetItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? description = freezed,Object? low = freezed,Object? mid = freezed,Object? high = freezed,Object? percentage = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetItemDto].
extension BudgetItemDtoPatterns on BudgetItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetItemDto value)  $default,){
final _that = this;
switch (_that) {
case _BudgetItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? category,  String? description,  double? low,  double? mid,  double? high,  double? percentage,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetItemDto() when $default != null:
return $default(_that.category,_that.description,_that.low,_that.mid,_that.high,_that.percentage,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? category,  String? description,  double? low,  double? mid,  double? high,  double? percentage,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _BudgetItemDto():
return $default(_that.category,_that.description,_that.low,_that.mid,_that.high,_that.percentage,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? category,  String? description,  double? low,  double? mid,  double? high,  double? percentage,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _BudgetItemDto() when $default != null:
return $default(_that.category,_that.description,_that.low,_that.mid,_that.high,_that.percentage,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetItemDto implements BudgetItemDto {
  const _BudgetItemDto({this.category, this.description, this.low, this.mid, this.high, this.percentage, this.notes});
  factory _BudgetItemDto.fromJson(Map<String, dynamic> json) => _$BudgetItemDtoFromJson(json);

@override final  String? category;
@override final  String? description;
@override final  double? low;
@override final  double? mid;
@override final  double? high;
@override final  double? percentage;
@override final  String? notes;

/// Create a copy of BudgetItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetItemDtoCopyWith<_BudgetItemDto> get copyWith => __$BudgetItemDtoCopyWithImpl<_BudgetItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetItemDto&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.low, low) || other.low == low)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.high, high) || other.high == high)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,description,low,mid,high,percentage,notes);

@override
String toString() {
  return 'BudgetItemDto(category: $category, description: $description, low: $low, mid: $mid, high: $high, percentage: $percentage, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$BudgetItemDtoCopyWith<$Res> implements $BudgetItemDtoCopyWith<$Res> {
  factory _$BudgetItemDtoCopyWith(_BudgetItemDto value, $Res Function(_BudgetItemDto) _then) = __$BudgetItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String? category, String? description, double? low, double? mid, double? high, double? percentage, String? notes
});




}
/// @nodoc
class __$BudgetItemDtoCopyWithImpl<$Res>
    implements _$BudgetItemDtoCopyWith<$Res> {
  __$BudgetItemDtoCopyWithImpl(this._self, this._then);

  final _BudgetItemDto _self;
  final $Res Function(_BudgetItemDto) _then;

/// Create a copy of BudgetItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? description = freezed,Object? low = freezed,Object? mid = freezed,Object? high = freezed,Object? percentage = freezed,Object? notes = freezed,}) {
  return _then(_BudgetItemDto(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BudgetRiskDto {

 String? get factor; String? get impact;
/// Create a copy of BudgetRiskDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetRiskDtoCopyWith<BudgetRiskDto> get copyWith => _$BudgetRiskDtoCopyWithImpl<BudgetRiskDto>(this as BudgetRiskDto, _$identity);

  /// Serializes this BudgetRiskDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetRiskDto&&(identical(other.factor, factor) || other.factor == factor)&&(identical(other.impact, impact) || other.impact == impact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,factor,impact);

@override
String toString() {
  return 'BudgetRiskDto(factor: $factor, impact: $impact)';
}


}

/// @nodoc
abstract mixin class $BudgetRiskDtoCopyWith<$Res>  {
  factory $BudgetRiskDtoCopyWith(BudgetRiskDto value, $Res Function(BudgetRiskDto) _then) = _$BudgetRiskDtoCopyWithImpl;
@useResult
$Res call({
 String? factor, String? impact
});




}
/// @nodoc
class _$BudgetRiskDtoCopyWithImpl<$Res>
    implements $BudgetRiskDtoCopyWith<$Res> {
  _$BudgetRiskDtoCopyWithImpl(this._self, this._then);

  final BudgetRiskDto _self;
  final $Res Function(BudgetRiskDto) _then;

/// Create a copy of BudgetRiskDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? factor = freezed,Object? impact = freezed,}) {
  return _then(_self.copyWith(
factor: freezed == factor ? _self.factor : factor // ignore: cast_nullable_to_non_nullable
as String?,impact: freezed == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetRiskDto].
extension BudgetRiskDtoPatterns on BudgetRiskDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetRiskDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetRiskDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetRiskDto value)  $default,){
final _that = this;
switch (_that) {
case _BudgetRiskDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetRiskDto value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetRiskDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? factor,  String? impact)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetRiskDto() when $default != null:
return $default(_that.factor,_that.impact);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? factor,  String? impact)  $default,) {final _that = this;
switch (_that) {
case _BudgetRiskDto():
return $default(_that.factor,_that.impact);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? factor,  String? impact)?  $default,) {final _that = this;
switch (_that) {
case _BudgetRiskDto() when $default != null:
return $default(_that.factor,_that.impact);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetRiskDto implements BudgetRiskDto {
  const _BudgetRiskDto({this.factor, this.impact});
  factory _BudgetRiskDto.fromJson(Map<String, dynamic> json) => _$BudgetRiskDtoFromJson(json);

@override final  String? factor;
@override final  String? impact;

/// Create a copy of BudgetRiskDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetRiskDtoCopyWith<_BudgetRiskDto> get copyWith => __$BudgetRiskDtoCopyWithImpl<_BudgetRiskDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetRiskDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetRiskDto&&(identical(other.factor, factor) || other.factor == factor)&&(identical(other.impact, impact) || other.impact == impact));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,factor,impact);

@override
String toString() {
  return 'BudgetRiskDto(factor: $factor, impact: $impact)';
}


}

/// @nodoc
abstract mixin class _$BudgetRiskDtoCopyWith<$Res> implements $BudgetRiskDtoCopyWith<$Res> {
  factory _$BudgetRiskDtoCopyWith(_BudgetRiskDto value, $Res Function(_BudgetRiskDto) _then) = __$BudgetRiskDtoCopyWithImpl;
@override @useResult
$Res call({
 String? factor, String? impact
});




}
/// @nodoc
class __$BudgetRiskDtoCopyWithImpl<$Res>
    implements _$BudgetRiskDtoCopyWith<$Res> {
  __$BudgetRiskDtoCopyWithImpl(this._self, this._then);

  final _BudgetRiskDto _self;
  final $Res Function(_BudgetRiskDto) _then;

/// Create a copy of BudgetRiskDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? factor = freezed,Object? impact = freezed,}) {
  return _then(_BudgetRiskDto(
factor: freezed == factor ? _self.factor : factor // ignore: cast_nullable_to_non_nullable
as String?,impact: freezed == impact ? _self.impact : impact // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TalentRecommendationDto {

 List<TalentRoleDto>? get roles; Map<String, dynamic>? get teamSize; List<Map<String, dynamic>>? get departmentBreakdown; String? get hiringTimeline; String? get budgetConsiderations;
/// Create a copy of TalentRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TalentRecommendationDtoCopyWith<TalentRecommendationDto> get copyWith => _$TalentRecommendationDtoCopyWithImpl<TalentRecommendationDto>(this as TalentRecommendationDto, _$identity);

  /// Serializes this TalentRecommendationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TalentRecommendationDto&&const DeepCollectionEquality().equals(other.roles, roles)&&const DeepCollectionEquality().equals(other.teamSize, teamSize)&&const DeepCollectionEquality().equals(other.departmentBreakdown, departmentBreakdown)&&(identical(other.hiringTimeline, hiringTimeline) || other.hiringTimeline == hiringTimeline)&&(identical(other.budgetConsiderations, budgetConsiderations) || other.budgetConsiderations == budgetConsiderations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(roles),const DeepCollectionEquality().hash(teamSize),const DeepCollectionEquality().hash(departmentBreakdown),hiringTimeline,budgetConsiderations);

@override
String toString() {
  return 'TalentRecommendationDto(roles: $roles, teamSize: $teamSize, departmentBreakdown: $departmentBreakdown, hiringTimeline: $hiringTimeline, budgetConsiderations: $budgetConsiderations)';
}


}

/// @nodoc
abstract mixin class $TalentRecommendationDtoCopyWith<$Res>  {
  factory $TalentRecommendationDtoCopyWith(TalentRecommendationDto value, $Res Function(TalentRecommendationDto) _then) = _$TalentRecommendationDtoCopyWithImpl;
@useResult
$Res call({
 List<TalentRoleDto>? roles, Map<String, dynamic>? teamSize, List<Map<String, dynamic>>? departmentBreakdown, String? hiringTimeline, String? budgetConsiderations
});




}
/// @nodoc
class _$TalentRecommendationDtoCopyWithImpl<$Res>
    implements $TalentRecommendationDtoCopyWith<$Res> {
  _$TalentRecommendationDtoCopyWithImpl(this._self, this._then);

  final TalentRecommendationDto _self;
  final $Res Function(TalentRecommendationDto) _then;

/// Create a copy of TalentRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roles = freezed,Object? teamSize = freezed,Object? departmentBreakdown = freezed,Object? hiringTimeline = freezed,Object? budgetConsiderations = freezed,}) {
  return _then(_self.copyWith(
roles: freezed == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<TalentRoleDto>?,teamSize: freezed == teamSize ? _self.teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,departmentBreakdown: freezed == departmentBreakdown ? _self.departmentBreakdown : departmentBreakdown // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,hiringTimeline: freezed == hiringTimeline ? _self.hiringTimeline : hiringTimeline // ignore: cast_nullable_to_non_nullable
as String?,budgetConsiderations: freezed == budgetConsiderations ? _self.budgetConsiderations : budgetConsiderations // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TalentRecommendationDto].
extension TalentRecommendationDtoPatterns on TalentRecommendationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TalentRecommendationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TalentRecommendationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TalentRecommendationDto value)  $default,){
final _that = this;
switch (_that) {
case _TalentRecommendationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TalentRecommendationDto value)?  $default,){
final _that = this;
switch (_that) {
case _TalentRecommendationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TalentRoleDto>? roles,  Map<String, dynamic>? teamSize,  List<Map<String, dynamic>>? departmentBreakdown,  String? hiringTimeline,  String? budgetConsiderations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TalentRecommendationDto() when $default != null:
return $default(_that.roles,_that.teamSize,_that.departmentBreakdown,_that.hiringTimeline,_that.budgetConsiderations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TalentRoleDto>? roles,  Map<String, dynamic>? teamSize,  List<Map<String, dynamic>>? departmentBreakdown,  String? hiringTimeline,  String? budgetConsiderations)  $default,) {final _that = this;
switch (_that) {
case _TalentRecommendationDto():
return $default(_that.roles,_that.teamSize,_that.departmentBreakdown,_that.hiringTimeline,_that.budgetConsiderations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TalentRoleDto>? roles,  Map<String, dynamic>? teamSize,  List<Map<String, dynamic>>? departmentBreakdown,  String? hiringTimeline,  String? budgetConsiderations)?  $default,) {final _that = this;
switch (_that) {
case _TalentRecommendationDto() when $default != null:
return $default(_that.roles,_that.teamSize,_that.departmentBreakdown,_that.hiringTimeline,_that.budgetConsiderations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TalentRecommendationDto implements TalentRecommendationDto {
  const _TalentRecommendationDto({final  List<TalentRoleDto>? roles, final  Map<String, dynamic>? teamSize, final  List<Map<String, dynamic>>? departmentBreakdown, this.hiringTimeline, this.budgetConsiderations}): _roles = roles,_teamSize = teamSize,_departmentBreakdown = departmentBreakdown;
  factory _TalentRecommendationDto.fromJson(Map<String, dynamic> json) => _$TalentRecommendationDtoFromJson(json);

 final  List<TalentRoleDto>? _roles;
@override List<TalentRoleDto>? get roles {
  final value = _roles;
  if (value == null) return null;
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _teamSize;
@override Map<String, dynamic>? get teamSize {
  final value = _teamSize;
  if (value == null) return null;
  if (_teamSize is EqualUnmodifiableMapView) return _teamSize;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _departmentBreakdown;
@override List<Map<String, dynamic>>? get departmentBreakdown {
  final value = _departmentBreakdown;
  if (value == null) return null;
  if (_departmentBreakdown is EqualUnmodifiableListView) return _departmentBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? hiringTimeline;
@override final  String? budgetConsiderations;

/// Create a copy of TalentRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TalentRecommendationDtoCopyWith<_TalentRecommendationDto> get copyWith => __$TalentRecommendationDtoCopyWithImpl<_TalentRecommendationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TalentRecommendationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TalentRecommendationDto&&const DeepCollectionEquality().equals(other._roles, _roles)&&const DeepCollectionEquality().equals(other._teamSize, _teamSize)&&const DeepCollectionEquality().equals(other._departmentBreakdown, _departmentBreakdown)&&(identical(other.hiringTimeline, hiringTimeline) || other.hiringTimeline == hiringTimeline)&&(identical(other.budgetConsiderations, budgetConsiderations) || other.budgetConsiderations == budgetConsiderations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_teamSize),const DeepCollectionEquality().hash(_departmentBreakdown),hiringTimeline,budgetConsiderations);

@override
String toString() {
  return 'TalentRecommendationDto(roles: $roles, teamSize: $teamSize, departmentBreakdown: $departmentBreakdown, hiringTimeline: $hiringTimeline, budgetConsiderations: $budgetConsiderations)';
}


}

/// @nodoc
abstract mixin class _$TalentRecommendationDtoCopyWith<$Res> implements $TalentRecommendationDtoCopyWith<$Res> {
  factory _$TalentRecommendationDtoCopyWith(_TalentRecommendationDto value, $Res Function(_TalentRecommendationDto) _then) = __$TalentRecommendationDtoCopyWithImpl;
@override @useResult
$Res call({
 List<TalentRoleDto>? roles, Map<String, dynamic>? teamSize, List<Map<String, dynamic>>? departmentBreakdown, String? hiringTimeline, String? budgetConsiderations
});




}
/// @nodoc
class __$TalentRecommendationDtoCopyWithImpl<$Res>
    implements _$TalentRecommendationDtoCopyWith<$Res> {
  __$TalentRecommendationDtoCopyWithImpl(this._self, this._then);

  final _TalentRecommendationDto _self;
  final $Res Function(_TalentRecommendationDto) _then;

/// Create a copy of TalentRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roles = freezed,Object? teamSize = freezed,Object? departmentBreakdown = freezed,Object? hiringTimeline = freezed,Object? budgetConsiderations = freezed,}) {
  return _then(_TalentRecommendationDto(
roles: freezed == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<TalentRoleDto>?,teamSize: freezed == teamSize ? _self._teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,departmentBreakdown: freezed == departmentBreakdown ? _self._departmentBreakdown : departmentBreakdown // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,hiringTimeline: freezed == hiringTimeline ? _self.hiringTimeline : hiringTimeline // ignore: cast_nullable_to_non_nullable
as String?,budgetConsiderations: freezed == budgetConsiderations ? _self.budgetConsiderations : budgetConsiderations // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TalentRoleDto {

 String? get title; String? get department; String? get priority; String? get description; List<String>? get skillsRequired; String? get experienceLevel; Map<String, dynamic>? get estimatedRate; String? get notes;
/// Create a copy of TalentRoleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TalentRoleDtoCopyWith<TalentRoleDto> get copyWith => _$TalentRoleDtoCopyWithImpl<TalentRoleDto>(this as TalentRoleDto, _$identity);

  /// Serializes this TalentRoleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TalentRoleDto&&(identical(other.title, title) || other.title == title)&&(identical(other.department, department) || other.department == department)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.skillsRequired, skillsRequired)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&const DeepCollectionEquality().equals(other.estimatedRate, estimatedRate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,department,priority,description,const DeepCollectionEquality().hash(skillsRequired),experienceLevel,const DeepCollectionEquality().hash(estimatedRate),notes);

@override
String toString() {
  return 'TalentRoleDto(title: $title, department: $department, priority: $priority, description: $description, skillsRequired: $skillsRequired, experienceLevel: $experienceLevel, estimatedRate: $estimatedRate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $TalentRoleDtoCopyWith<$Res>  {
  factory $TalentRoleDtoCopyWith(TalentRoleDto value, $Res Function(TalentRoleDto) _then) = _$TalentRoleDtoCopyWithImpl;
@useResult
$Res call({
 String? title, String? department, String? priority, String? description, List<String>? skillsRequired, String? experienceLevel, Map<String, dynamic>? estimatedRate, String? notes
});




}
/// @nodoc
class _$TalentRoleDtoCopyWithImpl<$Res>
    implements $TalentRoleDtoCopyWith<$Res> {
  _$TalentRoleDtoCopyWithImpl(this._self, this._then);

  final TalentRoleDto _self;
  final $Res Function(TalentRoleDto) _then;

/// Create a copy of TalentRoleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? department = freezed,Object? priority = freezed,Object? description = freezed,Object? skillsRequired = freezed,Object? experienceLevel = freezed,Object? estimatedRate = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,skillsRequired: freezed == skillsRequired ? _self.skillsRequired : skillsRequired // ignore: cast_nullable_to_non_nullable
as List<String>?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,estimatedRate: freezed == estimatedRate ? _self.estimatedRate : estimatedRate // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TalentRoleDto].
extension TalentRoleDtoPatterns on TalentRoleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TalentRoleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TalentRoleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TalentRoleDto value)  $default,){
final _that = this;
switch (_that) {
case _TalentRoleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TalentRoleDto value)?  $default,){
final _that = this;
switch (_that) {
case _TalentRoleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? department,  String? priority,  String? description,  List<String>? skillsRequired,  String? experienceLevel,  Map<String, dynamic>? estimatedRate,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TalentRoleDto() when $default != null:
return $default(_that.title,_that.department,_that.priority,_that.description,_that.skillsRequired,_that.experienceLevel,_that.estimatedRate,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? department,  String? priority,  String? description,  List<String>? skillsRequired,  String? experienceLevel,  Map<String, dynamic>? estimatedRate,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _TalentRoleDto():
return $default(_that.title,_that.department,_that.priority,_that.description,_that.skillsRequired,_that.experienceLevel,_that.estimatedRate,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? department,  String? priority,  String? description,  List<String>? skillsRequired,  String? experienceLevel,  Map<String, dynamic>? estimatedRate,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _TalentRoleDto() when $default != null:
return $default(_that.title,_that.department,_that.priority,_that.description,_that.skillsRequired,_that.experienceLevel,_that.estimatedRate,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TalentRoleDto implements TalentRoleDto {
  const _TalentRoleDto({this.title, this.department, this.priority, this.description, final  List<String>? skillsRequired, this.experienceLevel, final  Map<String, dynamic>? estimatedRate, this.notes}): _skillsRequired = skillsRequired,_estimatedRate = estimatedRate;
  factory _TalentRoleDto.fromJson(Map<String, dynamic> json) => _$TalentRoleDtoFromJson(json);

@override final  String? title;
@override final  String? department;
@override final  String? priority;
@override final  String? description;
 final  List<String>? _skillsRequired;
@override List<String>? get skillsRequired {
  final value = _skillsRequired;
  if (value == null) return null;
  if (_skillsRequired is EqualUnmodifiableListView) return _skillsRequired;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? experienceLevel;
 final  Map<String, dynamic>? _estimatedRate;
@override Map<String, dynamic>? get estimatedRate {
  final value = _estimatedRate;
  if (value == null) return null;
  if (_estimatedRate is EqualUnmodifiableMapView) return _estimatedRate;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? notes;

/// Create a copy of TalentRoleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TalentRoleDtoCopyWith<_TalentRoleDto> get copyWith => __$TalentRoleDtoCopyWithImpl<_TalentRoleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TalentRoleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TalentRoleDto&&(identical(other.title, title) || other.title == title)&&(identical(other.department, department) || other.department == department)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._skillsRequired, _skillsRequired)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&const DeepCollectionEquality().equals(other._estimatedRate, _estimatedRate)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,department,priority,description,const DeepCollectionEquality().hash(_skillsRequired),experienceLevel,const DeepCollectionEquality().hash(_estimatedRate),notes);

@override
String toString() {
  return 'TalentRoleDto(title: $title, department: $department, priority: $priority, description: $description, skillsRequired: $skillsRequired, experienceLevel: $experienceLevel, estimatedRate: $estimatedRate, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$TalentRoleDtoCopyWith<$Res> implements $TalentRoleDtoCopyWith<$Res> {
  factory _$TalentRoleDtoCopyWith(_TalentRoleDto value, $Res Function(_TalentRoleDto) _then) = __$TalentRoleDtoCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? department, String? priority, String? description, List<String>? skillsRequired, String? experienceLevel, Map<String, dynamic>? estimatedRate, String? notes
});




}
/// @nodoc
class __$TalentRoleDtoCopyWithImpl<$Res>
    implements _$TalentRoleDtoCopyWith<$Res> {
  __$TalentRoleDtoCopyWithImpl(this._self, this._then);

  final _TalentRoleDto _self;
  final $Res Function(_TalentRoleDto) _then;

/// Create a copy of TalentRoleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? department = freezed,Object? priority = freezed,Object? description = freezed,Object? skillsRequired = freezed,Object? experienceLevel = freezed,Object? estimatedRate = freezed,Object? notes = freezed,}) {
  return _then(_TalentRoleDto(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,skillsRequired: freezed == skillsRequired ? _self._skillsRequired : skillsRequired // ignore: cast_nullable_to_non_nullable
as List<String>?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,estimatedRate: freezed == estimatedRate ? _self._estimatedRate : estimatedRate // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreativeAssistDto {

 String? get response; List<String>? get suggestions; List<CreativeReferenceDto>? get references; List<String>? get nextSteps; List<String>? get relatedTopics;
/// Create a copy of CreativeAssistDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreativeAssistDtoCopyWith<CreativeAssistDto> get copyWith => _$CreativeAssistDtoCopyWithImpl<CreativeAssistDto>(this as CreativeAssistDto, _$identity);

  /// Serializes this CreativeAssistDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreativeAssistDto&&(identical(other.response, response) || other.response == response)&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&const DeepCollectionEquality().equals(other.references, references)&&const DeepCollectionEquality().equals(other.nextSteps, nextSteps)&&const DeepCollectionEquality().equals(other.relatedTopics, relatedTopics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,response,const DeepCollectionEquality().hash(suggestions),const DeepCollectionEquality().hash(references),const DeepCollectionEquality().hash(nextSteps),const DeepCollectionEquality().hash(relatedTopics));

@override
String toString() {
  return 'CreativeAssistDto(response: $response, suggestions: $suggestions, references: $references, nextSteps: $nextSteps, relatedTopics: $relatedTopics)';
}


}

/// @nodoc
abstract mixin class $CreativeAssistDtoCopyWith<$Res>  {
  factory $CreativeAssistDtoCopyWith(CreativeAssistDto value, $Res Function(CreativeAssistDto) _then) = _$CreativeAssistDtoCopyWithImpl;
@useResult
$Res call({
 String? response, List<String>? suggestions, List<CreativeReferenceDto>? references, List<String>? nextSteps, List<String>? relatedTopics
});




}
/// @nodoc
class _$CreativeAssistDtoCopyWithImpl<$Res>
    implements $CreativeAssistDtoCopyWith<$Res> {
  _$CreativeAssistDtoCopyWithImpl(this._self, this._then);

  final CreativeAssistDto _self;
  final $Res Function(CreativeAssistDto) _then;

/// Create a copy of CreativeAssistDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? response = freezed,Object? suggestions = freezed,Object? references = freezed,Object? nextSteps = freezed,Object? relatedTopics = freezed,}) {
  return _then(_self.copyWith(
response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String?,suggestions: freezed == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>?,references: freezed == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<CreativeReferenceDto>?,nextSteps: freezed == nextSteps ? _self.nextSteps : nextSteps // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedTopics: freezed == relatedTopics ? _self.relatedTopics : relatedTopics // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreativeAssistDto].
extension CreativeAssistDtoPatterns on CreativeAssistDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreativeAssistDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreativeAssistDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreativeAssistDto value)  $default,){
final _that = this;
switch (_that) {
case _CreativeAssistDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreativeAssistDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreativeAssistDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? response,  List<String>? suggestions,  List<CreativeReferenceDto>? references,  List<String>? nextSteps,  List<String>? relatedTopics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreativeAssistDto() when $default != null:
return $default(_that.response,_that.suggestions,_that.references,_that.nextSteps,_that.relatedTopics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? response,  List<String>? suggestions,  List<CreativeReferenceDto>? references,  List<String>? nextSteps,  List<String>? relatedTopics)  $default,) {final _that = this;
switch (_that) {
case _CreativeAssistDto():
return $default(_that.response,_that.suggestions,_that.references,_that.nextSteps,_that.relatedTopics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? response,  List<String>? suggestions,  List<CreativeReferenceDto>? references,  List<String>? nextSteps,  List<String>? relatedTopics)?  $default,) {final _that = this;
switch (_that) {
case _CreativeAssistDto() when $default != null:
return $default(_that.response,_that.suggestions,_that.references,_that.nextSteps,_that.relatedTopics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreativeAssistDto implements CreativeAssistDto {
  const _CreativeAssistDto({this.response, final  List<String>? suggestions, final  List<CreativeReferenceDto>? references, final  List<String>? nextSteps, final  List<String>? relatedTopics}): _suggestions = suggestions,_references = references,_nextSteps = nextSteps,_relatedTopics = relatedTopics;
  factory _CreativeAssistDto.fromJson(Map<String, dynamic> json) => _$CreativeAssistDtoFromJson(json);

@override final  String? response;
 final  List<String>? _suggestions;
@override List<String>? get suggestions {
  final value = _suggestions;
  if (value == null) return null;
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<CreativeReferenceDto>? _references;
@override List<CreativeReferenceDto>? get references {
  final value = _references;
  if (value == null) return null;
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _nextSteps;
@override List<String>? get nextSteps {
  final value = _nextSteps;
  if (value == null) return null;
  if (_nextSteps is EqualUnmodifiableListView) return _nextSteps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _relatedTopics;
@override List<String>? get relatedTopics {
  final value = _relatedTopics;
  if (value == null) return null;
  if (_relatedTopics is EqualUnmodifiableListView) return _relatedTopics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CreativeAssistDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreativeAssistDtoCopyWith<_CreativeAssistDto> get copyWith => __$CreativeAssistDtoCopyWithImpl<_CreativeAssistDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreativeAssistDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreativeAssistDto&&(identical(other.response, response) || other.response == response)&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&const DeepCollectionEquality().equals(other._references, _references)&&const DeepCollectionEquality().equals(other._nextSteps, _nextSteps)&&const DeepCollectionEquality().equals(other._relatedTopics, _relatedTopics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,response,const DeepCollectionEquality().hash(_suggestions),const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_nextSteps),const DeepCollectionEquality().hash(_relatedTopics));

@override
String toString() {
  return 'CreativeAssistDto(response: $response, suggestions: $suggestions, references: $references, nextSteps: $nextSteps, relatedTopics: $relatedTopics)';
}


}

/// @nodoc
abstract mixin class _$CreativeAssistDtoCopyWith<$Res> implements $CreativeAssistDtoCopyWith<$Res> {
  factory _$CreativeAssistDtoCopyWith(_CreativeAssistDto value, $Res Function(_CreativeAssistDto) _then) = __$CreativeAssistDtoCopyWithImpl;
@override @useResult
$Res call({
 String? response, List<String>? suggestions, List<CreativeReferenceDto>? references, List<String>? nextSteps, List<String>? relatedTopics
});




}
/// @nodoc
class __$CreativeAssistDtoCopyWithImpl<$Res>
    implements _$CreativeAssistDtoCopyWith<$Res> {
  __$CreativeAssistDtoCopyWithImpl(this._self, this._then);

  final _CreativeAssistDto _self;
  final $Res Function(_CreativeAssistDto) _then;

/// Create a copy of CreativeAssistDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? response = freezed,Object? suggestions = freezed,Object? references = freezed,Object? nextSteps = freezed,Object? relatedTopics = freezed,}) {
  return _then(_CreativeAssistDto(
response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as String?,suggestions: freezed == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<String>?,references: freezed == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<CreativeReferenceDto>?,nextSteps: freezed == nextSteps ? _self._nextSteps : nextSteps // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedTopics: freezed == relatedTopics ? _self._relatedTopics : relatedTopics // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$CreativeReferenceDto {

 String? get title; String? get relevance;
/// Create a copy of CreativeReferenceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreativeReferenceDtoCopyWith<CreativeReferenceDto> get copyWith => _$CreativeReferenceDtoCopyWithImpl<CreativeReferenceDto>(this as CreativeReferenceDto, _$identity);

  /// Serializes this CreativeReferenceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreativeReferenceDto&&(identical(other.title, title) || other.title == title)&&(identical(other.relevance, relevance) || other.relevance == relevance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,relevance);

@override
String toString() {
  return 'CreativeReferenceDto(title: $title, relevance: $relevance)';
}


}

/// @nodoc
abstract mixin class $CreativeReferenceDtoCopyWith<$Res>  {
  factory $CreativeReferenceDtoCopyWith(CreativeReferenceDto value, $Res Function(CreativeReferenceDto) _then) = _$CreativeReferenceDtoCopyWithImpl;
@useResult
$Res call({
 String? title, String? relevance
});




}
/// @nodoc
class _$CreativeReferenceDtoCopyWithImpl<$Res>
    implements $CreativeReferenceDtoCopyWith<$Res> {
  _$CreativeReferenceDtoCopyWithImpl(this._self, this._then);

  final CreativeReferenceDto _self;
  final $Res Function(CreativeReferenceDto) _then;

/// Create a copy of CreativeReferenceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? relevance = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,relevance: freezed == relevance ? _self.relevance : relevance // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreativeReferenceDto].
extension CreativeReferenceDtoPatterns on CreativeReferenceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreativeReferenceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreativeReferenceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreativeReferenceDto value)  $default,){
final _that = this;
switch (_that) {
case _CreativeReferenceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreativeReferenceDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreativeReferenceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? relevance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreativeReferenceDto() when $default != null:
return $default(_that.title,_that.relevance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? relevance)  $default,) {final _that = this;
switch (_that) {
case _CreativeReferenceDto():
return $default(_that.title,_that.relevance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? relevance)?  $default,) {final _that = this;
switch (_that) {
case _CreativeReferenceDto() when $default != null:
return $default(_that.title,_that.relevance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreativeReferenceDto implements CreativeReferenceDto {
  const _CreativeReferenceDto({this.title, this.relevance});
  factory _CreativeReferenceDto.fromJson(Map<String, dynamic> json) => _$CreativeReferenceDtoFromJson(json);

@override final  String? title;
@override final  String? relevance;

/// Create a copy of CreativeReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreativeReferenceDtoCopyWith<_CreativeReferenceDto> get copyWith => __$CreativeReferenceDtoCopyWithImpl<_CreativeReferenceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreativeReferenceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreativeReferenceDto&&(identical(other.title, title) || other.title == title)&&(identical(other.relevance, relevance) || other.relevance == relevance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,relevance);

@override
String toString() {
  return 'CreativeReferenceDto(title: $title, relevance: $relevance)';
}


}

/// @nodoc
abstract mixin class _$CreativeReferenceDtoCopyWith<$Res> implements $CreativeReferenceDtoCopyWith<$Res> {
  factory _$CreativeReferenceDtoCopyWith(_CreativeReferenceDto value, $Res Function(_CreativeReferenceDto) _then) = __$CreativeReferenceDtoCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? relevance
});




}
/// @nodoc
class __$CreativeReferenceDtoCopyWithImpl<$Res>
    implements _$CreativeReferenceDtoCopyWith<$Res> {
  __$CreativeReferenceDtoCopyWithImpl(this._self, this._then);

  final _CreativeReferenceDto _self;
  final $Res Function(_CreativeReferenceDto) _then;

/// Create a copy of CreativeReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? relevance = freezed,}) {
  return _then(_CreativeReferenceDto(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,relevance: freezed == relevance ? _self.relevance : relevance // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProjectInsightsDto {

 ProjectHealthDto? get projectHealth; List<ProjectInsightItemDto>? get insights; Map<String, dynamic>? get predictions; Map<String, dynamic>? get benchmarks;
/// Create a copy of ProjectInsightsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectInsightsDtoCopyWith<ProjectInsightsDto> get copyWith => _$ProjectInsightsDtoCopyWithImpl<ProjectInsightsDto>(this as ProjectInsightsDto, _$identity);

  /// Serializes this ProjectInsightsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectInsightsDto&&(identical(other.projectHealth, projectHealth) || other.projectHealth == projectHealth)&&const DeepCollectionEquality().equals(other.insights, insights)&&const DeepCollectionEquality().equals(other.predictions, predictions)&&const DeepCollectionEquality().equals(other.benchmarks, benchmarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectHealth,const DeepCollectionEquality().hash(insights),const DeepCollectionEquality().hash(predictions),const DeepCollectionEquality().hash(benchmarks));

@override
String toString() {
  return 'ProjectInsightsDto(projectHealth: $projectHealth, insights: $insights, predictions: $predictions, benchmarks: $benchmarks)';
}


}

/// @nodoc
abstract mixin class $ProjectInsightsDtoCopyWith<$Res>  {
  factory $ProjectInsightsDtoCopyWith(ProjectInsightsDto value, $Res Function(ProjectInsightsDto) _then) = _$ProjectInsightsDtoCopyWithImpl;
@useResult
$Res call({
 ProjectHealthDto? projectHealth, List<ProjectInsightItemDto>? insights, Map<String, dynamic>? predictions, Map<String, dynamic>? benchmarks
});


$ProjectHealthDtoCopyWith<$Res>? get projectHealth;

}
/// @nodoc
class _$ProjectInsightsDtoCopyWithImpl<$Res>
    implements $ProjectInsightsDtoCopyWith<$Res> {
  _$ProjectInsightsDtoCopyWithImpl(this._self, this._then);

  final ProjectInsightsDto _self;
  final $Res Function(ProjectInsightsDto) _then;

/// Create a copy of ProjectInsightsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectHealth = freezed,Object? insights = freezed,Object? predictions = freezed,Object? benchmarks = freezed,}) {
  return _then(_self.copyWith(
projectHealth: freezed == projectHealth ? _self.projectHealth : projectHealth // ignore: cast_nullable_to_non_nullable
as ProjectHealthDto?,insights: freezed == insights ? _self.insights : insights // ignore: cast_nullable_to_non_nullable
as List<ProjectInsightItemDto>?,predictions: freezed == predictions ? _self.predictions : predictions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,benchmarks: freezed == benchmarks ? _self.benchmarks : benchmarks // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of ProjectInsightsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectHealthDtoCopyWith<$Res>? get projectHealth {
    if (_self.projectHealth == null) {
    return null;
  }

  return $ProjectHealthDtoCopyWith<$Res>(_self.projectHealth!, (value) {
    return _then(_self.copyWith(projectHealth: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectInsightsDto].
extension ProjectInsightsDtoPatterns on ProjectInsightsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectInsightsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectInsightsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectInsightsDto value)  $default,){
final _that = this;
switch (_that) {
case _ProjectInsightsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectInsightsDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectInsightsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectHealthDto? projectHealth,  List<ProjectInsightItemDto>? insights,  Map<String, dynamic>? predictions,  Map<String, dynamic>? benchmarks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectInsightsDto() when $default != null:
return $default(_that.projectHealth,_that.insights,_that.predictions,_that.benchmarks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectHealthDto? projectHealth,  List<ProjectInsightItemDto>? insights,  Map<String, dynamic>? predictions,  Map<String, dynamic>? benchmarks)  $default,) {final _that = this;
switch (_that) {
case _ProjectInsightsDto():
return $default(_that.projectHealth,_that.insights,_that.predictions,_that.benchmarks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectHealthDto? projectHealth,  List<ProjectInsightItemDto>? insights,  Map<String, dynamic>? predictions,  Map<String, dynamic>? benchmarks)?  $default,) {final _that = this;
switch (_that) {
case _ProjectInsightsDto() when $default != null:
return $default(_that.projectHealth,_that.insights,_that.predictions,_that.benchmarks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectInsightsDto implements ProjectInsightsDto {
  const _ProjectInsightsDto({this.projectHealth, final  List<ProjectInsightItemDto>? insights, final  Map<String, dynamic>? predictions, final  Map<String, dynamic>? benchmarks}): _insights = insights,_predictions = predictions,_benchmarks = benchmarks;
  factory _ProjectInsightsDto.fromJson(Map<String, dynamic> json) => _$ProjectInsightsDtoFromJson(json);

@override final  ProjectHealthDto? projectHealth;
 final  List<ProjectInsightItemDto>? _insights;
@override List<ProjectInsightItemDto>? get insights {
  final value = _insights;
  if (value == null) return null;
  if (_insights is EqualUnmodifiableListView) return _insights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _predictions;
@override Map<String, dynamic>? get predictions {
  final value = _predictions;
  if (value == null) return null;
  if (_predictions is EqualUnmodifiableMapView) return _predictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _benchmarks;
@override Map<String, dynamic>? get benchmarks {
  final value = _benchmarks;
  if (value == null) return null;
  if (_benchmarks is EqualUnmodifiableMapView) return _benchmarks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ProjectInsightsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectInsightsDtoCopyWith<_ProjectInsightsDto> get copyWith => __$ProjectInsightsDtoCopyWithImpl<_ProjectInsightsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectInsightsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectInsightsDto&&(identical(other.projectHealth, projectHealth) || other.projectHealth == projectHealth)&&const DeepCollectionEquality().equals(other._insights, _insights)&&const DeepCollectionEquality().equals(other._predictions, _predictions)&&const DeepCollectionEquality().equals(other._benchmarks, _benchmarks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectHealth,const DeepCollectionEquality().hash(_insights),const DeepCollectionEquality().hash(_predictions),const DeepCollectionEquality().hash(_benchmarks));

@override
String toString() {
  return 'ProjectInsightsDto(projectHealth: $projectHealth, insights: $insights, predictions: $predictions, benchmarks: $benchmarks)';
}


}

/// @nodoc
abstract mixin class _$ProjectInsightsDtoCopyWith<$Res> implements $ProjectInsightsDtoCopyWith<$Res> {
  factory _$ProjectInsightsDtoCopyWith(_ProjectInsightsDto value, $Res Function(_ProjectInsightsDto) _then) = __$ProjectInsightsDtoCopyWithImpl;
@override @useResult
$Res call({
 ProjectHealthDto? projectHealth, List<ProjectInsightItemDto>? insights, Map<String, dynamic>? predictions, Map<String, dynamic>? benchmarks
});


@override $ProjectHealthDtoCopyWith<$Res>? get projectHealth;

}
/// @nodoc
class __$ProjectInsightsDtoCopyWithImpl<$Res>
    implements _$ProjectInsightsDtoCopyWith<$Res> {
  __$ProjectInsightsDtoCopyWithImpl(this._self, this._then);

  final _ProjectInsightsDto _self;
  final $Res Function(_ProjectInsightsDto) _then;

/// Create a copy of ProjectInsightsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectHealth = freezed,Object? insights = freezed,Object? predictions = freezed,Object? benchmarks = freezed,}) {
  return _then(_ProjectInsightsDto(
projectHealth: freezed == projectHealth ? _self.projectHealth : projectHealth // ignore: cast_nullable_to_non_nullable
as ProjectHealthDto?,insights: freezed == insights ? _self._insights : insights // ignore: cast_nullable_to_non_nullable
as List<ProjectInsightItemDto>?,predictions: freezed == predictions ? _self._predictions : predictions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,benchmarks: freezed == benchmarks ? _self._benchmarks : benchmarks // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of ProjectInsightsDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectHealthDtoCopyWith<$Res>? get projectHealth {
    if (_self.projectHealth == null) {
    return null;
  }

  return $ProjectHealthDtoCopyWith<$Res>(_self.projectHealth!, (value) {
    return _then(_self.copyWith(projectHealth: value));
  });
}
}


/// @nodoc
mixin _$ProjectHealthDto {

 int? get score; String? get status;
/// Create a copy of ProjectHealthDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectHealthDtoCopyWith<ProjectHealthDto> get copyWith => _$ProjectHealthDtoCopyWithImpl<ProjectHealthDto>(this as ProjectHealthDto, _$identity);

  /// Serializes this ProjectHealthDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectHealthDto&&(identical(other.score, score) || other.score == score)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,status);

@override
String toString() {
  return 'ProjectHealthDto(score: $score, status: $status)';
}


}

/// @nodoc
abstract mixin class $ProjectHealthDtoCopyWith<$Res>  {
  factory $ProjectHealthDtoCopyWith(ProjectHealthDto value, $Res Function(ProjectHealthDto) _then) = _$ProjectHealthDtoCopyWithImpl;
@useResult
$Res call({
 int? score, String? status
});




}
/// @nodoc
class _$ProjectHealthDtoCopyWithImpl<$Res>
    implements $ProjectHealthDtoCopyWith<$Res> {
  _$ProjectHealthDtoCopyWithImpl(this._self, this._then);

  final ProjectHealthDto _self;
  final $Res Function(ProjectHealthDto) _then;

/// Create a copy of ProjectHealthDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectHealthDto].
extension ProjectHealthDtoPatterns on ProjectHealthDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectHealthDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectHealthDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectHealthDto value)  $default,){
final _that = this;
switch (_that) {
case _ProjectHealthDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectHealthDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectHealthDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? score,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectHealthDto() when $default != null:
return $default(_that.score,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? score,  String? status)  $default,) {final _that = this;
switch (_that) {
case _ProjectHealthDto():
return $default(_that.score,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? score,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _ProjectHealthDto() when $default != null:
return $default(_that.score,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectHealthDto implements ProjectHealthDto {
  const _ProjectHealthDto({this.score, this.status});
  factory _ProjectHealthDto.fromJson(Map<String, dynamic> json) => _$ProjectHealthDtoFromJson(json);

@override final  int? score;
@override final  String? status;

/// Create a copy of ProjectHealthDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectHealthDtoCopyWith<_ProjectHealthDto> get copyWith => __$ProjectHealthDtoCopyWithImpl<_ProjectHealthDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectHealthDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectHealthDto&&(identical(other.score, score) || other.score == score)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,score,status);

@override
String toString() {
  return 'ProjectHealthDto(score: $score, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ProjectHealthDtoCopyWith<$Res> implements $ProjectHealthDtoCopyWith<$Res> {
  factory _$ProjectHealthDtoCopyWith(_ProjectHealthDto value, $Res Function(_ProjectHealthDto) _then) = __$ProjectHealthDtoCopyWithImpl;
@override @useResult
$Res call({
 int? score, String? status
});




}
/// @nodoc
class __$ProjectHealthDtoCopyWithImpl<$Res>
    implements _$ProjectHealthDtoCopyWith<$Res> {
  __$ProjectHealthDtoCopyWithImpl(this._self, this._then);

  final _ProjectHealthDto _self;
  final $Res Function(_ProjectHealthDto) _then;

/// Create a copy of ProjectHealthDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = freezed,Object? status = freezed,}) {
  return _then(_ProjectHealthDto(
score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProjectInsightItemDto {

 String? get type; String? get priority; String? get title; String? get description; bool? get actionRequired; String? get suggestedAction;
/// Create a copy of ProjectInsightItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectInsightItemDtoCopyWith<ProjectInsightItemDto> get copyWith => _$ProjectInsightItemDtoCopyWithImpl<ProjectInsightItemDto>(this as ProjectInsightItemDto, _$identity);

  /// Serializes this ProjectInsightItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectInsightItemDto&&(identical(other.type, type) || other.type == type)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.actionRequired, actionRequired) || other.actionRequired == actionRequired)&&(identical(other.suggestedAction, suggestedAction) || other.suggestedAction == suggestedAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,priority,title,description,actionRequired,suggestedAction);

@override
String toString() {
  return 'ProjectInsightItemDto(type: $type, priority: $priority, title: $title, description: $description, actionRequired: $actionRequired, suggestedAction: $suggestedAction)';
}


}

/// @nodoc
abstract mixin class $ProjectInsightItemDtoCopyWith<$Res>  {
  factory $ProjectInsightItemDtoCopyWith(ProjectInsightItemDto value, $Res Function(ProjectInsightItemDto) _then) = _$ProjectInsightItemDtoCopyWithImpl;
@useResult
$Res call({
 String? type, String? priority, String? title, String? description, bool? actionRequired, String? suggestedAction
});




}
/// @nodoc
class _$ProjectInsightItemDtoCopyWithImpl<$Res>
    implements $ProjectInsightItemDtoCopyWith<$Res> {
  _$ProjectInsightItemDtoCopyWithImpl(this._self, this._then);

  final ProjectInsightItemDto _self;
  final $Res Function(ProjectInsightItemDto) _then;

/// Create a copy of ProjectInsightItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? priority = freezed,Object? title = freezed,Object? description = freezed,Object? actionRequired = freezed,Object? suggestedAction = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,actionRequired: freezed == actionRequired ? _self.actionRequired : actionRequired // ignore: cast_nullable_to_non_nullable
as bool?,suggestedAction: freezed == suggestedAction ? _self.suggestedAction : suggestedAction // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectInsightItemDto].
extension ProjectInsightItemDtoPatterns on ProjectInsightItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectInsightItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectInsightItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectInsightItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ProjectInsightItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectInsightItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectInsightItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  String? priority,  String? title,  String? description,  bool? actionRequired,  String? suggestedAction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectInsightItemDto() when $default != null:
return $default(_that.type,_that.priority,_that.title,_that.description,_that.actionRequired,_that.suggestedAction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  String? priority,  String? title,  String? description,  bool? actionRequired,  String? suggestedAction)  $default,) {final _that = this;
switch (_that) {
case _ProjectInsightItemDto():
return $default(_that.type,_that.priority,_that.title,_that.description,_that.actionRequired,_that.suggestedAction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  String? priority,  String? title,  String? description,  bool? actionRequired,  String? suggestedAction)?  $default,) {final _that = this;
switch (_that) {
case _ProjectInsightItemDto() when $default != null:
return $default(_that.type,_that.priority,_that.title,_that.description,_that.actionRequired,_that.suggestedAction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectInsightItemDto implements ProjectInsightItemDto {
  const _ProjectInsightItemDto({this.type, this.priority, this.title, this.description, this.actionRequired, this.suggestedAction});
  factory _ProjectInsightItemDto.fromJson(Map<String, dynamic> json) => _$ProjectInsightItemDtoFromJson(json);

@override final  String? type;
@override final  String? priority;
@override final  String? title;
@override final  String? description;
@override final  bool? actionRequired;
@override final  String? suggestedAction;

/// Create a copy of ProjectInsightItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectInsightItemDtoCopyWith<_ProjectInsightItemDto> get copyWith => __$ProjectInsightItemDtoCopyWithImpl<_ProjectInsightItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectInsightItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectInsightItemDto&&(identical(other.type, type) || other.type == type)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.actionRequired, actionRequired) || other.actionRequired == actionRequired)&&(identical(other.suggestedAction, suggestedAction) || other.suggestedAction == suggestedAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,priority,title,description,actionRequired,suggestedAction);

@override
String toString() {
  return 'ProjectInsightItemDto(type: $type, priority: $priority, title: $title, description: $description, actionRequired: $actionRequired, suggestedAction: $suggestedAction)';
}


}

/// @nodoc
abstract mixin class _$ProjectInsightItemDtoCopyWith<$Res> implements $ProjectInsightItemDtoCopyWith<$Res> {
  factory _$ProjectInsightItemDtoCopyWith(_ProjectInsightItemDto value, $Res Function(_ProjectInsightItemDto) _then) = __$ProjectInsightItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? priority, String? title, String? description, bool? actionRequired, String? suggestedAction
});




}
/// @nodoc
class __$ProjectInsightItemDtoCopyWithImpl<$Res>
    implements _$ProjectInsightItemDtoCopyWith<$Res> {
  __$ProjectInsightItemDtoCopyWithImpl(this._self, this._then);

  final _ProjectInsightItemDto _self;
  final $Res Function(_ProjectInsightItemDto) _then;

/// Create a copy of ProjectInsightItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? priority = freezed,Object? title = freezed,Object? description = freezed,Object? actionRequired = freezed,Object? suggestedAction = freezed,}) {
  return _then(_ProjectInsightItemDto(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,actionRequired: freezed == actionRequired ? _self.actionRequired : actionRequired // ignore: cast_nullable_to_non_nullable
as bool?,suggestedAction: freezed == suggestedAction ? _self.suggestedAction : suggestedAction // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AiRecommendationDto {

 List<dynamic>? get suggestedCreators; List<dynamic>? get suggestedProjects; List<dynamic>? get suggestedSkills;
/// Create a copy of AiRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiRecommendationDtoCopyWith<AiRecommendationDto> get copyWith => _$AiRecommendationDtoCopyWithImpl<AiRecommendationDto>(this as AiRecommendationDto, _$identity);

  /// Serializes this AiRecommendationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiRecommendationDto&&const DeepCollectionEquality().equals(other.suggestedCreators, suggestedCreators)&&const DeepCollectionEquality().equals(other.suggestedProjects, suggestedProjects)&&const DeepCollectionEquality().equals(other.suggestedSkills, suggestedSkills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(suggestedCreators),const DeepCollectionEquality().hash(suggestedProjects),const DeepCollectionEquality().hash(suggestedSkills));

@override
String toString() {
  return 'AiRecommendationDto(suggestedCreators: $suggestedCreators, suggestedProjects: $suggestedProjects, suggestedSkills: $suggestedSkills)';
}


}

/// @nodoc
abstract mixin class $AiRecommendationDtoCopyWith<$Res>  {
  factory $AiRecommendationDtoCopyWith(AiRecommendationDto value, $Res Function(AiRecommendationDto) _then) = _$AiRecommendationDtoCopyWithImpl;
@useResult
$Res call({
 List<dynamic>? suggestedCreators, List<dynamic>? suggestedProjects, List<dynamic>? suggestedSkills
});




}
/// @nodoc
class _$AiRecommendationDtoCopyWithImpl<$Res>
    implements $AiRecommendationDtoCopyWith<$Res> {
  _$AiRecommendationDtoCopyWithImpl(this._self, this._then);

  final AiRecommendationDto _self;
  final $Res Function(AiRecommendationDto) _then;

/// Create a copy of AiRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestedCreators = freezed,Object? suggestedProjects = freezed,Object? suggestedSkills = freezed,}) {
  return _then(_self.copyWith(
suggestedCreators: freezed == suggestedCreators ? _self.suggestedCreators : suggestedCreators // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,suggestedProjects: freezed == suggestedProjects ? _self.suggestedProjects : suggestedProjects // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,suggestedSkills: freezed == suggestedSkills ? _self.suggestedSkills : suggestedSkills // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiRecommendationDto].
extension AiRecommendationDtoPatterns on AiRecommendationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiRecommendationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiRecommendationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiRecommendationDto value)  $default,){
final _that = this;
switch (_that) {
case _AiRecommendationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiRecommendationDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiRecommendationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<dynamic>? suggestedCreators,  List<dynamic>? suggestedProjects,  List<dynamic>? suggestedSkills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiRecommendationDto() when $default != null:
return $default(_that.suggestedCreators,_that.suggestedProjects,_that.suggestedSkills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<dynamic>? suggestedCreators,  List<dynamic>? suggestedProjects,  List<dynamic>? suggestedSkills)  $default,) {final _that = this;
switch (_that) {
case _AiRecommendationDto():
return $default(_that.suggestedCreators,_that.suggestedProjects,_that.suggestedSkills);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<dynamic>? suggestedCreators,  List<dynamic>? suggestedProjects,  List<dynamic>? suggestedSkills)?  $default,) {final _that = this;
switch (_that) {
case _AiRecommendationDto() when $default != null:
return $default(_that.suggestedCreators,_that.suggestedProjects,_that.suggestedSkills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiRecommendationDto implements AiRecommendationDto {
  const _AiRecommendationDto({final  List<dynamic>? suggestedCreators, final  List<dynamic>? suggestedProjects, final  List<dynamic>? suggestedSkills}): _suggestedCreators = suggestedCreators,_suggestedProjects = suggestedProjects,_suggestedSkills = suggestedSkills;
  factory _AiRecommendationDto.fromJson(Map<String, dynamic> json) => _$AiRecommendationDtoFromJson(json);

 final  List<dynamic>? _suggestedCreators;
@override List<dynamic>? get suggestedCreators {
  final value = _suggestedCreators;
  if (value == null) return null;
  if (_suggestedCreators is EqualUnmodifiableListView) return _suggestedCreators;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _suggestedProjects;
@override List<dynamic>? get suggestedProjects {
  final value = _suggestedProjects;
  if (value == null) return null;
  if (_suggestedProjects is EqualUnmodifiableListView) return _suggestedProjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<dynamic>? _suggestedSkills;
@override List<dynamic>? get suggestedSkills {
  final value = _suggestedSkills;
  if (value == null) return null;
  if (_suggestedSkills is EqualUnmodifiableListView) return _suggestedSkills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AiRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiRecommendationDtoCopyWith<_AiRecommendationDto> get copyWith => __$AiRecommendationDtoCopyWithImpl<_AiRecommendationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiRecommendationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiRecommendationDto&&const DeepCollectionEquality().equals(other._suggestedCreators, _suggestedCreators)&&const DeepCollectionEquality().equals(other._suggestedProjects, _suggestedProjects)&&const DeepCollectionEquality().equals(other._suggestedSkills, _suggestedSkills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestedCreators),const DeepCollectionEquality().hash(_suggestedProjects),const DeepCollectionEquality().hash(_suggestedSkills));

@override
String toString() {
  return 'AiRecommendationDto(suggestedCreators: $suggestedCreators, suggestedProjects: $suggestedProjects, suggestedSkills: $suggestedSkills)';
}


}

/// @nodoc
abstract mixin class _$AiRecommendationDtoCopyWith<$Res> implements $AiRecommendationDtoCopyWith<$Res> {
  factory _$AiRecommendationDtoCopyWith(_AiRecommendationDto value, $Res Function(_AiRecommendationDto) _then) = __$AiRecommendationDtoCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic>? suggestedCreators, List<dynamic>? suggestedProjects, List<dynamic>? suggestedSkills
});




}
/// @nodoc
class __$AiRecommendationDtoCopyWithImpl<$Res>
    implements _$AiRecommendationDtoCopyWith<$Res> {
  __$AiRecommendationDtoCopyWithImpl(this._self, this._then);

  final _AiRecommendationDto _self;
  final $Res Function(_AiRecommendationDto) _then;

/// Create a copy of AiRecommendationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestedCreators = freezed,Object? suggestedProjects = freezed,Object? suggestedSkills = freezed,}) {
  return _then(_AiRecommendationDto(
suggestedCreators: freezed == suggestedCreators ? _self._suggestedCreators : suggestedCreators // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,suggestedProjects: freezed == suggestedProjects ? _self._suggestedProjects : suggestedProjects // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,suggestedSkills: freezed == suggestedSkills ? _self._suggestedSkills : suggestedSkills // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$AiJobStatusDto {

 String? get jobId; String? get status; String? get templateId; double? get progress; int? get attemptsMade; Map<String, dynamic>? get result; String? get error; DateTime? get createdAt; DateTime? get processedAt; DateTime? get completedAt;
/// Create a copy of AiJobStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiJobStatusDtoCopyWith<AiJobStatusDto> get copyWith => _$AiJobStatusDtoCopyWithImpl<AiJobStatusDto>(this as AiJobStatusDto, _$identity);

  /// Serializes this AiJobStatusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiJobStatusDto&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.status, status) || other.status == status)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.attemptsMade, attemptsMade) || other.attemptsMade == attemptsMade)&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.error, error) || other.error == error)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobId,status,templateId,progress,attemptsMade,const DeepCollectionEquality().hash(result),error,createdAt,processedAt,completedAt);

@override
String toString() {
  return 'AiJobStatusDto(jobId: $jobId, status: $status, templateId: $templateId, progress: $progress, attemptsMade: $attemptsMade, result: $result, error: $error, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $AiJobStatusDtoCopyWith<$Res>  {
  factory $AiJobStatusDtoCopyWith(AiJobStatusDto value, $Res Function(AiJobStatusDto) _then) = _$AiJobStatusDtoCopyWithImpl;
@useResult
$Res call({
 String? jobId, String? status, String? templateId, double? progress, int? attemptsMade, Map<String, dynamic>? result, String? error, DateTime? createdAt, DateTime? processedAt, DateTime? completedAt
});




}
/// @nodoc
class _$AiJobStatusDtoCopyWithImpl<$Res>
    implements $AiJobStatusDtoCopyWith<$Res> {
  _$AiJobStatusDtoCopyWithImpl(this._self, this._then);

  final AiJobStatusDto _self;
  final $Res Function(AiJobStatusDto) _then;

/// Create a copy of AiJobStatusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobId = freezed,Object? status = freezed,Object? templateId = freezed,Object? progress = freezed,Object? attemptsMade = freezed,Object? result = freezed,Object? error = freezed,Object? createdAt = freezed,Object? processedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,attemptsMade: freezed == attemptsMade ? _self.attemptsMade : attemptsMade // ignore: cast_nullable_to_non_nullable
as int?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiJobStatusDto].
extension AiJobStatusDtoPatterns on AiJobStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiJobStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiJobStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiJobStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _AiJobStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiJobStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiJobStatusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? jobId,  String? status,  String? templateId,  double? progress,  int? attemptsMade,  Map<String, dynamic>? result,  String? error,  DateTime? createdAt,  DateTime? processedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiJobStatusDto() when $default != null:
return $default(_that.jobId,_that.status,_that.templateId,_that.progress,_that.attemptsMade,_that.result,_that.error,_that.createdAt,_that.processedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? jobId,  String? status,  String? templateId,  double? progress,  int? attemptsMade,  Map<String, dynamic>? result,  String? error,  DateTime? createdAt,  DateTime? processedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _AiJobStatusDto():
return $default(_that.jobId,_that.status,_that.templateId,_that.progress,_that.attemptsMade,_that.result,_that.error,_that.createdAt,_that.processedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? jobId,  String? status,  String? templateId,  double? progress,  int? attemptsMade,  Map<String, dynamic>? result,  String? error,  DateTime? createdAt,  DateTime? processedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _AiJobStatusDto() when $default != null:
return $default(_that.jobId,_that.status,_that.templateId,_that.progress,_that.attemptsMade,_that.result,_that.error,_that.createdAt,_that.processedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiJobStatusDto implements AiJobStatusDto {
  const _AiJobStatusDto({this.jobId, this.status, this.templateId, this.progress, this.attemptsMade, final  Map<String, dynamic>? result, this.error, this.createdAt, this.processedAt, this.completedAt}): _result = result;
  factory _AiJobStatusDto.fromJson(Map<String, dynamic> json) => _$AiJobStatusDtoFromJson(json);

@override final  String? jobId;
@override final  String? status;
@override final  String? templateId;
@override final  double? progress;
@override final  int? attemptsMade;
 final  Map<String, dynamic>? _result;
@override Map<String, dynamic>? get result {
  final value = _result;
  if (value == null) return null;
  if (_result is EqualUnmodifiableMapView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? error;
@override final  DateTime? createdAt;
@override final  DateTime? processedAt;
@override final  DateTime? completedAt;

/// Create a copy of AiJobStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiJobStatusDtoCopyWith<_AiJobStatusDto> get copyWith => __$AiJobStatusDtoCopyWithImpl<_AiJobStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiJobStatusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiJobStatusDto&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.status, status) || other.status == status)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.attemptsMade, attemptsMade) || other.attemptsMade == attemptsMade)&&const DeepCollectionEquality().equals(other._result, _result)&&(identical(other.error, error) || other.error == error)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobId,status,templateId,progress,attemptsMade,const DeepCollectionEquality().hash(_result),error,createdAt,processedAt,completedAt);

@override
String toString() {
  return 'AiJobStatusDto(jobId: $jobId, status: $status, templateId: $templateId, progress: $progress, attemptsMade: $attemptsMade, result: $result, error: $error, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$AiJobStatusDtoCopyWith<$Res> implements $AiJobStatusDtoCopyWith<$Res> {
  factory _$AiJobStatusDtoCopyWith(_AiJobStatusDto value, $Res Function(_AiJobStatusDto) _then) = __$AiJobStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 String? jobId, String? status, String? templateId, double? progress, int? attemptsMade, Map<String, dynamic>? result, String? error, DateTime? createdAt, DateTime? processedAt, DateTime? completedAt
});




}
/// @nodoc
class __$AiJobStatusDtoCopyWithImpl<$Res>
    implements _$AiJobStatusDtoCopyWith<$Res> {
  __$AiJobStatusDtoCopyWithImpl(this._self, this._then);

  final _AiJobStatusDto _self;
  final $Res Function(_AiJobStatusDto) _then;

/// Create a copy of AiJobStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobId = freezed,Object? status = freezed,Object? templateId = freezed,Object? progress = freezed,Object? attemptsMade = freezed,Object? result = freezed,Object? error = freezed,Object? createdAt = freezed,Object? processedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_AiJobStatusDto(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,attemptsMade: freezed == attemptsMade ? _self.attemptsMade : attemptsMade // ignore: cast_nullable_to_non_nullable
as int?,result: freezed == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$AiDashboardDto {

 AiDashboardOverviewDto? get overview; Map<String, dynamic>? get providers; Map<String, dynamic>? get templates; List<Map<String, dynamic>>? get recentErrors;
/// Create a copy of AiDashboardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiDashboardDtoCopyWith<AiDashboardDto> get copyWith => _$AiDashboardDtoCopyWithImpl<AiDashboardDto>(this as AiDashboardDto, _$identity);

  /// Serializes this AiDashboardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiDashboardDto&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other.providers, providers)&&const DeepCollectionEquality().equals(other.templates, templates)&&const DeepCollectionEquality().equals(other.recentErrors, recentErrors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overview,const DeepCollectionEquality().hash(providers),const DeepCollectionEquality().hash(templates),const DeepCollectionEquality().hash(recentErrors));

@override
String toString() {
  return 'AiDashboardDto(overview: $overview, providers: $providers, templates: $templates, recentErrors: $recentErrors)';
}


}

/// @nodoc
abstract mixin class $AiDashboardDtoCopyWith<$Res>  {
  factory $AiDashboardDtoCopyWith(AiDashboardDto value, $Res Function(AiDashboardDto) _then) = _$AiDashboardDtoCopyWithImpl;
@useResult
$Res call({
 AiDashboardOverviewDto? overview, Map<String, dynamic>? providers, Map<String, dynamic>? templates, List<Map<String, dynamic>>? recentErrors
});


$AiDashboardOverviewDtoCopyWith<$Res>? get overview;

}
/// @nodoc
class _$AiDashboardDtoCopyWithImpl<$Res>
    implements $AiDashboardDtoCopyWith<$Res> {
  _$AiDashboardDtoCopyWithImpl(this._self, this._then);

  final AiDashboardDto _self;
  final $Res Function(AiDashboardDto) _then;

/// Create a copy of AiDashboardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overview = freezed,Object? providers = freezed,Object? templates = freezed,Object? recentErrors = freezed,}) {
  return _then(_self.copyWith(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as AiDashboardOverviewDto?,providers: freezed == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,templates: freezed == templates ? _self.templates : templates // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,recentErrors: freezed == recentErrors ? _self.recentErrors : recentErrors // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}
/// Create a copy of AiDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiDashboardOverviewDtoCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $AiDashboardOverviewDtoCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiDashboardDto].
extension AiDashboardDtoPatterns on AiDashboardDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiDashboardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiDashboardDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiDashboardDto value)  $default,){
final _that = this;
switch (_that) {
case _AiDashboardDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiDashboardDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiDashboardDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiDashboardOverviewDto? overview,  Map<String, dynamic>? providers,  Map<String, dynamic>? templates,  List<Map<String, dynamic>>? recentErrors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiDashboardDto() when $default != null:
return $default(_that.overview,_that.providers,_that.templates,_that.recentErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiDashboardOverviewDto? overview,  Map<String, dynamic>? providers,  Map<String, dynamic>? templates,  List<Map<String, dynamic>>? recentErrors)  $default,) {final _that = this;
switch (_that) {
case _AiDashboardDto():
return $default(_that.overview,_that.providers,_that.templates,_that.recentErrors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiDashboardOverviewDto? overview,  Map<String, dynamic>? providers,  Map<String, dynamic>? templates,  List<Map<String, dynamic>>? recentErrors)?  $default,) {final _that = this;
switch (_that) {
case _AiDashboardDto() when $default != null:
return $default(_that.overview,_that.providers,_that.templates,_that.recentErrors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiDashboardDto implements AiDashboardDto {
  const _AiDashboardDto({this.overview, final  Map<String, dynamic>? providers, final  Map<String, dynamic>? templates, final  List<Map<String, dynamic>>? recentErrors}): _providers = providers,_templates = templates,_recentErrors = recentErrors;
  factory _AiDashboardDto.fromJson(Map<String, dynamic> json) => _$AiDashboardDtoFromJson(json);

@override final  AiDashboardOverviewDto? overview;
 final  Map<String, dynamic>? _providers;
@override Map<String, dynamic>? get providers {
  final value = _providers;
  if (value == null) return null;
  if (_providers is EqualUnmodifiableMapView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _templates;
@override Map<String, dynamic>? get templates {
  final value = _templates;
  if (value == null) return null;
  if (_templates is EqualUnmodifiableMapView) return _templates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _recentErrors;
@override List<Map<String, dynamic>>? get recentErrors {
  final value = _recentErrors;
  if (value == null) return null;
  if (_recentErrors is EqualUnmodifiableListView) return _recentErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AiDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiDashboardDtoCopyWith<_AiDashboardDto> get copyWith => __$AiDashboardDtoCopyWithImpl<_AiDashboardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiDashboardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiDashboardDto&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other._providers, _providers)&&const DeepCollectionEquality().equals(other._templates, _templates)&&const DeepCollectionEquality().equals(other._recentErrors, _recentErrors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overview,const DeepCollectionEquality().hash(_providers),const DeepCollectionEquality().hash(_templates),const DeepCollectionEquality().hash(_recentErrors));

@override
String toString() {
  return 'AiDashboardDto(overview: $overview, providers: $providers, templates: $templates, recentErrors: $recentErrors)';
}


}

/// @nodoc
abstract mixin class _$AiDashboardDtoCopyWith<$Res> implements $AiDashboardDtoCopyWith<$Res> {
  factory _$AiDashboardDtoCopyWith(_AiDashboardDto value, $Res Function(_AiDashboardDto) _then) = __$AiDashboardDtoCopyWithImpl;
@override @useResult
$Res call({
 AiDashboardOverviewDto? overview, Map<String, dynamic>? providers, Map<String, dynamic>? templates, List<Map<String, dynamic>>? recentErrors
});


@override $AiDashboardOverviewDtoCopyWith<$Res>? get overview;

}
/// @nodoc
class __$AiDashboardDtoCopyWithImpl<$Res>
    implements _$AiDashboardDtoCopyWith<$Res> {
  __$AiDashboardDtoCopyWithImpl(this._self, this._then);

  final _AiDashboardDto _self;
  final $Res Function(_AiDashboardDto) _then;

/// Create a copy of AiDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overview = freezed,Object? providers = freezed,Object? templates = freezed,Object? recentErrors = freezed,}) {
  return _then(_AiDashboardDto(
overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as AiDashboardOverviewDto?,providers: freezed == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,templates: freezed == templates ? _self._templates : templates // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,recentErrors: freezed == recentErrors ? _self._recentErrors : recentErrors // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}

/// Create a copy of AiDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiDashboardOverviewDtoCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $AiDashboardOverviewDtoCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}
}


/// @nodoc
mixin _$AiDashboardOverviewDto {

 int? get totalRequests; int? get totalTokens; String? get totalCost; String? get averageLatency; String? get errorRate; String? get cacheHitRate;
/// Create a copy of AiDashboardOverviewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiDashboardOverviewDtoCopyWith<AiDashboardOverviewDto> get copyWith => _$AiDashboardOverviewDtoCopyWithImpl<AiDashboardOverviewDto>(this as AiDashboardOverviewDto, _$identity);

  /// Serializes this AiDashboardOverviewDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiDashboardOverviewDto&&(identical(other.totalRequests, totalRequests) || other.totalRequests == totalRequests)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.averageLatency, averageLatency) || other.averageLatency == averageLatency)&&(identical(other.errorRate, errorRate) || other.errorRate == errorRate)&&(identical(other.cacheHitRate, cacheHitRate) || other.cacheHitRate == cacheHitRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRequests,totalTokens,totalCost,averageLatency,errorRate,cacheHitRate);

@override
String toString() {
  return 'AiDashboardOverviewDto(totalRequests: $totalRequests, totalTokens: $totalTokens, totalCost: $totalCost, averageLatency: $averageLatency, errorRate: $errorRate, cacheHitRate: $cacheHitRate)';
}


}

/// @nodoc
abstract mixin class $AiDashboardOverviewDtoCopyWith<$Res>  {
  factory $AiDashboardOverviewDtoCopyWith(AiDashboardOverviewDto value, $Res Function(AiDashboardOverviewDto) _then) = _$AiDashboardOverviewDtoCopyWithImpl;
@useResult
$Res call({
 int? totalRequests, int? totalTokens, String? totalCost, String? averageLatency, String? errorRate, String? cacheHitRate
});




}
/// @nodoc
class _$AiDashboardOverviewDtoCopyWithImpl<$Res>
    implements $AiDashboardOverviewDtoCopyWith<$Res> {
  _$AiDashboardOverviewDtoCopyWithImpl(this._self, this._then);

  final AiDashboardOverviewDto _self;
  final $Res Function(AiDashboardOverviewDto) _then;

/// Create a copy of AiDashboardOverviewDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRequests = freezed,Object? totalTokens = freezed,Object? totalCost = freezed,Object? averageLatency = freezed,Object? errorRate = freezed,Object? cacheHitRate = freezed,}) {
  return _then(_self.copyWith(
totalRequests: freezed == totalRequests ? _self.totalRequests : totalRequests // ignore: cast_nullable_to_non_nullable
as int?,totalTokens: freezed == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int?,totalCost: freezed == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as String?,averageLatency: freezed == averageLatency ? _self.averageLatency : averageLatency // ignore: cast_nullable_to_non_nullable
as String?,errorRate: freezed == errorRate ? _self.errorRate : errorRate // ignore: cast_nullable_to_non_nullable
as String?,cacheHitRate: freezed == cacheHitRate ? _self.cacheHitRate : cacheHitRate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiDashboardOverviewDto].
extension AiDashboardOverviewDtoPatterns on AiDashboardOverviewDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiDashboardOverviewDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiDashboardOverviewDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiDashboardOverviewDto value)  $default,){
final _that = this;
switch (_that) {
case _AiDashboardOverviewDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiDashboardOverviewDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiDashboardOverviewDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? totalRequests,  int? totalTokens,  String? totalCost,  String? averageLatency,  String? errorRate,  String? cacheHitRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiDashboardOverviewDto() when $default != null:
return $default(_that.totalRequests,_that.totalTokens,_that.totalCost,_that.averageLatency,_that.errorRate,_that.cacheHitRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? totalRequests,  int? totalTokens,  String? totalCost,  String? averageLatency,  String? errorRate,  String? cacheHitRate)  $default,) {final _that = this;
switch (_that) {
case _AiDashboardOverviewDto():
return $default(_that.totalRequests,_that.totalTokens,_that.totalCost,_that.averageLatency,_that.errorRate,_that.cacheHitRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? totalRequests,  int? totalTokens,  String? totalCost,  String? averageLatency,  String? errorRate,  String? cacheHitRate)?  $default,) {final _that = this;
switch (_that) {
case _AiDashboardOverviewDto() when $default != null:
return $default(_that.totalRequests,_that.totalTokens,_that.totalCost,_that.averageLatency,_that.errorRate,_that.cacheHitRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiDashboardOverviewDto implements AiDashboardOverviewDto {
  const _AiDashboardOverviewDto({this.totalRequests, this.totalTokens, this.totalCost, this.averageLatency, this.errorRate, this.cacheHitRate});
  factory _AiDashboardOverviewDto.fromJson(Map<String, dynamic> json) => _$AiDashboardOverviewDtoFromJson(json);

@override final  int? totalRequests;
@override final  int? totalTokens;
@override final  String? totalCost;
@override final  String? averageLatency;
@override final  String? errorRate;
@override final  String? cacheHitRate;

/// Create a copy of AiDashboardOverviewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiDashboardOverviewDtoCopyWith<_AiDashboardOverviewDto> get copyWith => __$AiDashboardOverviewDtoCopyWithImpl<_AiDashboardOverviewDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiDashboardOverviewDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiDashboardOverviewDto&&(identical(other.totalRequests, totalRequests) || other.totalRequests == totalRequests)&&(identical(other.totalTokens, totalTokens) || other.totalTokens == totalTokens)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.averageLatency, averageLatency) || other.averageLatency == averageLatency)&&(identical(other.errorRate, errorRate) || other.errorRate == errorRate)&&(identical(other.cacheHitRate, cacheHitRate) || other.cacheHitRate == cacheHitRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRequests,totalTokens,totalCost,averageLatency,errorRate,cacheHitRate);

@override
String toString() {
  return 'AiDashboardOverviewDto(totalRequests: $totalRequests, totalTokens: $totalTokens, totalCost: $totalCost, averageLatency: $averageLatency, errorRate: $errorRate, cacheHitRate: $cacheHitRate)';
}


}

/// @nodoc
abstract mixin class _$AiDashboardOverviewDtoCopyWith<$Res> implements $AiDashboardOverviewDtoCopyWith<$Res> {
  factory _$AiDashboardOverviewDtoCopyWith(_AiDashboardOverviewDto value, $Res Function(_AiDashboardOverviewDto) _then) = __$AiDashboardOverviewDtoCopyWithImpl;
@override @useResult
$Res call({
 int? totalRequests, int? totalTokens, String? totalCost, String? averageLatency, String? errorRate, String? cacheHitRate
});




}
/// @nodoc
class __$AiDashboardOverviewDtoCopyWithImpl<$Res>
    implements _$AiDashboardOverviewDtoCopyWith<$Res> {
  __$AiDashboardOverviewDtoCopyWithImpl(this._self, this._then);

  final _AiDashboardOverviewDto _self;
  final $Res Function(_AiDashboardOverviewDto) _then;

/// Create a copy of AiDashboardOverviewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRequests = freezed,Object? totalTokens = freezed,Object? totalCost = freezed,Object? averageLatency = freezed,Object? errorRate = freezed,Object? cacheHitRate = freezed,}) {
  return _then(_AiDashboardOverviewDto(
totalRequests: freezed == totalRequests ? _self.totalRequests : totalRequests // ignore: cast_nullable_to_non_nullable
as int?,totalTokens: freezed == totalTokens ? _self.totalTokens : totalTokens // ignore: cast_nullable_to_non_nullable
as int?,totalCost: freezed == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as String?,averageLatency: freezed == averageLatency ? _self.averageLatency : averageLatency // ignore: cast_nullable_to_non_nullable
as String?,errorRate: freezed == errorRate ? _self.errorRate : errorRate // ignore: cast_nullable_to_non_nullable
as String?,cacheHitRate: freezed == cacheHitRate ? _self.cacheHitRate : cacheHitRate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AiUsageStatsDto {

 int get requests; int get tokens; double get cost;
/// Create a copy of AiUsageStatsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiUsageStatsDtoCopyWith<AiUsageStatsDto> get copyWith => _$AiUsageStatsDtoCopyWithImpl<AiUsageStatsDto>(this as AiUsageStatsDto, _$identity);

  /// Serializes this AiUsageStatsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiUsageStatsDto&&(identical(other.requests, requests) || other.requests == requests)&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.cost, cost) || other.cost == cost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requests,tokens,cost);

@override
String toString() {
  return 'AiUsageStatsDto(requests: $requests, tokens: $tokens, cost: $cost)';
}


}

/// @nodoc
abstract mixin class $AiUsageStatsDtoCopyWith<$Res>  {
  factory $AiUsageStatsDtoCopyWith(AiUsageStatsDto value, $Res Function(AiUsageStatsDto) _then) = _$AiUsageStatsDtoCopyWithImpl;
@useResult
$Res call({
 int requests, int tokens, double cost
});




}
/// @nodoc
class _$AiUsageStatsDtoCopyWithImpl<$Res>
    implements $AiUsageStatsDtoCopyWith<$Res> {
  _$AiUsageStatsDtoCopyWithImpl(this._self, this._then);

  final AiUsageStatsDto _self;
  final $Res Function(AiUsageStatsDto) _then;

/// Create a copy of AiUsageStatsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requests = null,Object? tokens = null,Object? cost = null,}) {
  return _then(_self.copyWith(
requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as int,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as int,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AiUsageStatsDto].
extension AiUsageStatsDtoPatterns on AiUsageStatsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiUsageStatsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiUsageStatsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiUsageStatsDto value)  $default,){
final _that = this;
switch (_that) {
case _AiUsageStatsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiUsageStatsDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiUsageStatsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int requests,  int tokens,  double cost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiUsageStatsDto() when $default != null:
return $default(_that.requests,_that.tokens,_that.cost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int requests,  int tokens,  double cost)  $default,) {final _that = this;
switch (_that) {
case _AiUsageStatsDto():
return $default(_that.requests,_that.tokens,_that.cost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int requests,  int tokens,  double cost)?  $default,) {final _that = this;
switch (_that) {
case _AiUsageStatsDto() when $default != null:
return $default(_that.requests,_that.tokens,_that.cost);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiUsageStatsDto implements AiUsageStatsDto {
  const _AiUsageStatsDto({this.requests = 0, this.tokens = 0, this.cost = 0});
  factory _AiUsageStatsDto.fromJson(Map<String, dynamic> json) => _$AiUsageStatsDtoFromJson(json);

@override@JsonKey() final  int requests;
@override@JsonKey() final  int tokens;
@override@JsonKey() final  double cost;

/// Create a copy of AiUsageStatsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiUsageStatsDtoCopyWith<_AiUsageStatsDto> get copyWith => __$AiUsageStatsDtoCopyWithImpl<_AiUsageStatsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiUsageStatsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiUsageStatsDto&&(identical(other.requests, requests) || other.requests == requests)&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.cost, cost) || other.cost == cost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requests,tokens,cost);

@override
String toString() {
  return 'AiUsageStatsDto(requests: $requests, tokens: $tokens, cost: $cost)';
}


}

/// @nodoc
abstract mixin class _$AiUsageStatsDtoCopyWith<$Res> implements $AiUsageStatsDtoCopyWith<$Res> {
  factory _$AiUsageStatsDtoCopyWith(_AiUsageStatsDto value, $Res Function(_AiUsageStatsDto) _then) = __$AiUsageStatsDtoCopyWithImpl;
@override @useResult
$Res call({
 int requests, int tokens, double cost
});




}
/// @nodoc
class __$AiUsageStatsDtoCopyWithImpl<$Res>
    implements _$AiUsageStatsDtoCopyWith<$Res> {
  __$AiUsageStatsDtoCopyWithImpl(this._self, this._then);

  final _AiUsageStatsDto _self;
  final $Res Function(_AiUsageStatsDto) _then;

/// Create a copy of AiUsageStatsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requests = null,Object? tokens = null,Object? cost = null,}) {
  return _then(_AiUsageStatsDto(
requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as int,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as int,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$AiProviderInfoDto {

 List<String>? get providers; Map<String, dynamic>? get health;
/// Create a copy of AiProviderInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiProviderInfoDtoCopyWith<AiProviderInfoDto> get copyWith => _$AiProviderInfoDtoCopyWithImpl<AiProviderInfoDto>(this as AiProviderInfoDto, _$identity);

  /// Serializes this AiProviderInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiProviderInfoDto&&const DeepCollectionEquality().equals(other.providers, providers)&&const DeepCollectionEquality().equals(other.health, health));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(providers),const DeepCollectionEquality().hash(health));

@override
String toString() {
  return 'AiProviderInfoDto(providers: $providers, health: $health)';
}


}

/// @nodoc
abstract mixin class $AiProviderInfoDtoCopyWith<$Res>  {
  factory $AiProviderInfoDtoCopyWith(AiProviderInfoDto value, $Res Function(AiProviderInfoDto) _then) = _$AiProviderInfoDtoCopyWithImpl;
@useResult
$Res call({
 List<String>? providers, Map<String, dynamic>? health
});




}
/// @nodoc
class _$AiProviderInfoDtoCopyWithImpl<$Res>
    implements $AiProviderInfoDtoCopyWith<$Res> {
  _$AiProviderInfoDtoCopyWithImpl(this._self, this._then);

  final AiProviderInfoDto _self;
  final $Res Function(AiProviderInfoDto) _then;

/// Create a copy of AiProviderInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providers = freezed,Object? health = freezed,}) {
  return _then(_self.copyWith(
providers: freezed == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<String>?,health: freezed == health ? _self.health : health // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiProviderInfoDto].
extension AiProviderInfoDtoPatterns on AiProviderInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiProviderInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiProviderInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiProviderInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _AiProviderInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiProviderInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _AiProviderInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String>? providers,  Map<String, dynamic>? health)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiProviderInfoDto() when $default != null:
return $default(_that.providers,_that.health);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String>? providers,  Map<String, dynamic>? health)  $default,) {final _that = this;
switch (_that) {
case _AiProviderInfoDto():
return $default(_that.providers,_that.health);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String>? providers,  Map<String, dynamic>? health)?  $default,) {final _that = this;
switch (_that) {
case _AiProviderInfoDto() when $default != null:
return $default(_that.providers,_that.health);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiProviderInfoDto implements AiProviderInfoDto {
  const _AiProviderInfoDto({final  List<String>? providers, final  Map<String, dynamic>? health}): _providers = providers,_health = health;
  factory _AiProviderInfoDto.fromJson(Map<String, dynamic> json) => _$AiProviderInfoDtoFromJson(json);

 final  List<String>? _providers;
@override List<String>? get providers {
  final value = _providers;
  if (value == null) return null;
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _health;
@override Map<String, dynamic>? get health {
  final value = _health;
  if (value == null) return null;
  if (_health is EqualUnmodifiableMapView) return _health;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AiProviderInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiProviderInfoDtoCopyWith<_AiProviderInfoDto> get copyWith => __$AiProviderInfoDtoCopyWithImpl<_AiProviderInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiProviderInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiProviderInfoDto&&const DeepCollectionEquality().equals(other._providers, _providers)&&const DeepCollectionEquality().equals(other._health, _health));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_providers),const DeepCollectionEquality().hash(_health));

@override
String toString() {
  return 'AiProviderInfoDto(providers: $providers, health: $health)';
}


}

/// @nodoc
abstract mixin class _$AiProviderInfoDtoCopyWith<$Res> implements $AiProviderInfoDtoCopyWith<$Res> {
  factory _$AiProviderInfoDtoCopyWith(_AiProviderInfoDto value, $Res Function(_AiProviderInfoDto) _then) = __$AiProviderInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 List<String>? providers, Map<String, dynamic>? health
});




}
/// @nodoc
class __$AiProviderInfoDtoCopyWithImpl<$Res>
    implements _$AiProviderInfoDtoCopyWith<$Res> {
  __$AiProviderInfoDtoCopyWithImpl(this._self, this._then);

  final _AiProviderInfoDto _self;
  final $Res Function(_AiProviderInfoDto) _then;

/// Create a copy of AiProviderInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providers = freezed,Object? health = freezed,}) {
  return _then(_AiProviderInfoDto(
providers: freezed == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<String>?,health: freezed == health ? _self._health : health // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
