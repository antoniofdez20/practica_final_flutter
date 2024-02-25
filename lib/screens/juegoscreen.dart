import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:practica_final_flutter/controllers/juegocontroller.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:translator/translator.dart';

/// classe dedicada a la pantalla del joc on es mostren les diferents preguntes
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

        double percent =
            (controller.preguntaActual.value + 1) / preguntas.results.length;

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                barRadius: const Radius.circular(10.0),
                alignment: MainAxisAlignment.center,
                lineHeight: 20.0,
                percent: percent,
                center: Text('${(percent * 100).toStringAsFixed(0)}%'),
                progressColor: Colors.green,
              ),
            ),
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
