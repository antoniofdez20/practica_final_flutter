import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/juegocontroller.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:translator/translator.dart';

class JuegoScreen extends StatelessWidget {
  final Preguntas preguntas;
  final JuegoController controller = Get.put(JuegoController());

  JuegoScreen({super.key, required this.preguntas});

  Future<String> _translateText(String text, String toLanguage) async {
    final translator = GoogleTranslator();
    try {
      Translation translation =
          await translator.translate(text, to: toLanguage);
      return translation.text;
    } catch (e) {
      return text; // Devuelve el texto original en caso de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(preguntas.results[controller.preguntaActual.value].category),
      ),
      body: Obx(() {
        final pregunta = preguntas.results[controller.preguntaActual.value];
        List<String> todasLasRespuestas = [
          ...pregunta.incorrectAnswers,
          pregunta.correctAnswer
        ];
        todasLasRespuestas.shuffle();

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<String>(
                future: _translateText(pregunta.question, 'es'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Text(
                    snapshot.data ?? pregunta.question,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            ...todasLasRespuestas.map((respuesta) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                    ),
                    onPressed: () => controller.verificarRespuesta(
                        respuesta, preguntas.results),
                    child: FutureBuilder<String>(
                      future: _translateText(respuesta, 'es'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          snapshot.data ?? respuesta,
                          style: const TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ),
                )),
          ],
        );
      }),
    );
  }
}
