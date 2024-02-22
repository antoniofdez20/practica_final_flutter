import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/widgets/image_button.dart';
import 'package:practica_final_flutter/widgets/bottom_navigation_bar.dart';
import 'package:practica_final_flutter/widgets/mydrawer.dart';

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
      drawer: const MyDrawer(),
      body: Center(
        child: ImageButton(
          imagePath: 'assets/img/sobre.png',
          onPressed: () {
            Get.offAllNamed('/home');
          },
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          Get.offAllNamed('/home');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
