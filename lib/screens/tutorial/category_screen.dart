import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/screens/tutorial/tutorial_loading_screen.dart';

class TutorialCategoryScreen extends StatelessWidget {
  const TutorialCategoryScreen({super.key});

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
                Get.offNamed('/home');
              },
            ),
          ],
        ),
      ),
      body: Column(children: [
        const SizedBox(height: 40), // Espacio entre el texto y la imagen
        const Text(
          "Tria una de les següents categories:",
          style: TextStyle(fontSize: 24),
        ),

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
                        try {
                          Get.offAll(() => const TutorialCargaScreen(categoria: 'History'));
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
                        try {
                          Get.offAll(() => const TutorialCargaScreen(categoria: 'Geography'));
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
                        try {
                          Get.offAll(() => const TutorialCargaScreen(categoria: 'Art'));
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
      ]),
      // No hay BottomNavigationBar aquí
    );
  }
}
