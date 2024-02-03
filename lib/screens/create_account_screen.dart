import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Quizz Land'),
        ),
        body: Center(
            child: FloatingActionButton.extended(
          onPressed: () {
            Get.offNamed('/login');
          },
          label: const Text('Volver al login'),
        )));
  }
}
