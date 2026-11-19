import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/pagination/paged_state.dart';
import 'package:base_flutter/core/widgets/paged_list_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/pump_app.dart';

const _loaded = PagedState<int>(
  status: PagedStatus.success,
  items: [1, 2, 3],
  page: 1,
  hasReachedEnd: true,
);

void main() {
  late ValueNotifier<PagedState<int>> state;
  late int refreshCalls;
  late int loadMoreCalls;

  setUp(() {
    state = ValueNotifier(_loaded);
    refreshCalls = 0;
    loadMoreCalls = 0;
  });

  Future<void> pump(WidgetTester tester) => tester.pumpApp(
    Scaffold(
      body: ValueListenableBuilder(
        valueListenable: state,
        builder: (_, value, _) => PagedListView<int>(
          state: value,
          onRefresh: () async => refreshCalls++,
          onLoadMore: () async => loadMoreCalls++,
          itemBuilder: (_, n) => ListTile(title: Text('Item $n')),
        ),
      ),
    ),
  );

  testWidgets('a failed refresh shows a snackbar and keeps the items', (
    tester,
  ) async {
    await pump(tester);

    state.value = _loaded.copyWith(refreshFailure: const NetworkFailure());
    await tester.pump(); // rebuild
    await tester.pump(); // post-frame callback shows the snackbar

    expect(
      find.text('Connection error, please check your internet'),
      findsOneWidget,
    );
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Retry'), findsNothing); // no load-more footer
  });

  testWidgets('a failed next page shows a footer that retries load more', (
    tester,
  ) async {
    await pump(tester);

    state.value = _loaded.copyWith(
      hasReachedEnd: false,
      loadMoreFailure: const NetworkFailure(),
    );
    await tester.pump();

    await tester.tap(find.text('Retry'));

    expect(loadMoreCalls, 1);
    expect(refreshCalls, 0);
  });
}
