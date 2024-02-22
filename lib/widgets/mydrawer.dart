import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/controllers/themecontroller.dart';
import 'package:practica_final_flutter/preferences/preferences_login.dart';
import 'package:practica_final_flutter/utils/theme.dart';



class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inicializa PreferencesUserLogin en algún lugar antes de usarlo, por ejemplo, en main() o en el initState de tu widget inicial.
    // PreferencesUserLogin.init();

    // Llama a los getters de PreferencesUserLogin para obtener los valores almacenados
    String username = PreferencesUserLogin.tempUsername; // Usa el getter para obtener el nombre de usuario
    int xpPoints = PreferencesUserLogin.tempXP; // Usa el getter para obtener los puntos XP
    int credits = PreferencesUserLogin.tempCredits; // Usa el getter para obtener los créditos

    final ThemeController themeController = Get.find<ThemeController>();
    final controller = Get.find<FirebaseUsersController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? MyTheme.darkTheme.appBarTheme.backgroundColor
                  : MyTheme.lightTheme.appBarTheme.backgroundColor,
            ),
            child: Center(
              child: Text(
                'Drawer Header',
                style: Get.isDarkMode
                    ? MyTheme.darkTheme.appBarTheme.titleTextStyle
                    : MyTheme.lightTheme.appBarTheme.titleTextStyle,
              ),
            ),
          ),
          ListTile(
            title: Text('Nombre de usuario'),
            subtitle: Text(username),
          ),
          ListTile(
            title: Text('XP'),
            subtitle: Text('$xpPoints puntos'),
          ),
          ListTile(
            title: Text('Créditos'),
            subtitle: Text('$credits créditos'),
          ),
          ListTile(
            title: Row(
              children: [
                Text('Tema Claro/Oscuro'),
                Spacer(),
                Obx(() => Switch(
                  value: themeController.isDarkMode.value,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}