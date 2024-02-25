import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';

class ResultadoJuegoScreen extends StatelessWidget {
  final int xpGanados;
  final int creditosGanados;
    final FirebaseUsersController userController = Get.find<FirebaseUsersController>();

  ResultadoJuegoScreen({
    super.key,
    required this.xpGanados,
    required this.creditosGanados,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado del Juego'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Felicidades, has completado el juego!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'XP Ganados: $xpGanados',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Créditos Ganados: $creditosGanados',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/home');  // Vuelve al inicio o a la pantalla que consideres.
              },
              child: Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
