import 'package:flutter/material.dart';
import 'package:practica_final_flutter/controllers/themecontroller.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';

class CustomInputDecorations {
  static InputDecoration buildInputDecoration({
    required String labelText,
    required ThemeController themeController,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
          color: themeController.isDarkMode.value
              ? MyColors.amber
              : MyColors.greenVogue),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: themeController.isDarkMode.value
              ? MyColors.amber
              : MyColors.greenVogue,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: themeController.isDarkMode.value
              ? MyColors.amber
              : MyColors.greenVogue,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      filled: true,
      fillColor: themeController.isDarkMode.value
          ? MyColors.midnightBlue
          : MyColors.easternBlue,
      suffixIcon: suffixIcon,
    );
  }
}
