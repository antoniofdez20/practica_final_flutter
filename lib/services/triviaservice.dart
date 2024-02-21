import 'package:get/get.dart';
import 'package:practica_final_flutter/models/preguntas.dart';

class TriviaService extends GetConnect {
  final String _baseUrl = 'https://opentdb.com/api.php';

  Future<Preguntas> getTriviaQuestions(String category) async {
    Map<String, String> categoryIds = {
      'Geography': '22',
      'History': '23',
      'Art': '25',
      // Añade más categorías según sea necesario
    };

    final response = await get('$_baseUrl?amount=10&category=${categoryIds[category]}&type=multiple');

    if (response.status.hasError) {
      return Future.error('Error al cargar las preguntas de trivia');
    } else {
      print(response.bodyString); // Imprime el cuerpo de la respuesta
      return Preguntas.fromJson(response.bodyString!);
    }
  }
}
