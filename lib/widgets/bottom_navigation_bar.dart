import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';

// import '../controllers/themecontroller.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Identifica la ruta actual
    String currentRoute = Get.currentRoute;
      // final themeController = Get.find<ThemeController>();

    return BottomAppBar(
      // shape: const CircularNotchedRectangle(),
      // notchMargin: 6.0,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.list,
                size: 35,
                color: currentRoute == '/ranking'
                    ? MyColors.amber
                    : MyColors.cornflower),
            onPressed: currentRoute == '/ranking'
                ? null
                : () => Get.offAllNamed('/ranking'),
          ),
          IconButton(
            icon: Icon(Icons.play_arrow,
                size: 35,
                color: currentRoute == '/home'
                    ? MyColors.amber
                    : MyColors.cornflower),
            onPressed: currentRoute == '/home'
                ? null
                : () => Get.offAllNamed('/home'),
          ),

          // const SizedBox(width: ), // Espacio para el botón central
          IconButton(
            icon: Icon(Icons.store,
                size: 35,
                color: currentRoute == '/store'
                    ? MyColors.amber
                    : MyColors.cornflower),
            // Desactiva el botón si ya estás en la StoreScreen
            onPressed: currentRoute == '/store'
                ? null
                : () => Get.offAllNamed('/store'),
          ),
        ],
      ),
    );
  }
}
