import 'package:get/get.dart';
import 'package:base_flutter/pages/main_navigation/main_navigation_binding.dart';
import 'package:base_flutter/pages/main_navigation/main_navigation_page.dart';
import 'package:base_flutter/pages/splash/splash_binding.dart';
import 'package:base_flutter/pages/splash/splash_page.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.mainNavigation,
      page: () => const MainNavigationPage(),
      binding: MainNavigationBinding(),
    ),
  ];
}

class Routes {
  Routes._();

  static const splash = '/splash';
  static const mainNavigation = '/main';
}

