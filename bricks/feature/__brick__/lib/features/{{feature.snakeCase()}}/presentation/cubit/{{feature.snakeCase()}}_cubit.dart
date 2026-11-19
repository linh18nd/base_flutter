import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/usecases/get_{{feature.snakeCase()}}.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature.snakeCase()}}_cubit.freezed.dart';
part '{{feature.snakeCase()}}_state.dart';

class {{feature.pascalCase()}}Cubit extends Cubit<{{feature.pascalCase()}}State> {
  {{feature.pascalCase()}}Cubit(this._get{{feature.pascalCase()}}) : super(const {{feature.pascalCase()}}State.initial());

  final Get{{feature.pascalCase()}} _get{{feature.pascalCase()}};

  Future<void> load() async {
    emit(const {{feature.pascalCase()}}State.loading());
    final result = await _get{{feature.pascalCase()}}();
    emit(switch (result) {
      Ok(:final value) => {{feature.pascalCase()}}State.loaded(value),
      Err(:final failure) => {{feature.pascalCase()}}State.failure(failure),
    });
  }
}
