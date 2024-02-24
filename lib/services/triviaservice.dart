import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:practica_final_flutter/models/preguntas.dart';

class TriviaService extends GetConnect {
  final String _baseUrl = 'https://opentdb.com/api.php';

  Future<Preguntas> getTriviaQuestions(String category) async {
    Map<String, String> categoryIds = {
      'Geography': '22',
      'History': '23',
      'Art': '25',
      'Science': '17',
      'Science: Computers': '18',
      'Science: Mathematics': '19',
      'Science: Gadgets': '30',
      'Sports': '21',
      'Vehicles': '28',
      'General Knowledge': '9',
      'Entertainment: Music': '12',
      'Entertainment: Film': '11',
      'Entertainment: Books': '10',
      'Entertainment: Television': '14',
      'Entertainment: Video Games': '15',
      'Entertainment: Board Games': '16',
      'Entertainment: Musicals & Theatres': '13',
      'Entertainment: Comics': '29',
      'Entertainment: Japanese Anime & Manga': '31',
      'Entertainment: Cartoon & Animations': '32',
    };

    final response = await get('$_baseUrl?amount=10&category=${categoryIds[category]}&type=multiple');

  if (response.status.hasError) {
    return Future.error('Error al cargar las preguntas de trivia');
  } else {
    try {
      var unescape = HtmlUnescape();
      var decodedResponseBody = unescape.convert(response.bodyString!);
      return Preguntas.fromJson(decodedResponseBody);
    } catch (e) {
      print("Ocurrió un error al decodificar el JSON: $e");
      // Devolver el cuerpo sin decodificar en caso de error
      print("Devolviendo el cuerpo del JSON sin modificar.");
      return Preguntas.fromJson(response.bodyString!);
    }
  }
}
}