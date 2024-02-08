import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const ImageButton({super.key, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(imagePath),
    );
  }
}