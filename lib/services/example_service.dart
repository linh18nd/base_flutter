import '../core/network/api_response.dart';
import '../core/network/api_service.dart';

class ExampleService extends ApiService {
  ExampleService(super.apiClient);

  Future<ApiResponse<Map<String, dynamic>>> getExampleData() async {
    try {
      final response = await apiClient.get('/example');
      return handleResponse<Map<String, dynamic>>(
        response,
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      return handleError<Map<String, dynamic>>(e);
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> postExampleData(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await apiClient.post(
        '/example',
        data: data,
      );
      return handleResponse<Map<String, dynamic>>(
        response,
        (data) => data as Map<String, dynamic>,
      );
    } catch (e) {
      return handleError<Map<String, dynamic>>(e);
    }
  }
}