import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';

abstract interface class PostRepository {
  /// One page of posts; [page] starts at 1.
  Future<Result<List<Post>>> getPosts({required int page, required int limit});

  Future<Result<List<Post>>> searchPosts(String query);
}
