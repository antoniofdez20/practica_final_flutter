import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/screens/resultado_juego_screen.dart';

class JuegoController extends GetxController {
  var preguntaActual = 0.obs;
  final FirebaseUsersController userController = Get.find<FirebaseUsersController>();

  int xpGanados = 0;
  int creditosGanados = 0;

  void verificarRespuesta(String respuestaSeleccionada, List<Result> results) {
    Result currentQuestion = results[preguntaActual.value];
    if (respuestaSeleccionada == currentQuestion.correctAnswer) {
      // Respuesta correcta, acumular puntos
      xpGanados += 100;
      creditosGanados += 10;

      // Mostrar diálogo de respuesta correcta
      Get.defaultDialog(
        title: '¡Correcto!',
        content: Text(
          'Has seleccionado la respuesta correcta.',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.green,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        onConfirm: () {
          Get.back(); // Cierra el diálogo antes de continuar
          if (preguntaActual.value < results.length - 1) {
            preguntaActual.value++;
          } else {
                userController.addXP(xpGanados + 1000); // XP de consolación
                userController.addCredits(creditosGanados + 50);
            // Navega a ResultadoJuegoScreen al finalizar el juego
            Get.offAll(() => ResultadoJuegoScreen(
              xpGanados: xpGanados + 1000,  // Incluye la bonificación final
              creditosGanados: creditosGanados + 50,  // Incluye la bonificación final
            ));
          }
        },
        textConfirm: "Continuar",
        confirmTextColor: Colors.white,
        buttonColor: Colors.green,
      );
    } else {
      // Respuesta incorrecta, aplicar XP de consolación y finalizar juego
      userController.addXP(xpGanados + 25); // XP de consolación
      userController.addCredits(creditosGanados); // Créditos acumulados

      // Mostrar diálogo de respuesta incorrecta
      Get.defaultDialog(
        title: 'Incorrecto',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Esa no era la respuesta correcta.'),
           
            SizedBox(height: 16),
            Text(
              'La respuesta correcta es:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              currentQuestion.correctAnswer,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
             Text("Has ganado $creditosGanados créditos"),
            Text("Has ganado  ${xpGanados + 25}  puntos de experiencia"),
          ],
        ),
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        onConfirm: () {
          Get.offAllNamed('/home'); // Vuelve al inicio
        },
        textConfirm: "Aceptar",
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
      );
    }
  }
}
