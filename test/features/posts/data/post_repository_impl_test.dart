import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/error/result.dart';
import 'package:base_flutter/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:base_flutter/features/posts/data/models/post_dto.dart';
import 'package:base_flutter/features/posts/data/repositories/post_repository_impl.dart';
import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements PostRemoteDataSource;

void main() {
  late _MockRemote remote;
  late PostRepositoryImpl repository;

  setUp(() {
    remote = _MockRemote();
    repository = PostRepositoryImpl(remote);
  });

  test('getPosts maps DTOs to entities', () async {
    when(() => remote.getPosts(page: 1, limit: 20)).thenAnswer(
      (_) async => const [PostDto(id: 1, userId: 2, title: 't', body: 'b')],
    );

    final result = await repository.getPosts(page: 1, limit: 20);

    expect(
      result,
      isA<Ok<List<Post>>>().having((r) => r.value, 'value', const [
        Post(id: 1, userId: 2, title: 't', body: 'b'),
      ]),
    );
  });

  test('getPosts returns NetworkFailure when offline', () async {
    when(() => remote.getPosts(page: 1, limit: 20)).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/posts'),
        type: DioExceptionType.connectionError,
      ),
    );

    final result = await repository.getPosts(page: 1, limit: 20);

    expect(
      result,
      isA<Err<List<Post>>>().having(
        (r) => r.failure,
        'failure',
        isA<NetworkFailure>(),
      ),
    );
  });

  test('searchPosts forwards the query', () async {
    when(() => remote.searchPosts('flutter')).thenAnswer((_) async => []);

    await repository.searchPosts('flutter');

    verify(() => remote.searchPosts('flutter')).called(1);
  });
}
