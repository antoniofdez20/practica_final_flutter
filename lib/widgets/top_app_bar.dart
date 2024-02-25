import 'package:flutter/material.dart';

/// widget per mostrar l'appbar de la nostra aplicació
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true, title: Text(title));
  }
}
