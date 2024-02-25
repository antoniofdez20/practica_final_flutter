import 'package:get/get.dart';
import 'package:practica_final_flutter/models/preguntas.dart';

class TutorialJuegoController extends GetxController {
  var preguntaActual = 0.obs;

  void verificarRespuesta(String respuestaSeleccionada, List<Result> results) {
    if (respuestaSeleccionada == results[preguntaActual.value].correctAnswer) {
      if (preguntaActual.value < results.length - 1) {
        preguntaActual.value++; // Avanza a la siguiente pregunta
      } else {
        // Aquí podrías manejar el fin del juego
        Get.offAllNamed('/tutorial/game/end'); // O mostrar un mensaje de éxito
      }
    } else {
      Get.offAllNamed('/tutorial/game/end'); // Vuelve al inicio si la respuesta es incorrecta
    }
  }
}
