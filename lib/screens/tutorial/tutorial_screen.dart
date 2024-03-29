import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Tutorial'),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {
                Get.offNamed('/home');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Benvingut a Quizz Land!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                        height: 20), // Espacio entre el texto y la imagen
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30.0), // Añade márgenes a los lados
                      child: const Text(
                        'Aquesta aplicació consisteix amb un joc de 10 preguntes d\'una categoria que hauràs de '
                        'respondre.\n\nOn podràs competir amb altres jugadors i demostrar que ets el '
                        'millor!\n\nEt podràs ajudar d\'unes avantatges que aconseguiràs obrint els paquets que compris a la tenda pel cost de 250 crèdits.',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.asset('assets/icons/ic_launcher_round.png',
                        height: 300, width: 300),
                    const SizedBox(
                        height: 40), // Espacio entre la imagen y el botón
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, right: 100, left: 100),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offNamed('/tutorial/game');
                    },
                    child: const Text(
                      'Continuar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
