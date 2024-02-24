import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:practica_final_flutter/screens/juegoscreen.dart';
import 'package:practica_final_flutter/services/triviaservice.dart';

class GameScreen extends StatelessWidget {
  int questionCount = 0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Tutorial'),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {
                Get.toNamed('/home');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40), // Espacio entre el texto y la imagen
          const Text("Tria una de les següents categories:", style: TextStyle(fontSize: 24),),

          controller.users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Botón de Historia
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        TriviaService service = TriviaService();
                        try {
                          Preguntas preguntas = await service.getTriviaQuestions('History');
                          Get.offAll(() => JuegoScreen(preguntas: preguntas));
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('Historia', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 16), // Espacio entre botones
                    // Botón 2
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        TriviaService service = TriviaService();
                        try {
                          Preguntas preguntas =
                              await service.getTriviaQuestions('Geography');
                          Get.offAll(() => JuegoScreen(preguntas: preguntas));
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child:
                            Text('Geografia', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 16), // Espacio entre botones
                    // Botón de Arte
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        TriviaService service = TriviaService();
                        try {
                          Preguntas preguntas =
                              await service.getTriviaQuestions('Art'); // Cambia 'Geography' por 'Art'
                          Get.offAll(() => JuegoScreen(preguntas: preguntas));
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('Arte', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
        ]
      ),
      // No hay BottomNavigationBar aquí
    );
  }
}
