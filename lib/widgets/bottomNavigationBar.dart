import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Identifica la ruta actual
    String currentRoute = Get.currentRoute;

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.scoreboard, color: currentRoute == '/login' ? Colors.purple : Colors.grey),
            onPressed: currentRoute == '/login' ? null : () => Get.offAllNamed('/login'),
          ),
          SizedBox(width: 48), // Espacio para el botón central
          IconButton(
            icon: Icon(Icons.store, color: currentRoute == '/store' ? Colors.purple : Colors.grey),
            // Desactiva el botón si ya estás en la StoreScreen
            onPressed: currentRoute == '/store' ? null : () => Get.offAllNamed('/store'),
          ),
        ],
      ),
    );
  }
}
