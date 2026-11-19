import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/repositories/{{entity.snakeCase()}}_repository.dart';

class Get{{feature.pascalCase()}} {
  const Get{{feature.pascalCase()}}(this._repository);

  final {{entity.pascalCase()}}Repository _repository;

  Future<Result<List<{{entity.pascalCase()}}>>> call() =>
      _repository.get{{feature.pascalCase()}}();
}
