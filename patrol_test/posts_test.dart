import 'package:base_flutter/app/router/shell_keys.dart';
import 'package:base_flutter/core/widgets/paged_list_view.dart';
import 'package:base_flutter/core/widgets/status_views.dart';
import 'package:base_flutter/features/posts/presentation/posts_keys.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'support/fake_api.dart';
import 'support/test_app.dart';

void main() {
  patrolTest('loads posts and the next page while scrolling', ($) async {
    final api = await pumpTestApp($);

    await $(PostsKeys.postTile(1)).waitUntilVisible();
    await $(PostsKeys.postTile(25)).scrollTo();

    await $(PostsKeys.postTile(25)).waitUntilVisible();
    expect(api.pageRequests(1), 1);
    expect(api.pageRequests(2), 1);
  });

  patrolTest('a failed first page can be retried', ($) async {
    await pumpTestApp($, api: FakeApi()..failNextPostsRequests = 1);

    await $('Service unavailable').waitUntilVisible();
    await $(FailureView.retryButtonKey).tap();

    await $(PostsKeys.postTile(1)).waitUntilVisible();
  });

  patrolTest('a failed next page shows a footer that retries it', ($) async {
    final api = await pumpTestApp($, api: FakeApi()..failPagesOnce.add(2));

    await $(PostsKeys.postTile(1)).waitUntilVisible();
    await $(PagedListView.loadMoreRetryKey).scrollTo();
    await $(PagedListView.loadMoreRetryKey).tap();
    await $(PostsKeys.postTile(25)).scrollTo();

    await $(PostsKeys.postTile(25)).waitUntilVisible();
    expect(api.pageRequests(2), 2);
  });

  patrolTest('a failed pull to refresh keeps the list and shows a message', (
    $,
  ) async {
    final api = await pumpTestApp($);
    await $(PostsKeys.postTile(1)).waitUntilVisible();

    api.failNextPostsRequests = 1;
    await $.tester.drag($(PostsKeys.postTile(1)), const Offset(0, 400));
    await $.pumpAndSettle();

    await $('Service unavailable').waitUntilVisible();
    await $(PostsKeys.postTile(1)).waitUntilVisible();
    expect(api.pageRequests(1), 2);
  });

  patrolTest('an empty API response shows the empty state', ($) async {
    await pumpTestApp($, api: FakeApi(totalPosts: 0));

    await $(t.no_posts_loaded).waitUntilVisible();
  });

  patrolTest('switching tabs keeps the list and does not reload it', ($) async {
    final api = await pumpTestApp($);
    await $(PostsKeys.postTile(1)).waitUntilVisible();
    await $(PostsKeys.postTile(25)).scrollTo();

    await $(ShellKeys.settingsTab).tap();
    await $(ShellKeys.homeTab).tap();

    await $(PostsKeys.postTile(25)).waitUntilVisible();
    expect(api.pageRequests(1), 1);
    expect(api.pageRequests(2), 1);
  });
}
