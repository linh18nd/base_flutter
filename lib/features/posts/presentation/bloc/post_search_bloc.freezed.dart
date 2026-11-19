// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostSearchState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PostSearchState()';
}


}

/// @nodoc
class $PostSearchStateCopyWith<$Res>  {
$PostSearchStateCopyWith(PostSearchState _, $Res Function(PostSearchState) __);
}


/// Adds pattern-matching-related methods to [PostSearchState].
extension PostSearchStatePatterns on PostSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PostSearchIdle value)?  idle,TResult Function( PostSearchLoading value)?  loading,TResult Function( PostSearchLoaded value)?  loaded,TResult Function( PostSearchFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PostSearchIdle() when idle != null:
return idle(_that);case PostSearchLoading() when loading != null:
return loading(_that);case PostSearchLoaded() when loaded != null:
return loaded(_that);case PostSearchFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PostSearchIdle value)  idle,required TResult Function( PostSearchLoading value)  loading,required TResult Function( PostSearchLoaded value)  loaded,required TResult Function( PostSearchFailure value)  failure,}){
final _that = this;
switch (_that) {
case PostSearchIdle():
return idle(_that);case PostSearchLoading():
return loading(_that);case PostSearchLoaded():
return loaded(_that);case PostSearchFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PostSearchIdle value)?  idle,TResult? Function( PostSearchLoading value)?  loading,TResult? Function( PostSearchLoaded value)?  loaded,TResult? Function( PostSearchFailure value)?  failure,}){
final _that = this;
switch (_that) {
case PostSearchIdle() when idle != null:
return idle(_that);case PostSearchLoading() when loading != null:
return loading(_that);case PostSearchLoaded() when loaded != null:
return loaded(_that);case PostSearchFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( String query)?  loading,TResult Function( String query,  List<Post> posts)?  loaded,TResult Function( String query,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PostSearchIdle() when idle != null:
return idle();case PostSearchLoading() when loading != null:
return loading(_that.query);case PostSearchLoaded() when loaded != null:
return loaded(_that.query,_that.posts);case PostSearchFailure() when failure != null:
return failure(_that.query,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( String query)  loading,required TResult Function( String query,  List<Post> posts)  loaded,required TResult Function( String query,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case PostSearchIdle():
return idle();case PostSearchLoading():
return loading(_that.query);case PostSearchLoaded():
return loaded(_that.query,_that.posts);case PostSearchFailure():
return failure(_that.query,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( String query)?  loading,TResult? Function( String query,  List<Post> posts)?  loaded,TResult? Function( String query,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case PostSearchIdle() when idle != null:
return idle();case PostSearchLoading() when loading != null:
return loading(_that.query);case PostSearchLoaded() when loaded != null:
return loaded(_that.query,_that.posts);case PostSearchFailure() when failure != null:
return failure(_that.query,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class PostSearchIdle implements PostSearchState {
  const PostSearchIdle();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSearchIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PostSearchState.idle()';
}


}




/// @nodoc


class PostSearchLoading implements PostSearchState {
  const PostSearchLoading(this.query);
  

 final  String query;

/// Create a copy of PostSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSearchLoadingCopyWith<PostSearchLoading> get copyWith => _$PostSearchLoadingCopyWithImpl<PostSearchLoading>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSearchLoading&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'PostSearchState.loading(query: $query)';
}


}

/// @nodoc
abstract mixin class $PostSearchLoadingCopyWith<$Res> implements $PostSearchStateCopyWith<$Res> {
  factory $PostSearchLoadingCopyWith(PostSearchLoading value, $Res Function(PostSearchLoading) _then) = _$PostSearchLoadingCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$PostSearchLoadingCopyWithImpl<$Res>
    implements $PostSearchLoadingCopyWith<$Res> {
  _$PostSearchLoadingCopyWithImpl(this._self, this._then);

  final PostSearchLoading _self;
  final $Res Function(PostSearchLoading) _then;

/// Create a copy of PostSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(PostSearchLoading(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PostSearchLoaded implements PostSearchState {
  const PostSearchLoaded({required this.query, required  List<Post> posts}): _posts = posts;
  

 final  String query;
 final  List<Post> _posts;
 List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of PostSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSearchLoadedCopyWith<PostSearchLoaded> get copyWith => _$PostSearchLoadedCopyWithImpl<PostSearchLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSearchLoaded&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.posts, _posts));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_posts));
}

@override
String toString() {
    return 'PostSearchState.loaded(query: $query, posts: $posts)';
}


}

/// @nodoc
abstract mixin class $PostSearchLoadedCopyWith<$Res> implements $PostSearchStateCopyWith<$Res> {
  factory $PostSearchLoadedCopyWith(PostSearchLoaded value, $Res Function(PostSearchLoaded) _then) = _$PostSearchLoadedCopyWithImpl;
@useResult
$Res call({
 String query, List<Post> posts
});




}
/// @nodoc
class _$PostSearchLoadedCopyWithImpl<$Res>
    implements $PostSearchLoadedCopyWith<$Res> {
  _$PostSearchLoadedCopyWithImpl(this._self, this._then);

  final PostSearchLoaded _self;
  final $Res Function(PostSearchLoaded) _then;

/// Create a copy of PostSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,Object? posts = null,}) {
  return _then(PostSearchLoaded(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}

/// @nodoc


class PostSearchFailure implements PostSearchState {
  const PostSearchFailure({required this.query, required this.failure});
  

 final  String query;
 final  Failure failure;

/// Create a copy of PostSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostSearchFailureCopyWith<PostSearchFailure> get copyWith => _$PostSearchFailureCopyWithImpl<PostSearchFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostSearchFailure&&(identical(other.query, query) || other.query == query)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,failure);
}

@override
String toString() {
    return 'PostSearchState.failure(query: $query, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $PostSearchFailureCopyWith<$Res> implements $PostSearchStateCopyWith<$Res> {
  factory $PostSearchFailureCopyWith(PostSearchFailure value, $Res Function(PostSearchFailure) _then) = _$PostSearchFailureCopyWithImpl;
@useResult
$Res call({
 String query, Failure failure
});




}
/// @nodoc
class _$PostSearchFailureCopyWithImpl<$Res>
    implements $PostSearchFailureCopyWith<$Res> {
  _$PostSearchFailureCopyWithImpl(this._self, this._then);

  final PostSearchFailure _self;
  final $Res Function(PostSearchFailure) _then;

/// Create a copy of PostSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,Object? failure = null,}) {
  return _then(PostSearchFailure(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
