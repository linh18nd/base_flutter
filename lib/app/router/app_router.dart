import 'package:base_flutter/app/di/injection.dart';
import 'package:base_flutter/app/router/main_shell.dart';
import 'package:base_flutter/app/router/routes.dart';
import 'package:base_flutter/features/notifications/presentation/pages/notifications_page.dart';
import 'package:base_flutter/features/posts/presentation/bloc/post_search_bloc.dart';
import 'package:base_flutter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:base_flutter/features/posts/presentation/pages/post_search_page.dart';
import 'package:base_flutter/features/posts/presentation/pages/posts_page.dart';
import 'package:base_flutter/features/settings/presentation/pages/settings_page.dart';
import 'package:base_flutter/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Screen-scoped blocs/cubits are created here, next to their route, so pages
/// stay free of the service locator.
GoRouter createRouter() => GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash,
  routes: [
    GoRoute(path: Routes.splash, builder: (_, _) => const SplashPage()),
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (_, _) => BlocProvider(
                create: (_) => getIt<PostsCubit>(),
                child: const PostsPage(),
              ),
              routes: [
                GoRoute(
                  path: 'search',
                  // Full screen, above the bottom navigation bar.
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (_, _) => BlocProvider(
                    create: (_) => getIt<PostSearchBloc>(),
                    child: const PostSearchPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.notifications,
              builder: (_, _) => const NotificationsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (_, _) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
