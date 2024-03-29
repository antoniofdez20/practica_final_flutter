import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/firebase_users_controller.dart';

class EndTutorialScreen extends StatelessWidget {
  const EndTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<FirebaseUsersController>();
    final tempUser = userController.tempUser;

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
              'Enhorabona! Has completat el tutorial!',
              style: TextStyle(fontSize: 24),
            ),

            // Afegir experiencias i credits guanyats
            const SizedBox(height: 20), // Espacio entre el texto y la imagen
            const Text(
              'Experiència guanyada:\n1000',
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20), // Espacio entre el texto y la imagen
            const Text(
              'Crèdits guanyats:\n250',
              style: TextStyle(fontSize: 20),
            ),

            Image.asset('assets/icons/ic_launcher_round.png',
                height: 300, width: 300),
            ElevatedButton(
              onPressed: () async {
                tempUser.value.credits += 250; // Incrementa los créditos
                userController.tempUser.value.xp +=
                    1000; // Incrementa la experiencia
                await userController
                    .updateUser(); //actualizar los valores del usuario
                await userController.saveCredencials(
                    tempUser.value.username, tempUser.value.contrasenya);
                Get.offAllNamed('/home');
              },
              child:
                  const Text('Acabar Tutorial', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
