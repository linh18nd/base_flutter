// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PagedState<T> {

 PagedStatus get status; List<T> get items;/// Last page loaded successfully.
 int get page; bool get hasReachedEnd; bool get isLoadingMore;/// Error of the last request. With [PagedStatus.success] it means
/// loading the next page failed while the current items stay visible.
 Failure? get failure;
/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedStateCopyWith<T, PagedState<T>> get copyWith => _$PagedStateCopyWithImpl<T, PagedState<T>>(this as PagedState<T>, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PagedState<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedState<T>&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasReachedEnd, _this.hasReachedEnd) || other.hasReachedEnd == _this.hasReachedEnd)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PagedState<T>;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.items),_this.page,_this.hasReachedEnd,_this.isLoadingMore,_this.failure);
}

@override
String toString() {
  final _this = this as PagedState<T>;
  return 'PagedState<$T>(status: ${_this.status}, items: ${_this.items}, page: ${_this.page}, hasReachedEnd: ${_this.hasReachedEnd}, isLoadingMore: ${_this.isLoadingMore}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PagedStateCopyWith<T,$Res>  {
  factory $PagedStateCopyWith(PagedState<T> value, $Res Function(PagedState<T>) _then) = _$PagedStateCopyWithImpl;
@useResult
$Res call({
 PagedStatus status, List<T> items, int page, bool hasReachedEnd, bool isLoadingMore, Failure? failure
});




}
/// @nodoc
class _$PagedStateCopyWithImpl<T,$Res>
    implements $PagedStateCopyWith<T, $Res> {
  _$PagedStateCopyWithImpl(this._self, this._then);

  final PagedState<T> _self;
  final $Res Function(PagedState<T>) _then;

/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? page = null,Object? hasReachedEnd = null,Object? isLoadingMore = null,Object? failure = freezed,}) {
  return _then(PagedState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PagedStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [PagedState].
extension PagedStatePatterns<T> on PagedState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagedState<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagedState<T> value)  $default,){
final _that = this;
switch (_that) {
case _PagedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagedState<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PagedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PagedStatus status,  List<T> items,  int page,  bool hasReachedEnd,  bool isLoadingMore,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagedState() when $default != null:
return $default(_that.status,_that.items,_that.page,_that.hasReachedEnd,_that.isLoadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PagedStatus status,  List<T> items,  int page,  bool hasReachedEnd,  bool isLoadingMore,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _PagedState():
return $default(_that.status,_that.items,_that.page,_that.hasReachedEnd,_that.isLoadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PagedStatus status,  List<T> items,  int page,  bool hasReachedEnd,  bool isLoadingMore,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PagedState() when $default != null:
return $default(_that.status,_that.items,_that.page,_that.hasReachedEnd,_that.isLoadingMore,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PagedState<T> implements PagedState<T> {
  const _PagedState({this.status = PagedStatus.initial,  List<T> items = const [], this.page = 0, this.hasReachedEnd = false, this.isLoadingMore = false, this.failure}): _items = items;
  

@override@JsonKey() final  PagedStatus status;
 final  List<T> _items;
@override@JsonKey() List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Last page loaded successfully.
@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasReachedEnd;
@override@JsonKey() final  bool isLoadingMore;
/// Error of the last request. With [PagedStatus.success] it means
/// loading the next page failed while the current items stay visible.
@override final  Failure? failure;

/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedStateCopyWith<T, _PagedState<T>> get copyWith => __$PagedStateCopyWithImpl<T, _PagedState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedState<T>&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),page,hasReachedEnd,isLoadingMore,failure);
}

@override
String toString() {
    return 'PagedState<$T>(status: $status, items: $items, page: $page, hasReachedEnd: $hasReachedEnd, isLoadingMore: $isLoadingMore, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PagedStateCopyWith<T,$Res> implements $PagedStateCopyWith<T, $Res> {
  factory _$PagedStateCopyWith(_PagedState<T> value, $Res Function(_PagedState<T>) _then) = __$PagedStateCopyWithImpl;
@override @useResult
$Res call({
 PagedStatus status, List<T> items, int page, bool hasReachedEnd, bool isLoadingMore, Failure? failure
});




}
/// @nodoc
class __$PagedStateCopyWithImpl<T,$Res>
    implements _$PagedStateCopyWith<T, $Res> {
  __$PagedStateCopyWithImpl(this._self, this._then);

  final _PagedState<T> _self;
  final $Res Function(_PagedState<T>) _then;

/// Create a copy of PagedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? page = null,Object? hasReachedEnd = null,Object? isLoadingMore = null,Object? failure = freezed,}) {
  return _then(_PagedState<T>(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PagedStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
