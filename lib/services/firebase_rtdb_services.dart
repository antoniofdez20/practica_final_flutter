import 'package:get/get.dart';

class FirebaseRealtimeService extends GetConnect {
  // La URL base de Firebase debe terminar en `.firebaseio.com`
  final String _baseUrl =
      "https://quizz-land-890b2-default-rtdb.europe-west1.firebasedatabase.app";

  // Método para leer datos
  Future<Map<String, dynamic>> readData(String path) async {
    // Asegúrate de que la ruta a la que haces la petición termina en `.json`
    final response = await get('$_baseUrl/$path');
    if (response.status.hasError) {
      // Si hay un error, manejarlo aquí
      return Future.error(response.statusText!);
    } else {
      // Asegúrate de que el cuerpo de la respuesta no es nulo antes de hacer el cast
      if (response.body != null) {
        return response.body;
      } else {
        return {};
      }
    }
  }

  Future<void> addUser(Map<String, dynamic> tempUser) async {
    final response = await post('$_baseUrl/users.json', tempUser);
    if (response.status.hasError) {
      return Future.error('Error al crear usuario: ${response.statusText}');
    } else {
      // Aquí puedes manejar la respuesta de Firebase, por ejemplo, obtener el ID del usuario creado
      print('Usuario creado: ${response.body}');
    }
  }
}
