import 'package:flutter/material.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';

class CustomInputDecorations {
  static InputDecoration buildInputDecoration({
    required String labelText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: MyColors.greenVogue),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.easternBlue,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.greenVogue,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      filled: true,
      fillColor: MyColors.easternBlue,
      suffixIcon: suffixIcon,
    );
  }
}
