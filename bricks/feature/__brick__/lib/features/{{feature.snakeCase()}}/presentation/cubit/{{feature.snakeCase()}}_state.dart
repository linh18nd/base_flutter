part of '{{feature.snakeCase()}}_cubit.dart';

@freezed
sealed class {{feature.pascalCase()}}State with _${{feature.pascalCase()}}State {
  const factory {{feature.pascalCase()}}State.initial() = {{feature.pascalCase()}}Initial;
  const factory {{feature.pascalCase()}}State.loading() = {{feature.pascalCase()}}Loading;
  const factory {{feature.pascalCase()}}State.loaded(List<{{entity.pascalCase()}}> items) =
      {{feature.pascalCase()}}Loaded;
  const factory {{feature.pascalCase()}}State.failure(Failure failure) = {{feature.pascalCase()}}Failure;
}
