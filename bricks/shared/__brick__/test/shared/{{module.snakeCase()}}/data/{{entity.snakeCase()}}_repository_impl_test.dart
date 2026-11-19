import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/data/datasources/{{entity.snakeCase()}}_remote_data_source.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/data/models/{{entity.snakeCase()}}_dto.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/data/repositories/{{entity.snakeCase()}}_repository_impl.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements {{entity.pascalCase()}}RemoteDataSource;

void main() {
  late _MockRemote remote;
  late {{entity.pascalCase()}}RepositoryImpl repository;

  setUp(() {
    remote = _MockRemote();
    repository = {{entity.pascalCase()}}RepositoryImpl(remote);
  });

  test('maps DTOs to entities', () async {
    when(() => remote.get{{module.pascalCase()}}()).thenAnswer(
      (_) async => const [{{entity.pascalCase()}}Dto(id: 1, title: 'A')],
    );

    final result = await repository.get{{module.pascalCase()}}();

    expect(
      result,
      isA<Ok<List<{{entity.pascalCase()}}>>>().having((r) => r.value, 'value', const [
        {{entity.pascalCase()}}(id: 1, title: 'A'),
      ]),
    );
  });

  test('returns NetworkFailure when offline', () async {
    when(() => remote.get{{module.pascalCase()}}()).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionError,
      ),
    );

    final result = await repository.get{{module.pascalCase()}}();

    expect(
      result,
      isA<Err<List<{{entity.pascalCase()}}>>>().having(
        (r) => r.failure,
        'failure',
        isA<NetworkFailure>(),
      ),
    );
  });
}
