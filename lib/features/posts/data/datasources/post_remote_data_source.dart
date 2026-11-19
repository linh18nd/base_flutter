import 'package:base_flutter/features/posts/data/models/post_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'post_remote_data_source.g.dart';

@RestApi()
abstract class PostRemoteDataSource {
  factory PostRemoteDataSource(Dio dio) = _PostRemoteDataSource;

  @GET('/posts')
  Future<List<PostDto>> getPosts({
    @Query('_page') required int page,
    @Query('_limit') required int limit,
  });

  @GET('/posts')
  Future<List<PostDto>> searchPosts(@Query('q') String query);
}
