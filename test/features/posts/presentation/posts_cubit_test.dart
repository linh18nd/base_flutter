import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/pagination/paged_state.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/usecases/get_posts.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetPosts extends Mock implements GetPosts;

/// Paging behaviour itself is covered in
/// test/core/pagination/paginated_cubit_test.dart; here we only check that
/// PostsCubit asks for the right page and size.
void main() {
  late _MockGetPosts getPosts;

  const posts = [Post(id: 1, userId: 1, title: 'Hello', body: 'World')];

  setUp(() {
    getPosts = _MockGetPosts();
    when(
      () => getPosts(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) async => const Ok(posts));
  });

  blocTest<PostsCubit, PagedState<Post>>(
    'refresh fetches page 1 with the page size',
    build: () => PostsCubit(getPosts, pageSize: 10),
    act: (cubit) => cubit.refresh(),
    expect: () => const [
      PagedState<Post>(status: PagedStatus.loading),
      PagedState<Post>(
        status: PagedStatus.success,
        items: posts,
        page: 1,
        hasReachedEnd: true,
      ),
    ],
    verify: (_) => verify(() => getPosts(page: 1, limit: 10)).called(1),
  );
}
