// En juego.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/juegocontroller.dart';
import 'package:practica_final_flutter/models/preguntas.dart';

class JuegoScreen extends StatelessWidget {
  final Preguntas preguntas;
  final JuegoController controller = Get.put(JuegoController());

  JuegoScreen({super.key, required this.preguntas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              preguntas.results[controller.preguntaActual.value].category)),
      body: Obx(() {
        final pregunta = preguntas.results[controller.preguntaActual.value];
        List<String> todasLasRespuestas = [
          ...pregunta.incorrectAnswers,
          pregunta.correctAnswer
        ];
        todasLasRespuestas.shuffle();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(pregunta.question, style: TextStyle(fontSize: 24)),
            ),
            ...todasLasRespuestas
                .map((respuesta) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .blue, // Añade aquí el color real que necesitas
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                        ),
                        onPressed: () => controller.verificarRespuesta(
                            respuesta, preguntas.results),
                        child: Text(respuesta, style: TextStyle(fontSize: 18)),
                      ),
                    ))
                .toList(),
          ],
        );
      }),
    );
  }
}
