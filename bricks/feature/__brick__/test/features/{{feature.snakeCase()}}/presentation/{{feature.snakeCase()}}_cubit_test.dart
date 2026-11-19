import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/usecases/get_{{feature.snakeCase()}}.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/presentation/cubit/{{feature.snakeCase()}}_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGet{{feature.pascalCase()}} extends Mock implements Get{{feature.pascalCase()}};

void main() {
  late _MockGet{{feature.pascalCase()}} get{{feature.pascalCase()}};

  const items = [{{entity.pascalCase()}}(id: 1, title: 'A')];
  const failure = NetworkFailure();

  setUp(() => get{{feature.pascalCase()}} = _MockGet{{feature.pascalCase()}}());

  blocTest<{{feature.pascalCase()}}Cubit, {{feature.pascalCase()}}State>(
    'emits [loading, loaded] on success',
    setUp: () => when(() => get{{feature.pascalCase()}}()).thenAnswer((_) async => const Ok(items)),
    build: () => {{feature.pascalCase()}}Cubit(get{{feature.pascalCase()}}),
    act: (cubit) => cubit.load(),
    expect: () => const [
      {{feature.pascalCase()}}State.loading(),
      {{feature.pascalCase()}}State.loaded(items),
    ],
  );

  blocTest<{{feature.pascalCase()}}Cubit, {{feature.pascalCase()}}State>(
    'emits [loading, failure] on error',
    setUp: () => when(() => get{{feature.pascalCase()}}()).thenAnswer((_) async => const Err(failure)),
    build: () => {{feature.pascalCase()}}Cubit(get{{feature.pascalCase()}}),
    act: (cubit) => cubit.load(),
    expect: () => const [
      {{feature.pascalCase()}}State.loading(),
      {{feature.pascalCase()}}State.failure(failure),
    ],
  );
}
