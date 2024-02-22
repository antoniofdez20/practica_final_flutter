import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  TopAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title)
    );
  }
}