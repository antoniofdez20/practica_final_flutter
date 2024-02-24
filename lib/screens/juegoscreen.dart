import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/juegocontroller.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:translator/translator.dart';

class JuegoScreen extends StatelessWidget {
  final Preguntas preguntas;
  final JuegoController controller = Get.put(JuegoController());

  JuegoScreen({Key? key, required this.preguntas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(preguntas.results[controller.preguntaActual.value].category),
      ),
      body: Obx(() {
        final pregunta = preguntas.results[controller.preguntaActual.value];
        List<String> todasLasRespuestas = [...pregunta.incorrectAnswers, pregunta.correctAnswer];
        todasLasRespuestas.shuffle();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<String>(
                future: _translateText(pregunta.question, 'es'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                      pregunta.question,
                      style: TextStyle(fontSize: 24),
                    );
                  } else {
                    return Text(
                      snapshot.data!,
                      style: TextStyle(fontSize: 24),
                    );
                  }
                },
              ),
            ),
            ...todasLasRespuestas
                .map((respuesta) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        ),
                        onPressed: () => controller.verificarRespuesta(respuesta, preguntas.results),
                        child: FutureBuilder<String>(
                          future: _translateText(respuesta, 'es'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text(
                                respuesta,
                                style: TextStyle(fontSize: 18),
                              );
                            } else {
                              return Text(
                                snapshot.data!,
                                style: TextStyle(fontSize: 18),
                              );
                            }
                          },
                        ),
                      ),
                    ))
                .toList(),
          ],
        );
      }),
    );
  }

  Future<String> _translateText(String text, String toLanguage) async {
    final translator = GoogleTranslator();
    try {
      Translation translation = await translator.translate(text, to: toLanguage);
      return translation.text!;
    } catch (e) {
      print('Error de traducción: $e');
      return text; // Devuelve el texto original en caso de error
    }
  }
}
