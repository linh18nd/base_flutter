import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/guard.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _dio(DioExceptionType type, {int? status, Object? data}) {
  final options = RequestOptions(path: '/x');
  return DioException(
    requestOptions: options,
    type: type,
    response: status == null
        ? null
        : Response<dynamic>(
            requestOptions: options,
            statusCode: status,
            data: data,
          ),
  );
}

void main() {
  group('guard', () {
    test('returns Ok with the value on success', () async {
      final result = await guard(() async => 42);
      expect(result, isA<Ok<int>>().having((r) => r.value, 'value', 42));
    });

    test('maps TypeError to ParsingFailure', () async {
      final result = await guard<int>(() async => (null as dynamic) as int);
      expect(
        result,
        isA<Err<int>>().having(
          (r) => r.failure,
          'failure',
          isA<ParsingFailure>(),
        ),
      );
    });

    test('maps unknown errors to UnknownFailure', () async {
      final result = await guard<int>(() async => throw StateError('boom'));
      expect(
        result,
        isA<Err<int>>().having(
          (r) => r.failure,
          'failure',
          isA<UnknownFailure>(),
        ),
      );
    });
  });

  group('mapDioException', () {
    test('timeouts map to TimeoutFailure', () {
      for (final type in [
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
      ]) {
        expect(mapDioException(_dio(type)), isA<TimeoutFailure>());
      }
    });

    test('connection error maps to NetworkFailure', () {
      expect(
        mapDioException(_dio(DioExceptionType.connectionError)),
        isA<NetworkFailure>(),
      );
    });

    test('cancel maps to CancelledFailure', () {
      expect(
        mapDioException(_dio(DioExceptionType.cancel)),
        isA<CancelledFailure>(),
      );
    });

    test('401 maps to UnauthorizedFailure', () {
      expect(
        mapDioException(_dio(DioExceptionType.badResponse, status: 401)),
        isA<UnauthorizedFailure>(),
      );
    });

    test('other bad responses map to ServerFailure with server message', () {
      final failure = mapDioException(
        _dio(
          DioExceptionType.badResponse,
          status: 500,
          data: {'message': 'Maintenance'},
        ),
      );
      expect(
        failure,
        isA<ServerFailure>()
            .having((f) => f.statusCode, 'statusCode', 500)
            .having((f) => f.message, 'message', 'Maintenance'),
      );
    });
  });
}
