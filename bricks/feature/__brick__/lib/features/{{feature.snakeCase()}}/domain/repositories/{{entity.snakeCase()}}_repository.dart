import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';

abstract interface class {{entity.pascalCase()}}Repository {
  Future<Result<List<{{entity.pascalCase()}}>>> get{{feature.pascalCase()}}();
}
