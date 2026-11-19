import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/usecases/search_posts.dart';
import 'package:base_flutter/features/posts/presentation/bloc/post_search_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSearchPosts extends Mock implements SearchPosts;

void main() {
  late _MockSearchPosts searchPosts;

  const debounce = Duration(milliseconds: 50);
  const wait = Duration(milliseconds: 120);
  const posts = [Post(id: 7, userId: 1, title: 'Flutter', body: 'Bloc')];

  setUp(() {
    searchPosts = _MockSearchPosts();
    when(() => searchPosts(any())).thenAnswer((_) async => const Ok(posts));
  });

  PostSearchBloc build() => PostSearchBloc(searchPosts, debounce: debounce);

  blocTest<PostSearchBloc, PostSearchState>(
    'debounces typing and only searches the final query',
    build: build,
    act: (bloc) => bloc
      ..add(const PostSearchQueryChanged('f'))
      ..add(const PostSearchQueryChanged('fl'))
      ..add(const PostSearchQueryChanged('flutter')),
    wait: wait,
    expect: () => const [
      PostSearchState.loading('flutter'),
      PostSearchState.loaded(query: 'flutter', posts: posts),
    ],
    verify: (_) {
      verify(() => searchPosts('flutter')).called(1);
      verifyNever(() => searchPosts('f'));
      verifyNever(() => searchPosts('fl'));
    },
  );

  blocTest<PostSearchBloc, PostSearchState>(
    'returns to idle for a blank query without searching',
    build: build,
    act: (bloc) => bloc.add(const PostSearchQueryChanged('   ')),
    wait: wait,
    expect: () => const [PostSearchState.idle()],
    verify: (_) => verifyNever(() => searchPosts(any())),
  );
}
