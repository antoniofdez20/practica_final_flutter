import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/screens/juegoscreen.dart';
import 'package:practica_final_flutter/models/preguntas.dart';
import 'package:practica_final_flutter/services/triviaservice.dart';

class CargaScreen extends StatefulWidget {
  final String categoria; // Agregar un campo para la categoría
  const CargaScreen({Key? key, required this.categoria}) : super(key: key);

  @override
  State<CargaScreen> createState() => _CargaScreenState();
}

class _CargaScreenState extends State<CargaScreen> {
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
      Get.offAll(() => JuegoScreen(preguntas: preguntas));
    } catch (e) {
      print("Error al cargar las preguntas de ${widget.categoria}: $e");
      cargarPreguntas(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Cargando...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
