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

    /// First page failed ([PagedStatus.failure]): full-screen error,
    /// retry with `refresh`.
    Failure? failure,

    /// Next page failed: items stay visible, footer offers retry with
    /// `loadMore`. Load-more on scroll pauses until then.
    Failure? loadMoreFailure,

    /// Pull to refresh failed while items were shown: items stay visible,
    /// the UI shows a one-off message (snackbar).
    Failure? refreshFailure,
  }) = _PagedState<T>;
}
