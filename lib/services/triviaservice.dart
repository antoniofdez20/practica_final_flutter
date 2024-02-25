import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:practica_final_flutter/models/preguntas.dart';

/// Classe que gestiona les crides a l'API per obtenir les preguntes del quizz.
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

    final response = await get(
        '$_baseUrl?amount=10&category=${categoryIds[category]}&type=multiple');

    if (response.status.hasError) {
      return Future.error('Error al cargar las preguntas de trivia');
    } else {
      var unescape = HtmlUnescape();
      // Intenta decodificar 4 veces
      for (int i = 0; i < 4; i++) {
        try {
          var decodedResponseBody = unescape.convert(response.bodyString!);
          return Preguntas.fromJson(decodedResponseBody);
        } catch (e) {
          print(
              "Intento ${i + 1}: Ocurrió un error al decodificar el JSON: $e");
          if (i == 3) {
            // Si es el último intento
            print(
                "Devolviendo el cuerpo del JSON sin modificar después de varios intentos.");
            return Preguntas.fromJson(response.bodyString!);
          }
          // Espera un poco antes del siguiente intento
          await Future.delayed(Duration(seconds: 1));
        }
      }
      // Si todos los intentos fallan, devuelve el cuerpo sin decodificar
      print(
          "Devolviendo el cuerpo del JSON sin modificar después de intentos fallidos.");
      return Preguntas.fromJson(response.bodyString!);
    }
  }
}
