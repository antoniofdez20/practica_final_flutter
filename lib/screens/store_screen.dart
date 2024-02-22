import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/widgets/image_button.dart';

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
      body: Center(
        child: ImageButton(
          imagePath: 'assets/img/sobre.png',
          onPressed: () {
            Opening();
          },
        ),
      ),
    );
  }
  
  void Opening() {
    int rnd = generateRND();
    String title = "Error!";
    String img = "assets/img/sobre.png";

    if (rnd > 3) {
      title = "Logo!";
      img = "assets/img/sobre.png";
    } else {
      title = "¡Lo siento!";
    }

    Get.defaultDialog(
      title: title,
      content: Image.asset(img),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Collect!"),
        ),
      ],
    );
  }
}

int generateRND() {
  final rnd = Random();
  final number = rnd.nextInt(10);
  return number;
}
