import 'package:get/get.dart';
import 'package:practica_final_flutter/utils/theme.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs; // Variable observable

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      Get.changeTheme(MyTheme.lightTheme);
    } else {
      Get.changeTheme(MyTheme.darkTheme);
    }
    update();
  }
}