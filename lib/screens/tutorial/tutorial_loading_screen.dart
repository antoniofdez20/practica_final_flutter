import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:practica_final_flutter/screens/screens.dart';
import 'package:practica_final_flutter/services/triviaservice.dart';

class TutorialCargaScreen extends StatefulWidget {
  final String categoria; // Agregar un campo para la categoría
  const TutorialCargaScreen({super.key, required this.categoria});

  @override
  State<TutorialCargaScreen> createState() => _TutorialCargaScreenState();
}

class _TutorialCargaScreenState extends State<TutorialCargaScreen> {
  @override
  void initState() {
    super.initState();
    cargarPreguntas();
  }

  void cargarPreguntas() async {
    TriviaService service = TriviaService();
    try {
      // Usar widget.categoria para cargar la categoría correspondiente
      Preguntas preguntas = await service.getTriviaQuestions(widget.categoria);
      Get.offAll(() => TutorialJuegoScreen(preguntas: preguntas));
    } catch (e) {
      print("Error al cargar las preguntas de ${widget.categoria}: $e");
      cargarPreguntas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Cargando...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
