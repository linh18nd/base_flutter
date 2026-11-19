import 'package:base_flutter/core/constants/api_constants.dart';
import 'package:base_flutter/core/network/api_service.dart';
import 'package:base_flutter/data/models/post_model.dart';

class PostRepository extends ApiService {
  PostRepository(super.apiClient);

  Future<List<Post>> getPosts() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return request(
      () => apiClient.get(ApiConstants.postsEndpoint),
      (data) => (data as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
