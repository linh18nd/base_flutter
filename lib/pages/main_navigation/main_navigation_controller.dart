import 'package:get/get.dart';
import '../../core/base/base_controller.dart';

class MainNavigationController extends BaseController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}



