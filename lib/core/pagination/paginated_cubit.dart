import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/pagination/paged_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show protected;

/// Reusable logic for infinitely scrolling lists: first load, pull to
/// refresh, load more, end of list and errors.
///
/// Subclasses only implement [fetchPage]:
/// ```dart
/// class OrdersCubit extends PaginatedCubit<Order> {
///   OrdersCubit(this._getOrders);
///   final GetOrders _getOrders;
///
///   @override
///   Future<Result<List<Order>>> fetchPage(int page) =>
///       _getOrders(page: page, limit: pageSize);
/// }
/// ```
abstract class PaginatedCubit<T> extends Cubit<PagedState<T>> {
  PaginatedCubit({this.pageSize = 20, this.firstPage = 1})
    : super(PagedState<T>());

  final int pageSize;
  final int firstPage;

  /// Bumped on every refresh so a slow "load more" from before the refresh
  /// can't append stale items.
  int _generation = 0;

  @protected
  Future<Result<List<T>>> fetchPage(int page);

  /// Loads the first page. Keeps showing the current items while reloading
  /// (pull to refresh); shows a full-screen loader only when empty.
  Future<void> refresh() async {
    final generation = ++_generation;
    if (state.items.isEmpty) {
      emit(PagedState<T>(status: PagedStatus.loading));
    }

    final result = await fetchPage(firstPage);
    if (generation != _generation || isClosed) return;

    switch (result) {
      case Ok(:final value):
        emit(
          PagedState<T>(
            status: PagedStatus.success,
            items: value,
            page: firstPage,
            hasReachedEnd: value.length < pageSize,
          ),
        );
      case Err(:final failure):
        emit(
          state.items.isEmpty
              ? PagedState<T>(status: PagedStatus.failure, failure: failure)
              : state.copyWith(failure: failure),
        );
    }
  }

  /// Loads the next page. Safe to call repeatedly (e.g. on every scroll
  /// event): it does nothing while a page is loading or after the end.
  Future<void> loadMore() async {
    if (state.status != PagedStatus.success ||
        state.hasReachedEnd ||
        state.isLoadingMore) {
      return;
    }

    final generation = _generation;
    final nextPage = state.page + 1;
    emit(state.copyWith(isLoadingMore: true, failure: null));

    final result = await fetchPage(nextPage);
    if (generation != _generation || isClosed) return;

    switch (result) {
      case Ok(:final value):
        emit(
          state.copyWith(
            items: [...state.items, ...value],
            page: nextPage,
            hasReachedEnd: value.length < pageSize,
            isLoadingMore: false,
          ),
        );
      case Err(:final failure):
        emit(state.copyWith(isLoadingMore: false, failure: failure));
    }
  }
}
