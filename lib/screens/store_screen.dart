import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/widgets/image_button.dart';
import 'package:practica_final_flutter/widgets/bottomNavigationBar.dart';
import 'package:practica_final_flutter/widgets/mydrawer.dart';

import '../widgets/counter_aventatges.dart'; 

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Quizz Land"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // eliminacion de preguntas
              Column(
                children: [
                  // menos25
                  ImageCounter(
                    imagePath: 'assets/icons/ic_launcher_round.png',
                    counter: 100,
                  ),
                  // menos50
                  ImageCounter(
                    imagePath: 'assets/icons/ic_launcher_round.png',
                    counter: 100,
                  ),
                  // resoldre
                  ImageCounter(
                    imagePath: 'assets/icons/ic_launcher_round.png',
                    counter: 100,
                  ),
                ],
              ),
              // multiplicadores
              Column(
                children: [
                  // mult15
                  ImageCounter(
                    imagePath: 'assets/icons/ic_launcher_round.png',
                    counter: 100,
                  ),
                  // mult20
                  ImageCounter(
                    imagePath: 'assets/icons/ic_launcher_round.png',
                    counter: 100,
                  ),
                ],
              ),
            ],
          ),
          // Sobre
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ImageButton(
                  imagePath: 'assets/img/sobre.png',
                  onPressed: () {
                    Opening();
                  }
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(), 
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow), 
        onPressed: () {
           Get.offAllNamed('/home');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
    );
  }
  
  void Opening() {
    int rnd = generateRND();
    String title = "Error!";
    String img = "assets/img/sobre.png";

    // mult15 - 35%
    if (rnd <= 3500) {
      title = "Multiplicar els punst per 1.5";
      img = "assets/img/sobre.png";
    }
    // menos25 - 25%
    else if (rnd > 3500 && rnd <= 6000) {
      title = "Descartar una de les respostes incorrectes";
      img = "assets/img/sobre.png";
    }
    // mult20 - 20%
    else if (rnd > 6000 && rnd <= 8000) {
      title = "Multiplicar els punst per 2";
      img = "assets/img/sobre.png";
    }
    // menos50 - 15%
    else if (rnd > 8000 && rnd <= 9500) {
      title = "Descartar dues de les respostes incorrectes";
      img = "assets/img/sobre.png";
    }
    // resoldre - 5%
    else if (rnd > 9500) {
      title = "Resoldre la pregunta directament";
      img = "assets/img/sobre.png";
    } else {
      title = "Error!";
      img = "assets/img/sobre.png";
    }

    Get.defaultDialog(
      title: title,
      content: Image.asset(img),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Recollir!"),
        ),
      ],
    );
  }
}

int generateRND() {
  final rnd = Random();
  final number = rnd.nextInt(10000);
  return number;
}
