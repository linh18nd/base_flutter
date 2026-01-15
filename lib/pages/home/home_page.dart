import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_controller.dart';
import '../../core/utils/localization_extensions.dart';
import '../../core/config/app_theme.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.home), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: controller.loadPosts,
                child: Text('Load posts', style: AppTextStyle.t16w500()),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: controller.posts.isEmpty
                    ? Center(
                        child: Text(
                          'No posts loaded',
                          style: AppTextStyle.t14w400(AppColors.textSecondary),
                        ),
                      )
                    : ListView.separated(
                        itemCount: controller.posts.length,
                        separatorBuilder: (_, _) => SizedBox(height: 8.h),
                        itemBuilder: (context, index) {
                          final post = controller.posts[index];
                          return ListTile(
                            title: Text(
                              post.title,
                              style: AppTextStyle.t16w700(),
                            ),
                            subtitle: Text(
                              post.body,
                              style: AppTextStyle.t14w400(
                                AppColors.textSecondary,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
