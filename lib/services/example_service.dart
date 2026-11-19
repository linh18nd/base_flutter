import 'package:base_flutter/core/network/api_service.dart';

class ExampleService extends ApiService {
  ExampleService(super.apiClient);

  Future<Map<String, dynamic>> getExampleData() {
    return request(
      () => apiClient.get('/example'),
      (data) => data as Map<String, dynamic>,
    );
  }

  Future<Map<String, dynamic>> postExampleData(Map<String, dynamic> body) {
    return request(
      () => apiClient.post('/example', data: body),
      (data) => data as Map<String, dynamic>,
    );
  }
}
