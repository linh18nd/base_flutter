import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Replaces the network layer of the app's `Dio` in E2E tests.
///
/// Everything above it (retrofit parsing, repositories, `guard()`, usecases,
/// cubits, UI) is the real code, but responses are fixed and instant, so
/// tests don't depend on a server or the network.
class FakeApi implements HttpClientAdapter {
  FakeApi({this.totalPosts = 45});

  /// Posts served by `GET /posts`, ids 1..[totalPosts]. Every 10th post has
  /// "Flutter" in its title so search has something to find.
  final int totalPosts;

  /// Every request the app sent, in order.
  final List<Uri> requests = [];

  /// Number of upcoming `/posts` requests that answer 503.
  int failNextPostsRequests = 0;

  /// Pages whose next request answers 503 (each page fails once).
  final Set<int> failPagesOnce = {};

  /// When true, search requests fail as if the device were offline.
  bool searchOffline = false;

  static String postTitle(int id) =>
      id % 10 == 0 ? 'Flutter tips #$id' : 'Post $id';

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final uri = options.uri;
    requests.add(uri);

    if (uri.path != '/posts') {
      return _json({'message': 'Not found'}, status: 404);
    }
    if (failNextPostsRequests > 0) {
      failNextPostsRequests--;
      return _json({'message': 'Service unavailable'}, status: 503);
    }

    final all = [for (var id = 1; id <= totalPosts; id++) _post(id)];

    final query = uri.queryParameters['q'];
    if (query != null) {
      if (searchOffline) {
        throw DioException.connectionError(
          requestOptions: options,
          reason: 'Fake: device is offline',
        );
      }
      final q = query.toLowerCase();
      return _json([
        for (final post in all)
          if ((post['title']! as String).toLowerCase().contains(q)) post,
      ]);
    }

    final page = int.parse(uri.queryParameters['_page'] ?? '1');
    if (failPagesOnce.remove(page)) {
      return _json({'message': 'Service unavailable'}, status: 503);
    }
    final limit = int.parse(uri.queryParameters['_limit'] ?? '$totalPosts');
    return _json(all.skip((page - 1) * limit).take(limit).toList());
  }

  /// Number of `/posts` requests for [page] (pagination, not search).
  int pageRequests(int page) => requests
      .where((u) => u.path == '/posts' && u.queryParameters['_page'] == '$page')
      .length;

  Map<String, Object> _post(int id) => {
    'id': id,
    'userId': 1,
    'title': postTitle(id),
    'body': 'Body of post $id',
  };

  ResponseBody _json(Object body, {int status = 200}) =>
      ResponseBody.fromString(
        jsonEncode(body),
        status,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

  @override
  void close({bool force = false}) {}
}
