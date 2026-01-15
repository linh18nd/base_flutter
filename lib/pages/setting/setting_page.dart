import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_flutter/pages/setting/setting_controller.dart';
import 'package:base_flutter/core/utils/localization_extensions.dart';
import 'package:base_flutter/services/theme_service.dart';
import 'package:base_flutter/services/locale_service.dart';
import 'package:base_flutter/core/config/app_theme.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final localeService = Get.find<LocaleService>();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.setting), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.theme_mode, style: AppTextStyle.t18w700()),
                  SizedBox(height: 16.h),
                  Obx(
                    () => ListTile(
                      leading: Icon(
                        themeService.themeMode == ThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      title: Text(
                        themeService.themeMode == ThemeMode.dark
                            ? context.l10n.dark_mode
                            : context.l10n.light_mode,
                      ),
                      trailing: Switch(
                        value: themeService.themeMode == ThemeMode.dark,
                        onChanged: (value) async {
                          await controller.toggleTheme();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.language, style: AppTextStyle.t18w700()),
                  SizedBox(height: 16.h),
                  Obx(
                    () => Column(
                      children: [
                        RadioGroup<String>(
                          groupValue: localeService.locale.languageCode,
                          onChanged: (value) async {
                            if (value != null) {
                              await controller.changeLanguage(value);
                            }
                          },
                          child: Column(
                            children: [
                              RadioListTile<String>(
                                title: Text(context.l10n.english),
                                value: 'en',
                              ),
                              RadioListTile<String>(
                                title: Text(context.l10n.vietnamese),
                                value: 'vi',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.app_info, style: AppTextStyle.t18w700()),
                  SizedBox(height: 16.h),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(context.l10n.app_name),
                    subtitle: Text(context.l10n.app_version),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
