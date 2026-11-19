import 'package:material_ui/material_ui.dart';

/// Widget keys shared by the app and E2E tests (patrol_test/).
abstract final class PostsKeys {
  static Key postTile(int postId) => ValueKey('posts.postTile.$postId');
  static const searchButton = Key('posts.searchButton');
  static const searchField = Key('posts.searchField');
}
