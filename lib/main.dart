import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizz Land',
        initialRoute: '/login',
        getPages: [
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(
              name: '/create_account', page: () => const CreateAccountScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
        ],
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xFF001D3D), // Color del AppBar
            titleTextStyle: TextStyle(
              fontSize: 28,
              color: Color(0xFFFFC300), // Color del texto del AppBar
            ),
            actionsIconTheme: IconThemeData(color: Color(0xFFFFC300)),
          ),
          scaffoldBackgroundColor: const Color(0xFF003566),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFC300), // Color del texto
            ), // Color de fondo de pantalla
          ),
          //definicion del estilo de los floating action buttons
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFFFC300),
            foregroundColor: Color(0xFF001D3D),
          ),
        ));
  }
}
