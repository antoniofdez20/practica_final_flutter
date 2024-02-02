import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.add),
            //ESTA PARTE DEL SNACKBAR LA DEJO PARA PODER PONER POR EJEMPLO CUANDO UN USUARIO SE REGISTRE
            onPressed: () {
              Get.snackbar(
                "Registro completado",
                "Bienvenido a Quizz Land",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 4),
                backgroundColor: const Color(0xFF001D3D),
                colorText: const Color(0xFFFFC300),
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                shouldIconPulse: true,
              );
            },
          ),
          centerTitle: true,
          title: const Text("Quizz Land"),
        ),
        body: const Center(
          child: Text('Home Page'),
        ));
  }
}
