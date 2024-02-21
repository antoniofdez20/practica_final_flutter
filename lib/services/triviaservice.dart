
import 'package:http/http.dart' as http;
import 'package:practica_final_flutter/models/preguntas.dart';


class TriviaService {
  final String _baseUrl = 'https://opentdb.com/api.php';

  Future<Preguntas> getTriviaQuestions(String category) async {
    Map<String, String> categoryIds = {
      'Geography': '22',
      'History': '23',
      'Art': '25',
      // ... más categorías si son necesarias
    };

    var requestUrl = Uri.parse('$_baseUrl?amount=10&category=${categoryIds[category]}&type=multiple');
    print("funcionando " + requestUrl.toString());

    var response = await http.get(requestUrl);

    print("trivia" + response.body.toString());

    if (response.statusCode == 200) {
      // Usamos el modelo Preguntas para deserializar el JSON
      print("object" + response.body);
      return Preguntas.fromJson(response.body);
    } else {
      throw Exception('Failed to load trivia');
    }
  }
}
