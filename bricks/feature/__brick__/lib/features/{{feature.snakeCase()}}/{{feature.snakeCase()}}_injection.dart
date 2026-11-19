import 'package:base_flutter/features/{{feature.snakeCase()}}/data/datasources/{{entity.snakeCase()}}_remote_data_source.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/data/repositories/{{entity.snakeCase()}}_repository_impl.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/repositories/{{entity.snakeCase()}}_repository.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/usecases/get_{{feature.snakeCase()}}.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/presentation/cubit/{{feature.snakeCase()}}_cubit.dart';
import 'package:get_it/get_it.dart';

/// Call from `configureDependencies` in `lib/app/di/injection.dart`.
void register{{feature.pascalCase()}}Feature(GetIt getIt) {
  getIt
    // Data
    ..registerLazySingleton(() => {{entity.pascalCase()}}RemoteDataSource(getIt()))
    ..registerLazySingleton<{{entity.pascalCase()}}Repository>(
      () => {{entity.pascalCase()}}RepositoryImpl(getIt()),
    )
    // Domain
    ..registerFactory(() => Get{{feature.pascalCase()}}(getIt()))
    // Presentation
    ..registerFactory(() => {{feature.pascalCase()}}Cubit(getIt()));
}
