// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectsListState {

 List<ProjectDto> get projects; bool get isLoading; bool get isLoadingMore; bool get hasError; String? get errorMessage; int get currentPage; bool get hasMore;
/// Create a copy of ProjectsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectsListStateCopyWith<ProjectsListState> get copyWith => _$ProjectsListStateCopyWithImpl<ProjectsListState>(this as ProjectsListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectsListState&&const DeepCollectionEquality().equals(other.projects, projects)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(projects),isLoading,isLoadingMore,hasError,errorMessage,currentPage,hasMore);

@override
String toString() {
  return 'ProjectsListState(projects: $projects, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasError: $hasError, errorMessage: $errorMessage, currentPage: $currentPage, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $ProjectsListStateCopyWith<$Res>  {
  factory $ProjectsListStateCopyWith(ProjectsListState value, $Res Function(ProjectsListState) _then) = _$ProjectsListStateCopyWithImpl;
@useResult
$Res call({
 List<ProjectDto> projects, bool isLoading, bool isLoadingMore, bool hasError, String? errorMessage, int currentPage, bool hasMore
});




}
/// @nodoc
class _$ProjectsListStateCopyWithImpl<$Res>
    implements $ProjectsListStateCopyWith<$Res> {
  _$ProjectsListStateCopyWithImpl(this._self, this._then);

  final ProjectsListState _self;
  final $Res Function(ProjectsListState) _then;

/// Create a copy of ProjectsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projects = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasError = null,Object? errorMessage = freezed,Object? currentPage = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectDto>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectsListState].
extension ProjectsListStatePatterns on ProjectsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectsListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectsListState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectsListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectsListState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectsListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProjectDto> projects,  bool isLoading,  bool isLoadingMore,  bool hasError,  String? errorMessage,  int currentPage,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectsListState() when $default != null:
return $default(_that.projects,_that.isLoading,_that.isLoadingMore,_that.hasError,_that.errorMessage,_that.currentPage,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProjectDto> projects,  bool isLoading,  bool isLoadingMore,  bool hasError,  String? errorMessage,  int currentPage,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _ProjectsListState():
return $default(_that.projects,_that.isLoading,_that.isLoadingMore,_that.hasError,_that.errorMessage,_that.currentPage,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProjectDto> projects,  bool isLoading,  bool isLoadingMore,  bool hasError,  String? errorMessage,  int currentPage,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _ProjectsListState() when $default != null:
return $default(_that.projects,_that.isLoading,_that.isLoadingMore,_that.hasError,_that.errorMessage,_that.currentPage,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectsListState implements ProjectsListState {
  const _ProjectsListState({final  List<ProjectDto> projects = const [], this.isLoading = false, this.isLoadingMore = false, this.hasError = false, this.errorMessage, this.currentPage = 1, this.hasMore = true}): _projects = projects;
  

 final  List<ProjectDto> _projects;
@override@JsonKey() List<ProjectDto> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasError;
@override final  String? errorMessage;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool hasMore;

/// Create a copy of ProjectsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectsListStateCopyWith<_ProjectsListState> get copyWith => __$ProjectsListStateCopyWithImpl<_ProjectsListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectsListState&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_projects),isLoading,isLoadingMore,hasError,errorMessage,currentPage,hasMore);

@override
String toString() {
  return 'ProjectsListState(projects: $projects, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasError: $hasError, errorMessage: $errorMessage, currentPage: $currentPage, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$ProjectsListStateCopyWith<$Res> implements $ProjectsListStateCopyWith<$Res> {
  factory _$ProjectsListStateCopyWith(_ProjectsListState value, $Res Function(_ProjectsListState) _then) = __$ProjectsListStateCopyWithImpl;
@override @useResult
$Res call({
 List<ProjectDto> projects, bool isLoading, bool isLoadingMore, bool hasError, String? errorMessage, int currentPage, bool hasMore
});




}
/// @nodoc
class __$ProjectsListStateCopyWithImpl<$Res>
    implements _$ProjectsListStateCopyWith<$Res> {
  __$ProjectsListStateCopyWithImpl(this._self, this._then);

  final _ProjectsListState _self;
  final $Res Function(_ProjectsListState) _then;

/// Create a copy of ProjectsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projects = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasError = null,Object? errorMessage = freezed,Object? currentPage = null,Object? hasMore = null,}) {
  return _then(_ProjectsListState(
projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectDto>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ProjectDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailState()';
}


}

/// @nodoc
class $ProjectDetailStateCopyWith<$Res>  {
$ProjectDetailStateCopyWith(ProjectDetailState _, $Res Function(ProjectDetailState) __);
}


/// Adds pattern-matching-related methods to [ProjectDetailState].
extension ProjectDetailStatePatterns on ProjectDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PDInitial value)?  initial,TResult Function( _PDLoading value)?  loading,TResult Function( _PDLoaded value)?  loaded,TResult Function( _PDError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PDInitial() when initial != null:
return initial(_that);case _PDLoading() when loading != null:
return loading(_that);case _PDLoaded() when loaded != null:
return loaded(_that);case _PDError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PDInitial value)  initial,required TResult Function( _PDLoading value)  loading,required TResult Function( _PDLoaded value)  loaded,required TResult Function( _PDError value)  error,}){
final _that = this;
switch (_that) {
case _PDInitial():
return initial(_that);case _PDLoading():
return loading(_that);case _PDLoaded():
return loaded(_that);case _PDError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PDInitial value)?  initial,TResult? Function( _PDLoading value)?  loading,TResult? Function( _PDLoaded value)?  loaded,TResult? Function( _PDError value)?  error,}){
final _that = this;
switch (_that) {
case _PDInitial() when initial != null:
return initial(_that);case _PDLoading() when loading != null:
return loading(_that);case _PDLoaded() when loaded != null:
return loaded(_that);case _PDError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ProjectDto project)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PDInitial() when initial != null:
return initial();case _PDLoading() when loading != null:
return loading();case _PDLoaded() when loaded != null:
return loaded(_that.project);case _PDError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ProjectDto project)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _PDInitial():
return initial();case _PDLoading():
return loading();case _PDLoaded():
return loaded(_that.project);case _PDError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ProjectDto project)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _PDInitial() when initial != null:
return initial();case _PDLoading() when loading != null:
return loading();case _PDLoaded() when loaded != null:
return loaded(_that.project);case _PDError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _PDInitial implements ProjectDetailState {
  const _PDInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PDInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailState.initial()';
}


}




