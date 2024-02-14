import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/screens/screens.dart';
import 'utils/theme.dart';

void main() {
  Get.put(FirebaseUsersController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizz Land',
      initialRoute: '/login',

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
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/store', page: () => const StoreScreen()),
      ],
      theme: MyTheme.lightTheme,
    );
  }
}
