import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/preferences/preferences.dart';
import 'package:practica_final_flutter/screens/resultado_juego_screen.dart';

class JuegoController extends GetxController {
  var preguntaActual = 0.obs;
  RxList<String> opcionesActuales = <String>[].obs;
  FirebaseUsersController userController = Get.find<FirebaseUsersController>();

  int xpGanados = 0;
  int creditosGanados = 0;
  double multiplicador = 1.0;
  Preguntas preguntas; // Asegúrate de que 'preguntas' se inicialice correctamente.

  JuegoController({required this.preguntas});

  @override
  void onInit() {
    super.onInit();
    setOpcionesActuales();
  }

  void setOpcionesActuales() {
    // Esta función configura las opciones actuales para la pregunta actual.
    var currentQuestion = preguntas.results[preguntaActual.value];
    opcionesActuales.value = [currentQuestion.correctAnswer, ...currentQuestion.incorrectAnswers];
    opcionesActuales.shuffle();
  }
  void verificarRespuesta(String respuestaSeleccionada, List<Result> results) {
    Result currentQuestion = results[preguntaActual.value];
    if (respuestaSeleccionada == currentQuestion.correctAnswer) {
      xpGanados += (100 * multiplicador).round();
      creditosGanados += (10 * multiplicador).round();
      multiplicador = 1.0;

      Get.defaultDialog(
        title: '¡Correcto!',
        content: Text('Has seleccionado la respuesta correcta.', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.green,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        onConfirm: () {
          Get.back();
          if (preguntaActual.value < results.length - 1) {
            preguntaActual.value++;
            setOpcionesActuales();
            update();
          } else {
            userController.addXP(xpGanados + 1000);
            userController.addCredits(creditosGanados + 50);
            Get.offAll(() => ResultadoJuegoScreen(xpGanados: xpGanados + 1000, creditosGanados: creditosGanados + 50));
          }
        },
        textConfirm: "Continuar",
        confirmTextColor: Colors.white,
        buttonColor: Colors.green,
        barrierDismissible: false,
      );
    } else {
      Get.defaultDialog(
        title: 'Incorrecto',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Esa no era la respuesta correcta.'),
            SizedBox(height: 16),
            Text('La respuesta correcta es:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(currentQuestion.correctAnswer, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Has ganado $creditosGanados créditos"),
            Text("Has ganado ${xpGanados + 25} puntos de experiencia"),
          ],
        ),
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        onConfirm: () {
          userController.addXP(xpGanados + 25);
          userController.addCredits(creditosGanados);
          Get.offAllNamed('/home');
        },
        textConfirm: "Aceptar",
        confirmTextColor: Colors.white,
        buttonColor: Colors.red,
        barrierDismissible: false,
      );
    }
    update();
  }

  void resolverPregunta(List<Result> results) {
    if (PreferencesUserLogin.tempResoldre > 0) {
      PreferencesUserLogin.tempResoldre--;
      userController.tempUser.value.avantatges.resoldre = PreferencesUserLogin.tempResoldre;
      userController.updateUserVentajas();
      verificarRespuesta(results[preguntaActual.value].correctAnswer, results);
    }
  }

    void eliminarRespuestasIncorrectas(int cantidad, List<Result> preguntasResults) {
    var currentQuestion = preguntasResults[preguntaActual.value];
    if ((cantidad == 1 && PreferencesUserLogin.tempMenys25 > 0) || (cantidad == 2 && PreferencesUserLogin.tempMenys50 > 0)) {
      // Reiniciar opcionesActuales solo con la respuesta correcta
      opcionesActuales.value = [currentQuestion.correctAnswer];

      // Seleccionar aleatoriamente las respuestas incorrectas a mantener
      List<String> respuestasAMantener = currentQuestion.incorrectAnswers..shuffle();
      opcionesActuales.addAll(respuestasAMantener.take(3 - cantidad)); // Asegurar que solo se añadan las necesarias

      if (cantidad == 1) PreferencesUserLogin.tempMenys25--;
      if (cantidad == 2) PreferencesUserLogin.tempMenys50--;

      userController.updateUserVentajas();
      opcionesActuales.shuffle(); // Mezclar las respuestas
      update(); // Notificar a los observadores para reconstruir la UI
    }
  }

  void aplicarVentaja(String ventaja, List<Result> results) {
  bool aplicar = false;
  switch (ventaja) {
    case 'mult15':
      if (PreferencesUserLogin.tempMult15 > 0) {
        PreferencesUserLogin.tempMult15 -= 1;
        multiplicador = 1.5;
        aplicar = true;
      }
      break;
    case 'mult20':
      if (PreferencesUserLogin.tempMult20 > 0) {
        PreferencesUserLogin.tempMult20 -= 1;

        multiplicador = 2.0;
        aplicar = true;
      }
      break;
    case 'menos25':
      if (PreferencesUserLogin.tempMenys25 > 0) {
        eliminarRespuestasIncorrectas(1, results);
        

        aplicar = true;
      }
      break;
    case 'menos50':
      if (PreferencesUserLogin.tempMenys50 > 0) {
        eliminarRespuestasIncorrectas(2, results);

        aplicar = true;
      }
      break;
    case 'resolver':
      if (PreferencesUserLogin.tempResoldre > 0) {
        resolverPregunta(results);

        aplicar = true;
      }
      break;
  }
  
  if (aplicar) {
    userController.updateUserVentajas(); // Asegúrate de que esta función actualiza las preferencias y llama a update()
    update(); // Notifica a los observadores sobre los cambios
  }
}

   int getVentajaCount(String ventaja) {
    // Retorna el conteo actual de la ventaja especificada.
    // Deberás implementar la lógica para devolver el conteo correcto según la ventaja.
    switch (ventaja) {
      case 'mult15':
        return PreferencesUserLogin.tempMult15;
      case 'mult20':
        return PreferencesUserLogin.tempMult20;
      case 'menos25':
        return PreferencesUserLogin.tempMenys25;
      case 'menos50':
        return PreferencesUserLogin.tempMenys50;
      case 'resolver':
        return PreferencesUserLogin.tempResoldre;
      default:
        return 0;
    }
  }
  

}
