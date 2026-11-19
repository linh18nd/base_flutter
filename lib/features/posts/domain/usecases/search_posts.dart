import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/repositories/post_repository.dart';

class SearchPosts {
  const SearchPosts(this._repository);

  final PostRepository _repository;

  /// Returns an empty list for a blank [query] without calling the API.
  Future<Result<List<Post>>> call(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return Future.value(const Ok([]));
    }
    return _repository.searchPosts(trimmed);
  }
}
