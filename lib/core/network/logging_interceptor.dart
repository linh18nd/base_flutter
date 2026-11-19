import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Logs each request with its status and duration.
final class LoggingInterceptor extends Interceptor {
  LoggingInterceptor(this._logger);

  final Logger _logger;
  static const _startKey = '_requestStart';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startKey] = DateTime.now();
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.d(
      '${response.requestOptions.method} ${response.requestOptions.uri} '
      '→ ${response.statusCode} (${_elapsed(response.requestOptions)} ms)',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.w(
      '${err.requestOptions.method} ${err.requestOptions.uri} '
      '→ ${err.response?.statusCode ?? err.type.name} '
      '(${_elapsed(err.requestOptions)} ms)',
    );
    handler.next(err);
  }

  int _elapsed(RequestOptions options) {
    final start = options.extra[_startKey];
    return start is DateTime
        ? DateTime.now().difference(start).inMilliseconds
        : -1;
  }
}
