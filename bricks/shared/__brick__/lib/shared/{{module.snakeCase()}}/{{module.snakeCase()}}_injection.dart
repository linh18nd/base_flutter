import 'package:base_flutter/shared/{{module.snakeCase()}}/data/datasources/{{entity.snakeCase()}}_remote_data_source.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/data/repositories/{{entity.snakeCase()}}_repository_impl.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/domain/repositories/{{entity.snakeCase()}}_repository.dart';
import 'package:base_flutter/shared/{{module.snakeCase()}}/domain/usecases/get_{{module.snakeCase()}}.dart';
import 'package:get_it/get_it.dart';

/// Call from `configureDependencies` in `lib/app/di/injection.dart`,
/// before the features that use this module.
void register{{module.pascalCase()}}Module(GetIt getIt) {
  getIt
    // Data (one instance shared by every feature)
    ..registerLazySingleton(() => {{entity.pascalCase()}}RemoteDataSource(getIt()))
    ..registerLazySingleton<{{entity.pascalCase()}}Repository>(
      () => {{entity.pascalCase()}}RepositoryImpl(getIt()),
    )
    // Domain
    ..registerFactory(() => Get{{module.pascalCase()}}(getIt()));
}
