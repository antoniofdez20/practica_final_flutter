import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Quizz Land"),
      ),
      body: const Center(
        child:
          ImageIcon(
            AssetImage('assets/img/sobre.png'),
            size: 500,
          ),
           
        )
      );
  }
}