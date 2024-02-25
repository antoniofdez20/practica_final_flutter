import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/preguntas.dart';

/// controlador per la part de quizz de la aplicació, el qual gestiona les preguntes i les respostes
class JuegoController extends GetxController {
  var preguntaActual = 0.obs;

  void verificarRespuesta(String respuestaSeleccionada, List<Result> results) {
    Result currentQuestion = results[preguntaActual.value];
    if (respuestaSeleccionada == currentQuestion.correctAnswer) {
      // Respuesta correcta
      Get.snackbar(
        '¡Correcto!',
        'Has seleccionado la respuesta correcta.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      if (preguntaActual.value < results.length - 1) {
        preguntaActual.value++; // Avanza a la siguiente pregunta
      } else {
        // Aquí podrías manejar el fin del juego
        Get.offAllNamed('/home'); // O mostrar un mensaje de éxito
      }
    } else {
      // Respuesta incorrecta
      Get.defaultDialog(
        title: 'Incorrecto',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Esa no era la respuesta correcta.'),
            SizedBox(height: 16),
            Text('La respuesta correcta es:'),
            SizedBox(height: 8),
            Text(
              currentQuestion.correctAnswer,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        onConfirm: () {
          Get.offAllNamed('/home'); // Vuelve al inicio si la respuesta es incorrecta
        },
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
      );
    }
  }

}
