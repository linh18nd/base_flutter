import 'package:freezed_annotation/freezed_annotation.dart';

part '{{entity.snakeCase()}}.freezed.dart';

// TODO(team): replace the sample fields with the real ones.
@freezed
abstract class {{entity.pascalCase()}} with _${{entity.pascalCase()}} {
  const factory {{entity.pascalCase()}}({
    required int id,
    required String title,
  }) = _{{entity.pascalCase()}};
}
