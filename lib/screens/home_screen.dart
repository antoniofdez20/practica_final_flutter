import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/screens/juegoscreen.dart';
import 'package:practica_final_flutter/widgets/mydrawer.dart';

import '../controllers/controllers.dart';

import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:practica_final_flutter/services/triviaservice.dart'; 
import 'package:practica_final_flutter/widgets/bottomNavigationBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    return Obx(
      () => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Quizz Land"),
        actions: [
          
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              controller.resetCredencials();
              Get.offAllNamed('/login');
            },
          ),
          
        ],
      ),
      drawer: MyDrawer(),
      body: controller.users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          :Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Botón de Historia
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  TriviaService service = TriviaService();
                  try {
                    Preguntas preguntas = await service.getTriviaQuestions('History'); 
                    Get.offAll(() => JuegoScreen(preguntas: preguntas));
                  } catch (e) {
                    print("Error: $e");
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
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
             onPressed: () async {
              TriviaService service = TriviaService();
              try {
                Preguntas preguntas = await service.getTriviaQuestions('Geography');
                Get.offAll(() => JuegoScreen(preguntas: preguntas));
              } catch (e) {
                print("error");
              }
            },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Geografia', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 16), // Espacio entre botones
            // Botón de Arte
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              onPressed: () async {
                TriviaService service = TriviaService();
                try {
                  Preguntas preguntas = await service.getTriviaQuestions('Art'); // Cambia 'Geography' por 'Art'
                  Get.offAll(() => JuegoScreen(preguntas: preguntas));
                } catch (e) {
                  print("Error: $e");
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
      bottomNavigationBar: CustomNavigationBar(), 
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ),
  );
  }
}
  