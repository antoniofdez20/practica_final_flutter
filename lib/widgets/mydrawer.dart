import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/controllers/themecontroller.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';
import 'package:practica_final_flutter/utils/theme.dart';
import 'package:flutter/cupertino.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final controller = Get.find<FirebaseUsersController>();
    final tempUser = controller.tempUser;

    return Drawer(
      child: Obx(
        () => Container(
          color: themeController.isDarkMode.value
              ? MyTheme.darkTheme.scaffoldBackgroundColor
              : MyTheme.lightTheme
                  .scaffoldBackgroundColor, // Fondo para todo el Drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? MyTheme.darkTheme.appBarTheme.backgroundColor
                      : MyTheme.lightTheme.appBarTheme.backgroundColor,
                ),
                child: Center(
                  child: Text(
                    'Perfil de usuario',
                    style: themeController.isDarkMode.value
                        ? MyTheme.darkTheme.appBarTheme.titleTextStyle
                        : MyTheme.lightTheme.appBarTheme.titleTextStyle,
                  ),
                ),
              ),
              ListTile(
                textColor: themeController.isDarkMode.value
                    ? MyTheme.darkTheme.textTheme.bodyMedium?.color
                    : MyTheme.lightTheme.textTheme.bodyMedium?.color,
                title: const Text('Nombre de usuario'),
                subtitle: Text(tempUser.value.username),
              ),
              ListTile(
                textColor: themeController.isDarkMode.value
                    ? MyTheme.darkTheme.textTheme.bodyMedium?.color
                    : MyTheme.lightTheme.textTheme.bodyMedium?.color,
                title: const Text('XP'),
                subtitle: Text('${tempUser.value.xp} puntos'),
              ),
              ListTile(
                textColor: themeController.isDarkMode.value
                    ? MyTheme.darkTheme.textTheme.bodyMedium?.color
                    : MyTheme.lightTheme.textTheme.bodyMedium?.color,
                title: const Text('Créditos'),
                subtitle: Text('${tempUser.value.credits} créditos'),
              ),
              ListTile(
                textColor: themeController.isDarkMode.value
                    ? MyTheme.darkTheme.textTheme.bodyMedium?.color
                    : MyTheme.lightTheme.textTheme.bodyMedium?.color,
                title: Row(
                  children: [
                    const Text('Tema Claro/Oscuro'),
                    const Spacer(),
                    CupertinoSwitch(
                      value: themeController.isDarkMode.value,
                      onChanged: (value) {
                        themeController.toggleTheme();
                        Get.changeTheme(themeController.isDarkMode.value
                            ? MyTheme.darkTheme
                            : MyTheme.lightTheme);
                      },
                      activeColor: MyColors.amber,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(80.0), // Ajusta este valor para cambiar el margen alrededor del botón
                child: SizedBox(
                  width: 200.0, // Ajusta este valor para cambiar el ancho del botón
                  height: 55.0, // Ajusta este valor para cambiar la altura del botón
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.exit_to_app), // Define tu icono aquí
                    label: const Text('LogOut'), // Define tu texto aquí
                    onPressed: () {
                      Get.offAllNamed('/login');
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Ajusta este valor para cambiar el margen alrededor del botón
                  child: Container(
                    width: 205.0, // Ajusta este valor para cambiar el ancho del botón
                    height: 55.0, // Ajusta este valor para cambiar la altura del botón
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.delete), // Define tu icono aquí
                      label: const Text('Eliminar Compte'), // Define tu texto aquí
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        // Aquí va tu lógica al presionar el botón
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
