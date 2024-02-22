import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/preferences/preferences_theme_data.dart';
import 'package:practica_final_flutter/utils/theme.dart';

class ThemeController extends GetxController {
  ThemeData get currentTheme =>
      isDarkMode.value ? MyTheme.darkTheme : MyTheme.lightTheme;
  RxBool isDarkMode = PreferencesTheme.isDarkMode.obs; // Variable observable

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    PreferencesTheme.isDarkMode = isDarkMode.value;
  }

  void resetTheme() {
    isDarkMode.value = false;
    PreferencesTheme.isDarkMode = false;
    Get.changeTheme(MyTheme.lightTheme);
  }
}
