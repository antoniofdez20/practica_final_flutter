import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/screens/carga_screen.dart';
import 'package:practica_final_flutter/widgets/widgets.dart';
import '../controllers/controllers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    return Obx(
      () => Scaffold(
        appBar: const TopAppBar(title: 'Quizz Land'),
        drawer: const MyDrawer(),
        body: controller.users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                // Agrega SingleChildScrollView
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 80.0, right: 80.0, top: 16, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          try {
                            Get.offAll(() => const CargaScreen(
                                categoria: 'General Knowledge'));
                          } catch (e) {
                            print("Error: $e");
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Saber es poder',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          List<String> categoriasCiencia = [
                            'Science',
                            'Science: Computers',
                            'Science: Mathematics',
                            'Science: Gadgets',
                          ];

                          // Selecciona un índice al azar
                          var rnd = Random();
                          int indiceCategoria =
                              rnd.nextInt(categoriasCiencia.length);

                          // Selecciona la categoría basada en el índice aleatorio
                          String categoriaAleatoria =
                              categoriasCiencia[indiceCategoria];

                          // Navega a CargaScreen con la categoría seleccionada
                          Get.offAll(
                              () => CargaScreen(categoria: categoriaAleatoria));
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child:
                              Text('Ciencia', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          try {
                            Get.offAll(
                                () => const CargaScreen(categoria: 'Sports'));
                          } catch (e) {
                            print("Error: $e");
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child:
                              Text('Deportes', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          // Lista de subcategorías de entretenimiento
                          List<String> categoriasEntretenimiento = [
                            'Entertainment: Music',
                            'Entertainment: Film',
                            'Entertainment: Books',
                            'Entertainment: Television',
                            'Entertainment: Video Games',
                            'Entertainment: Board Games',
                            'Entertainment: Musicals & Theatres',
                            'Entertainment: Comics',
                            'Entertainment: Japanese Anime & Manga',
                            'Entertainment: Cartoon & Animations',
                          ];

                          // Selecciona un índice al azar
                          var rnd = Random();
                          int indiceCategoria =
                              rnd.nextInt(categoriasEntretenimiento.length);

                          // Selecciona la categoría basada en el índice aleatorio
                          String categoriaAleatoria =
                              categoriasEntretenimiento[indiceCategoria];

                          // Navega a CargaScreen con la categoría seleccionada
                          Get.offAll(
                              () => CargaScreen(categoria: categoriaAleatoria));
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Entretenimiento',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          try {
                            Get.offAll(
                                () => const CargaScreen(categoria: 'History'));
                          } catch (e) {
                            print("Error: $e");
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child:
                              Text('Historia', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          try {
                            Get.offAll(() =>
                                const CargaScreen(categoria: 'Geography'));
                          } catch (e) {
                            print("error");
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child:
                              Text('Geografia', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          try {
                            Get.offAll(
                                () => const CargaScreen(categoria: 'Art'));
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
              ),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
