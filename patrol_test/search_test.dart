import 'package:base_flutter/features/posts/presentation/posts_keys.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:patrol/patrol.dart';

import 'support/fake_api.dart';
import 'support/test_app.dart';

void main() {
  patrolTest('search shows matching posts and an empty state', ($) async {
    await pumpTestApp($);

    await $(PostsKeys.searchButton).tap();
    await $(PostsKeys.searchField).enterText('flutter');
    await $(PostsKeys.postTile(10)).waitUntilVisible();
    expect($(PostsKeys.postTile(1)), findsNothing);

    await $(PostsKeys.searchField).enterText('zzz');
    await $(t.no_results(query: 'zzz')).waitUntilVisible();
  });

  patrolTest('search without network shows an error, back returns to list', (
    $,
  ) async {
    await pumpTestApp($, api: FakeApi()..searchOffline = true);
    await $(PostsKeys.postTile(1)).waitUntilVisible();

    await $(PostsKeys.searchButton).tap();
    await $(PostsKeys.searchField).enterText('flutter');
    await $(t.connection_error).waitUntilVisible();

    // The AppBar back arrow is created by Flutter, so it has no app key.
    await $(BackButton).tap();

    await $(PostsKeys.postTile(1)).waitUntilVisible();
  });
}
