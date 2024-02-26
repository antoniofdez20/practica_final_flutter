import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:practica_final_flutter/controllers/juegocontroller.dart';
import 'package:practica_final_flutter/controllers/firebase_users_controller.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:translator/translator.dart';

class JuegoScreen extends StatelessWidget {
  final Preguntas preguntas;
  final JuegoController juegoController; // Define juegoController como atributo final
  final FirebaseUsersController firebaseUsersController = Get.find<FirebaseUsersController>();

  JuegoScreen({super.key, required this.preguntas})
      : juegoController = Get.put(JuegoController(preguntas: preguntas)) {
    // La instancia de JuegoController ahora se guarda en un atributo de la clase.
  }



  Future<String> _translateText(String text, String toLanguage) async {
    final translator = GoogleTranslator();
    try {
      var translation = await translator.translate(text, to: toLanguage);
      return translation.text;
    } catch (e) {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(preguntas.results[juegoController.preguntaActual.value].category),
      ),
      body: Obx(() {
        var pregunta = preguntas.results[juegoController.preguntaActual.value];

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                barRadius: const Radius.circular(10.0),
                alignment: MainAxisAlignment.center,
                lineHeight: 20.0,
                percent: (juegoController.preguntaActual.value + 1) / preguntas.results.length,
                center: Text('${((juegoController.preguntaActual.value + 1) / preguntas.results.length * 100).toStringAsFixed(0)}%'),
                progressColor: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<String>(
                future: _translateText(pregunta.question, 'es'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Text(snapshot.data ?? pregunta.question, style: TextStyle(fontSize: 24), textAlign: TextAlign.center);
                },
              ),
            ),
            ...juegoController.opcionesActuales.map((respuesta) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                onPressed: () => juegoController.verificarRespuesta(respuesta, preguntas.results),
                child: Text(respuesta, style: TextStyle(fontSize: 18)),
              ),
            )).toList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildVentajaButton(context, 'assets/icons/mult15.png', 'mult15'),
                  buildVentajaButton(context, 'assets/icons/mult20.png', 'mult20'),
                  buildVentajaButton(context, 'assets/icons/menos25.png', 'menos25'),
                  buildVentajaButton(context, 'assets/icons/menos50.png', 'menos50'),
                  buildVentajaButton(context, 'assets/icons/resolver.png', 'resolver'),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildVentajaButton(BuildContext context, String imagePath, String ventaja) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            juegoController.aplicarVentaja(ventaja, preguntas.results);
          },
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        GetBuilder<JuegoController>(
          builder: (controller) {
            int ventajaCount = controller.getVentajaCount(ventaja);
            return Text('$ventajaCount', style: Theme.of(context).textTheme.caption);
          },
        ),
      ],
    );
  }
}
