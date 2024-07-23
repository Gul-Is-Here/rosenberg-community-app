import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  late NotchBottomBarController notchBottomBarController;

  @override
  void onInit() {
    super.onInit();
    notchBottomBarController = NotchBottomBarController(index: selectedIndex.value);
  }

  void changePage(int index) {
    selectedIndex.value = index;
    notchBottomBarController.jumpTo(index);
  }
}
