// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PostsState()';
}


}

/// @nodoc
class $PostsStateCopyWith<$Res>  {
$PostsStateCopyWith(PostsState _, $Res Function(PostsState) __);
}


/// Adds pattern-matching-related methods to [PostsState].
extension PostsStatePatterns on PostsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PostsInitial value)?  initial,TResult Function( PostsLoading value)?  loading,TResult Function( PostsLoaded value)?  loaded,TResult Function( PostsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PostsInitial() when initial != null:
return initial(_that);case PostsLoading() when loading != null:
return loading(_that);case PostsLoaded() when loaded != null:
return loaded(_that);case PostsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PostsInitial value)  initial,required TResult Function( PostsLoading value)  loading,required TResult Function( PostsLoaded value)  loaded,required TResult Function( PostsFailure value)  failure,}){
final _that = this;
switch (_that) {
case PostsInitial():
return initial(_that);case PostsLoading():
return loading(_that);case PostsLoaded():
return loaded(_that);case PostsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PostsInitial value)?  initial,TResult? Function( PostsLoading value)?  loading,TResult? Function( PostsLoaded value)?  loaded,TResult? Function( PostsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case PostsInitial() when initial != null:
return initial(_that);case PostsLoading() when loading != null:
return loading(_that);case PostsLoaded() when loaded != null:
return loaded(_that);case PostsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Post> posts)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PostsInitial() when initial != null:
return initial();case PostsLoading() when loading != null:
return loading();case PostsLoaded() when loaded != null:
return loaded(_that.posts);case PostsFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Post> posts)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case PostsInitial():
return initial();case PostsLoading():
return loading();case PostsLoaded():
return loaded(_that.posts);case PostsFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Post> posts)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case PostsInitial() when initial != null:
return initial();case PostsLoading() when loading != null:
return loading();case PostsLoaded() when loaded != null:
return loaded(_that.posts);case PostsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class PostsInitial implements PostsState {
  const PostsInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PostsState.initial()';
}


}




/// @nodoc


class PostsLoading implements PostsState {
  const PostsLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PostsState.loading()';
}


}




/// @nodoc


class PostsLoaded implements PostsState {
  const PostsLoaded( List<Post> posts): _posts = posts;
  

 final  List<Post> _posts;
 List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of PostsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostsLoadedCopyWith<PostsLoaded> get copyWith => _$PostsLoadedCopyWithImpl<PostsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostsLoaded&&const DeepCollectionEquality().equals(other.posts, _posts));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts));
}

@override
String toString() {
    return 'PostsState.loaded(posts: $posts)';
}


}

/// @nodoc
abstract mixin class $PostsLoadedCopyWith<$Res> implements $PostsStateCopyWith<$Res> {
  factory $PostsLoadedCopyWith(PostsLoaded value, $Res Function(PostsLoaded) _then) = _$PostsLoadedCopyWithImpl;
@useResult
$Res call({
 List<Post> posts
});




}
/// @nodoc
class _$PostsLoadedCopyWithImpl<$Res>
    implements $PostsLoadedCopyWith<$Res> {
  _$PostsLoadedCopyWithImpl(this._self, this._then);

  final PostsLoaded _self;
  final $Res Function(PostsLoaded) _then;

/// Create a copy of PostsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? posts = null,}) {
  return _then(PostsLoaded(
null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}

/// @nodoc


class PostsFailure implements PostsState {
  const PostsFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of PostsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostsFailureCopyWith<PostsFailure> get copyWith => _$PostsFailureCopyWithImpl<PostsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PostsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'PostsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $PostsFailureCopyWith<$Res> implements $PostsStateCopyWith<$Res> {
  factory $PostsFailureCopyWith(PostsFailure value, $Res Function(PostsFailure) _then) = _$PostsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$PostsFailureCopyWithImpl<$Res>
    implements $PostsFailureCopyWith<$Res> {
  _$PostsFailureCopyWithImpl(this._self, this._then);

  final PostsFailure _self;
  final $Res Function(PostsFailure) _then;

/// Create a copy of PostsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(PostsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
