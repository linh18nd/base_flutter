import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/domain/repositories/{{entity.snakeCase()}}_repository.dart';

class Get{{module.pascalCase()}} {
  const Get{{module.pascalCase()}}(this._repository);

  final {{entity.pascalCase()}}Repository _repository;

  Future<Result<List<{{entity.pascalCase()}}>>> call() =>
      _repository.get{{module.pascalCase()}}();
}
