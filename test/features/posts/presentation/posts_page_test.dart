import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:base_flutter/features/posts/presentation/pages/posts_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';

class _MockPostsCubit extends MockCubit<PostsState> implements PostsCubit;

void main() {
  late _MockPostsCubit cubit;

  setUp(() {
    cubit = _MockPostsCubit();
    when(() => cubit.load()).thenAnswer((_) async {});
  });

  Future<void> pumpPage(WidgetTester tester, PostsState state) async {
    when(() => cubit.state).thenReturn(state);
    await tester.pumpApp(
      const PostsPage(),
      providers: [BlocProvider<PostsCubit>.value(value: cubit)],
    );
  }

  testWidgets('initial state shows a load button that calls load()', (
    tester,
  ) async {
    await pumpPage(tester, const PostsState.initial());

    await tester.tap(find.text('Load posts'));

    verify(() => cubit.load()).called(1);
  });

  testWidgets('loaded state lists the posts', (tester) async {
    await pumpPage(
      tester,
      const PostsState.loaded([
        Post(id: 1, userId: 1, title: 'Hello Flutter', body: 'Body'),
      ]),
    );

    expect(find.text('Hello Flutter'), findsOneWidget);
  });

  testWidgets('failure state shows a localized message and retries', (
    tester,
  ) async {
    await pumpPage(tester, const PostsState.failure(NetworkFailure()));

    expect(
      find.text('Connection error, please check your internet'),
      findsOneWidget,
    );

    await tester.tap(find.text('Retry'));

    verify(() => cubit.load()).called(1);
  });
}
