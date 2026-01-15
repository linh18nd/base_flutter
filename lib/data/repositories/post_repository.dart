import '../../core/constants/api_constants.dart';
import 'package:dio/dio.dart';

import '../../core/network/api_response.dart';
import '../../core/network/api_service.dart';
import '../models/post_model.dart';

class PostRepository extends ApiService {
  PostRepository(super.apiClient);

  Future<ApiResponse<List<Post>>> getPosts() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final Response<dynamic> response = await apiClient.get(ApiConstants.postsEndpoint);
      return handleResponse<List<Post>>(response, (data) {
        final list = data as List<dynamic>;
        return list
            .map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      return handleError<List<Post>>(e);
    }
  }
}
