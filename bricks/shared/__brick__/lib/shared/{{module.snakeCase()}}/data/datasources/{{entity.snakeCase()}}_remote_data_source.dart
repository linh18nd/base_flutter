import 'package:base_flutter/shared/{{module.snakeCase()}}/data/models/{{entity.snakeCase()}}_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part '{{entity.snakeCase()}}_remote_data_source.g.dart';

@RestApi()
abstract class {{entity.pascalCase()}}RemoteDataSource {
  factory {{entity.pascalCase()}}RemoteDataSource(Dio dio) = _{{entity.pascalCase()}}RemoteDataSource;

  // TODO(team): use the real endpoint.
  @GET('/{{module.paramCase()}}')
  Future<List<{{entity.pascalCase()}}Dto>> get{{module.pascalCase()}}();
}
