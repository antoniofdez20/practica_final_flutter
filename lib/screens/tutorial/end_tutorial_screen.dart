import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/firebase_users_controller.dart';


class EndTutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<FirebaseUsersController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 40), // Espacio entre el texto y la imagen
            const Text(
              'Enorabona! Has completat el tutorial!',
              style: TextStyle(fontSize: 24),
            ),

            // Afegir experiencias i credits guanyats
            const SizedBox(height: 20), // Espacio entre el texto y la imagen
            const Text(
              'Experiencia guanyada:\n1000',
              style: TextStyle(fontSize: 20),
            ),
            

            const SizedBox(height: 20), // Espacio entre el texto y la imagen
            const Text(
              'Credits guanyats:\n250',
              style: TextStyle(fontSize: 20),
            ),


            Image.asset('assets/icons/ic_launcher_round.png', height: 300, width: 300),
            ElevatedButton(
              onPressed: () {
                userController.tempUser.value.credits += 250; // Incrementa los créditos
                userController.tempUser.value.xp += 1000; // Incrementa la experiencia
                userController.update(); // Notifica a los widgets que escuchan este estado
                Get.toNamed('/home');
              },
              child: const Text('Botón'),
            ),
          ],
        ),
      ),
    );
  }
}