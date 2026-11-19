import 'package:base_flutter/features/posts/data/models/post_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'post_remote_data_source.g.dart';

@RestApi()
abstract class PostRemoteDataSource {
  factory PostRemoteDataSource(Dio dio) = _PostRemoteDataSource;

  @GET('/posts')
  Future<List<PostDto>> getPosts();

  @GET('/posts')
  Future<List<PostDto>> searchPosts(@Query('q') String query);
}
