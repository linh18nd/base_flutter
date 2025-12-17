import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/bindings/initial_binding.dart';
import 'package:base_flutter/core/config/app_config.dart';
import 'package:base_flutter/core/config/flavor_config.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/services/theme_service.dart';
import 'package:base_flutter/services/locale_service.dart';
import 'package:base_flutter/l10n/app_localizations.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlavorConfig.init(args);

  await InitialBinding.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final localeService = Get.find<LocaleService>();

    return ScreenUtilInit(
      designSize: const Size(AppConfig.designWidth, AppConfig.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
            theme: ThemeService.getLightTheme(),
            darkTheme: ThemeService.getDarkTheme(),
            themeMode: themeService.themeMode,
            locale: localeService.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocaleService.supportedLocales,
          ),
        );
      },
    );
  }
}