/// @nodoc


class _PDLoading implements ProjectDetailState {
  const _PDLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PDLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProjectDetailState.loading()';
}


}




/// @nodoc


class _PDLoaded implements ProjectDetailState {
  const _PDLoaded(this.project);
  

 final  ProjectDto project;

/// Create a copy of ProjectDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PDLoadedCopyWith<_PDLoaded> get copyWith => __$PDLoadedCopyWithImpl<_PDLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PDLoaded&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,project);

@override
String toString() {
  return 'ProjectDetailState.loaded(project: $project)';
}


}

/// @nodoc
abstract mixin class _$PDLoadedCopyWith<$Res> implements $ProjectDetailStateCopyWith<$Res> {
  factory _$PDLoadedCopyWith(_PDLoaded value, $Res Function(_PDLoaded) _then) = __$PDLoadedCopyWithImpl;
@useResult
$Res call({
 ProjectDto project
});


$ProjectDtoCopyWith<$Res> get project;

}
/// @nodoc
class __$PDLoadedCopyWithImpl<$Res>
    implements _$PDLoadedCopyWith<$Res> {
  __$PDLoadedCopyWithImpl(this._self, this._then);

  final _PDLoaded _self;
  final $Res Function(_PDLoaded) _then;

/// Create a copy of ProjectDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? project = null,}) {
  return _then(_PDLoaded(
null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as ProjectDto,
  ));
}

/// Create a copy of ProjectDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectDtoCopyWith<$Res> get project {
  
  return $ProjectDtoCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

/// @nodoc


class _PDError implements ProjectDetailState {
  const _PDError(this.message);
  

 final  String message;

/// Create a copy of ProjectDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PDErrorCopyWith<_PDError> get copyWith => __$PDErrorCopyWithImpl<_PDError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PDError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProjectDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$PDErrorCopyWith<$Res> implements $ProjectDetailStateCopyWith<$Res> {
  factory _$PDErrorCopyWith(_PDError value, $Res Function(_PDError) _then) = __$PDErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$PDErrorCopyWithImpl<$Res>
    implements _$PDErrorCopyWith<$Res> {
  __$PDErrorCopyWithImpl(this._self, this._then);

  final _PDError _self;
  final $Res Function(_PDError) _then;

/// Create a copy of ProjectDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_PDError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
