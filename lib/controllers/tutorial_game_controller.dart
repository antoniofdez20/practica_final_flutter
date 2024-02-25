import 'package:get/get.dart';
import 'package:practica_final_flutter/models/preguntas.dart';

/// controlador per la part de quizz de la aplicació, el qual gestiona les preguntes i les respostes
/// en aquest cas unicament del tutorial de la aplicació.
class TutorialJuegoController extends GetxController {
  var preguntaActual = 0.obs;

  void verificarRespuesta(String respuestaSeleccionada, List<Result> results) {
    if (respuestaSeleccionada == results[preguntaActual.value].correctAnswer) {
      if (preguntaActual.value < results.length - 1) {
        preguntaActual.value++; // avança a la següent pregunta
      } else {
        Get.offAllNamed(
            '/tutorial/game/end'); // anar a la pantalla final del tutorial
      }
    } else {
      Get.offAllNamed(
          '/tutorial/game/end'); // anar a la pantalla final del tutorial
    }
  }
}
