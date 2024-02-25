import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/controllers/themecontroller.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';
import 'package:practica_final_flutter/utils/theme.dart';
import 'package:flutter/cupertino.dart';

/// Widget per mostrar el Drawer de l'aplicació amb funcio de perfil de l'usuari
/// per visualitzar les seves dades, poder canviar el tema de l'aplicació i
/// tancar sessió o eliminar el compte
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
                    'Perfil d\'usuari',
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
                titleTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                title: const Text('Nom d\'usuari'),
                subtitle: Text(tempUser.value.username),
              ),
              ListTile(
                textColor: themeController.isDarkMode.value
                    ? MyTheme.darkTheme.textTheme.bodyMedium?.color
                    : MyTheme.lightTheme.textTheme.bodyMedium?.color,
                title: const Text('XP'),
                titleTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                subtitle: Row(
                  children: [
                    Text('${tempUser.value.xp}'),
                    const SizedBox(width: 5),
                    const Icon(Icons.star_rounded, color: MyColors.amber)
                  ],
                ),
              ),
              ListTile(
                textColor: themeController.isDarkMode.value
                    ? MyTheme.darkTheme.textTheme.bodyMedium?.color
                    : MyTheme.lightTheme.textTheme.bodyMedium?.color,
                title: const Text('Crèdits'),
                titleTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                subtitle: Row(
                  children: [
                    Text('${tempUser.value.credits}'),
                    const SizedBox(width: 5),
                    const Icon(Icons.attach_money_rounded,
                        color: MyColors.amber)
                  ],
                ),
              ),
              ListTile(
                textColor: themeController.isDarkMode.value
                    ? MyTheme.darkTheme.textTheme.bodyMedium?.color
                    : MyTheme.lightTheme.textTheme.bodyMedium?.color,
                titleTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                title: Row(
                  children: [
                    const Text('Tema Clar/Obscur'),
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
                padding: const EdgeInsets.all(
                    50), // Añade un padding general para mejor espaciado
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text('LogOut'),
                      onPressed: () {
                        controller.resetCredencials();
                        Get.offAllNamed('/login');
                      },
                    ),
                    const SizedBox(height: 20), // Espaciado entre botones
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete Account'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Color del botón
                      ),
                      onPressed: () async {
                        themeController.resetTheme();
                        await controller.deleteUser();
                        Get.offAllNamed('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
