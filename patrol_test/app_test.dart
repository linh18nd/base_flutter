import 'package:base_flutter/app/router/shell_keys.dart';
import 'package:base_flutter/core/widgets/status_views.dart';
import 'package:base_flutter/features/posts/presentation/posts_keys.dart';
import 'package:base_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:base_flutter/features/settings/presentation/settings_keys.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
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

  patrolTest('search shows matching posts and an empty state', ($) async {
    await pumpTestApp($);

    await $(PostsKeys.searchButton).tap();
    await $(PostsKeys.searchField).enterText('flutter');
    await $(PostsKeys.postTile(10)).waitUntilVisible();
    expect($(PostsKeys.postTile(1)), findsNothing);

    await $(PostsKeys.searchField).enterText('zzz');
    await $(t.no_results(query: 'zzz')).waitUntilVisible();
  });

  patrolTest('a failed first page can be retried', ($) async {
    await pumpTestApp($, api: FakeApi()..failNextPostsRequests = 1);

    await $('Service unavailable').waitUntilVisible();
    await $(FailureView.retryButtonKey).tap();

    await $(PostsKeys.postTile(1)).waitUntilVisible();
  });

  patrolTest('settings switch to dark mode and Vietnamese', ($) async {
    await pumpTestApp($);

    await $(ShellKeys.settingsTab).tap();
    await $(SettingsKeys.themeOption(AppThemeMode.dark)).tap();
    await $(SettingsKeys.languageOption('vi')).tap();
    await $('Cài đặt').waitUntilVisible();

    final app = $.tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);

    await $(ShellKeys.homeTab).tap();
    await $('Trang chủ').waitUntilVisible();
  });
}
