import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/core/pagination/paginated_cubit.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/usecases/get_posts.dart';

/// Infinite list of posts. Paging, refresh, end of list and errors come from
/// [PaginatedCubit]; this class only says how to fetch one page.
class PostsCubit extends PaginatedCubit<Post> {
  PostsCubit(this._getPosts, {super.pageSize});

  final GetPosts _getPosts;

  @override
  Future<Result<List<Post>>> fetchPage(int page) =>
      _getPosts(page: page, limit: pageSize);
}
