import 'package:base_flutter/core/error/guard.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:base_flutter/features/posts/domain/repositories/post_repository.dart';

final class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl(this._remote);

  final PostRemoteDataSource _remote;

  @override
  Future<Result<List<Post>>> getPosts({
    required int page,
    required int limit,
  }) => guard(() async {
    final dtos = await _remote.getPosts(page: page, limit: limit);
    return dtos.map((dto) => dto.toEntity()).toList();
  });

  @override
  Future<Result<List<Post>>> searchPosts(String query) => guard(() async {
    final dtos = await _remote.searchPosts(query);
    return dtos.map((dto) => dto.toEntity()).toList();
  });
}
