import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/pagination/paged_state.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:base_flutter/features/posts/presentation/pages/posts_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class _MockPostsCubit extends MockCubit<PagedState<Post>> implements PostsCubit;

void main() {
  late _MockPostsCubit cubit;

  setUp(() {
    cubit = _MockPostsCubit();
    when(() => cubit.refresh()).thenAnswer((_) async {});
    when(() => cubit.loadMore()).thenAnswer((_) async {});
  });

  Future<void> pumpPage(WidgetTester tester, PagedState<Post> state) async {
    when(() => cubit.state).thenReturn(state);
    await tester.pumpApp(
      const PostsPage(),
      providers: [BlocProvider<PostsCubit>.value(value: cubit)],
    );
  }

  testWidgets('loads the first page when opened', (tester) async {
    await pumpPage(tester, const PagedState<Post>());

    verify(() => cubit.refresh()).called(1);
  });

  testWidgets('lists the loaded posts', (tester) async {
    await pumpPage(
      tester,
      const PagedState<Post>(
        status: PagedStatus.success,
        items: [Post(id: 1, userId: 1, title: 'Hello Flutter', body: 'Body')],
        page: 1,
        hasReachedEnd: true,
      ),
    );

    expect(find.text('Hello Flutter'), findsOneWidget);
  });

  testWidgets('a failed first page shows a localized message and retries', (
    tester,
  ) async {
    await pumpPage(
      tester,
      const PagedState<Post>(
        status: PagedStatus.failure,
        failure: NetworkFailure(),
      ),
    );

    expect(
      find.text('Connection error, please check your internet'),
      findsOneWidget,
    );

    await tester.tap(find.text('Retry'));

    // Once on open, once from the retry button.
    verify(() => cubit.refresh()).called(2);
  });
}
