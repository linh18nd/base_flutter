import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/repositories/post_repository.dart';

class GetPosts {
  const GetPosts(this._repository);

  final PostRepository _repository;

  Future<Result<List<Post>>> call() => _repository.getPosts();
}
