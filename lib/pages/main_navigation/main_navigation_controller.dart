import 'package:get/get.dart';
import 'package:base_flutter/core/base/base_controller.dart';

class MainNavigationController extends BaseController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}



