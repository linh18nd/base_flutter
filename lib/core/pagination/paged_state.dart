import 'package:base_flutter/core/error/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_state.freezed.dart';

enum PagedStatus {
  /// Nothing loaded yet.
  initial,

  /// First page is loading (nothing to show yet).
  loading,

  /// At least one page loaded; [PagedState.items] is usable.
  success,

  /// First page failed; see [PagedState.failure].
  failure,
}

/// State of an infinitely scrolling list, used by `PaginatedCubit`.
@freezed
abstract class PagedState<T> with _$PagedState<T> {
  const factory PagedState({
    @Default(PagedStatus.initial) PagedStatus status,
    @Default([]) List<T> items,

    /// Last page loaded successfully.
    @Default(0) int page,
    @Default(false) bool hasReachedEnd,
    @Default(false) bool isLoadingMore,

    /// Error of the last request. With [PagedStatus.success] it means
    /// loading the next page failed while the current items stay visible.
    Failure? failure,
  }) = _PagedState<T>;
}
