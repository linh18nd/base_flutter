import 'dart:async';

import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/pagination/paged_state.dart';
import 'package:base_flutter/core/pagination/paginated_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pages of 2 numbers: page 1 → [1, 2], page 2 → [3, 4], page 3 → [5].
class _NumbersCubit extends PaginatedCubit<int> {
  _NumbersCubit({this.failOnPage}) : super(pageSize: 2);

  int? failOnPage;
  final requestedPages = <int>[];

  /// When set, fetchPage waits for it before answering.
  Completer<void>? gate;

  @override
  Future<Result<List<int>>> fetchPage(int page) async {
    requestedPages.add(page);
    await gate?.future;
    if (page == failOnPage) return const Err(NetworkFailure());
    final start = (page - 1) * 2 + 1;
    return Ok([for (var n = start; n <= 5 && n < start + 2; n++) n]);
  }
}

void main() {
  const failure = NetworkFailure();

  blocTest<_NumbersCubit, PagedState<int>>(
    'refresh shows a loader, then the first page',
    build: _NumbersCubit.new,
    act: (cubit) => cubit.refresh(),
    expect: () => const [
      PagedState<int>(status: PagedStatus.loading),
      PagedState<int>(status: PagedStatus.success, items: [1, 2], page: 1),
    ],
  );

  blocTest<_NumbersCubit, PagedState<int>>(
    'loadMore appends pages until a short page marks the end',
    build: _NumbersCubit.new,
    act: (cubit) async {
      await cubit.refresh();
      await cubit.loadMore();
      await cubit.loadMore();
      await cubit.loadMore(); // already at the end: no request
    },
    skip: 2, // loader + first page
    expect: () => const [
      PagedState<int>(
        status: PagedStatus.success,
        items: [1, 2],
        page: 1,
        isLoadingMore: true,
      ),
      PagedState<int>(
        status: PagedStatus.success,
        items: [1, 2, 3, 4],
        page: 2,
      ),
      PagedState<int>(
        status: PagedStatus.success,
        items: [1, 2, 3, 4],
        page: 2,
        isLoadingMore: true,
      ),
      PagedState<int>(
        status: PagedStatus.success,
        items: [1, 2, 3, 4, 5],
        page: 3,
        hasReachedEnd: true,
      ),
    ],
    verify: (cubit) => expect(cubit.requestedPages, [1, 2, 3]),
  );

  blocTest<_NumbersCubit, PagedState<int>>(
    'a failed first page shows the failure',
    build: () => _NumbersCubit(failOnPage: 1),
    act: (cubit) => cubit.refresh(),
    expect: () => const [
      PagedState<int>(status: PagedStatus.loading),
      PagedState<int>(status: PagedStatus.failure, failure: failure),
    ],
  );

  blocTest<_NumbersCubit, PagedState<int>>(
    'a failed next page keeps the items and reports the failure',
    build: () => _NumbersCubit(failOnPage: 2),
    act: (cubit) async {
      await cubit.refresh();
      await cubit.loadMore();
    },
    skip: 3, // loader, first page, loading more
    expect: () => const [
      PagedState<int>(
        status: PagedStatus.success,
        items: [1, 2],
        page: 1,
        loadMoreFailure: failure,
      ),
    ],
  );

  test('a failed refresh keeps the items and reports refreshFailure, '
      'without blocking load more', () async {
    final cubit = _NumbersCubit();
    await cubit.refresh();

    cubit.failOnPage = 1;
    await cubit.refresh();

    expect(cubit.state.items, [1, 2]);
    expect(cubit.state.refreshFailure, isA<NetworkFailure>());
    expect(cubit.state.loadMoreFailure, isNull);
    expect(cubit.state.failure, isNull);

    await cubit.loadMore();
    expect(cubit.state.items, [1, 2, 3, 4]);
    await cubit.close();
  });

  test('a failed refresh during load more does not leave it stuck', () async {
    final cubit = _NumbersCubit();
    await cubit.refresh();

    cubit
      ..gate = Completer<void>()
      ..failOnPage = 1;
    final loadingMore = cubit.loadMore(); // page 2, dropped by the refresh
    final refreshing = cubit.refresh(); // page 1, fails
    cubit.gate!.complete();
    await Future.wait([loadingMore, refreshing]);

    expect(cubit.state.isLoadingMore, isFalse);
    expect(cubit.state.refreshFailure, isA<NetworkFailure>());
    await cubit.close();
  });

  test('refresh during loadMore drops the stale page', () async {
    final cubit = _NumbersCubit();
    await cubit.refresh();

    cubit.gate = Completer<void>();
    final loadingMore = cubit.loadMore(); // page 2, waiting on the gate
    final refreshing = cubit.refresh(); // page 1 again, also waiting
    cubit.gate!.complete();
    await Future.wait([loadingMore, refreshing]);

    expect(cubit.state.items, [1, 2]);
    expect(cubit.state.page, 1);
    await cubit.close();
  });
}
