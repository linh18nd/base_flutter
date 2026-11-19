import 'package:base_flutter/core/error/guard.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/data/datasources/{{entity.snakeCase()}}_remote_data_source.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/repositories/{{entity.snakeCase()}}_repository.dart';

final class {{entity.pascalCase()}}RepositoryImpl implements {{entity.pascalCase()}}Repository {
  const {{entity.pascalCase()}}RepositoryImpl(this._remote);

  final {{entity.pascalCase()}}RemoteDataSource _remote;

  @override
  Future<Result<List<{{entity.pascalCase()}}>>> get{{feature.pascalCase()}}() => guard(() async {
    final dtos = await _remote.get{{feature.pascalCase()}}();
    return dtos.map((dto) => dto.toEntity()).toList();
  });
}
