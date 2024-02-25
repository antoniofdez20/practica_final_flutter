import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/preferences/preferences.dart';
import 'package:practica_final_flutter/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //nos sirve para asegurarnos que el entorno de widgets este inicializado
  await PreferencesUserLogin.init(); //inicializamos las preferencias de usuario
  await PreferencesTheme.init(); //inicializamos las preferencias de tema
  Get.put(FirebaseUsersController());
  Get.put(NavigationController());
  Get.put(ThemeController());
  final isLoggedIn = PreferencesUserLogin.tempUsername.isNotEmpty && PreferencesUserLogin.tempPassword.isNotEmpty;
  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({super.key, required this.initialRoute});
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizz Land',
      initialRoute: initialRoute,

      /// utilizar lazyPut para instanciar un controlador o servicio solo cuando realmente se necesita,
      /// lo cual es útil para mejorar la eficiencia de memoria y el rendimiento de la aplicación.
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<FirebaseUsersController>(
                () => FirebaseUsersController());
          }),
        ),
        GetPage(
          name: '/create_account',
          page: () => const CreateAccountScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<FirebaseUsersController>(
                () => FirebaseUsersController());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<ThemeController>(() => ThemeController());
          }),
        ),
        GetPage(name: '/store', page: () => const StoreScreen()),
        GetPage(name: '/ranking', page: () => const RankingScreen()),
        GetPage(name: '/tutorial', page: () => const TutorialScreen()),
        GetPage(name: '/tutorial/game', page: () => const TutorialCategoryScreen()),
        GetPage(name: '/tutorial/game/end', page: () => const EndTutorialScreen()),
      ],
      theme: themeController.currentTheme,
    );
  }
}
