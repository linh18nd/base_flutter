import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';

abstract interface class PostRepository {
  Future<Result<List<Post>>> getPosts();

  Future<Result<List<Post>>> searchPosts(String query);
}
