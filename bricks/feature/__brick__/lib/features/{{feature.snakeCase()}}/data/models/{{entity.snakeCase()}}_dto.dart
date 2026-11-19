import 'package:base_flutter/features/{{feature.snakeCase()}}/domain/entities/{{entity.snakeCase()}}.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{entity.snakeCase()}}_dto.freezed.dart';
part '{{entity.snakeCase()}}_dto.g.dart';

/// Wire format of a {{entity.lowerCase()}}; keep API details out of the entity.
@freezed
abstract class {{entity.pascalCase()}}Dto with _${{entity.pascalCase()}}Dto {
  const factory {{entity.pascalCase()}}Dto({
    required int id,
    required String title,
  }) = _{{entity.pascalCase()}}Dto;

  const {{entity.pascalCase()}}Dto._();

  factory {{entity.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) =>
      _${{entity.pascalCase()}}DtoFromJson(json);

  {{entity.pascalCase()}} toEntity() => {{entity.pascalCase()}}(id: id, title: title);
}
