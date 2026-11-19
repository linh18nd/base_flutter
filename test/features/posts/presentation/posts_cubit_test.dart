import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/usecases/get_posts.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetPosts extends Mock implements GetPosts;

void main() {
  late _MockGetPosts getPosts;

  const posts = [Post(id: 1, userId: 1, title: 'Hello', body: 'World')];
  const failure = NetworkFailure();

  setUp(() => getPosts = _MockGetPosts());

  test('starts in initial state', () {
    expect(PostsCubit(getPosts).state, const PostsState.initial());
  });

  blocTest<PostsCubit, PostsState>(
    'emits [loading, loaded] when posts load',
    setUp: () =>
        when(() => getPosts()).thenAnswer((_) async => const Ok(posts)),
    build: () => PostsCubit(getPosts),
    act: (cubit) => cubit.load(),
    expect: () => const [PostsState.loading(), PostsState.loaded(posts)],
  );

  blocTest<PostsCubit, PostsState>(
    'emits [loading, failure] when loading fails',
    setUp: () =>
        when(() => getPosts()).thenAnswer((_) async => const Err(failure)),
    build: () => PostsCubit(getPosts),
    act: (cubit) => cubit.load(),
    expect: () => const [PostsState.loading(), PostsState.failure(failure)],
  );
}
