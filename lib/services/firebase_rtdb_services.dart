import 'package:get/get.dart';

/// classe que s'encarrega de les peticions a la base de dades de Firebase
/// per tal de llegir, escriure, actualitzar i eliminar dades dels usuaris.
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
      if (response.body != null) {
        return response.body;
      } else {
        return {};
      }
    }
  }

  Future<String> addUser(Map<String, dynamic> tempUser) async {
    final response = await post('$_baseUrl/users.json', tempUser);
    if (response.status.hasError) {
      return Future.error('Error al crear usuario: ${response.statusText}');
    } else {
      // Devolver el id del usuario recien creado
      return response.body['name'];
    }
  }

  Future<Map<String, dynamic>> readUserById(String userId) async {
    final response = await get('$_baseUrl/users/$userId.json');
    if (response.status.hasError) {
      // Si hay un error, manejarlo aquí
      return Future.error(response.statusText!);
    } else {
      if (response.body != null) {
        return response.body;
      } else {
        return {};
      }
    }
  }

  Future<void> updateUser(Map<String, dynamic> tempUser, String userId) async {
    final response = await patch('$_baseUrl/users/$userId.json', tempUser);
    if (response.status.hasError) {
      return Future.error(
          'Error al actualizar usuario: ${response.statusText}');
    } else {
      print('Usuario actualizado');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response = await delete('$_baseUrl/users/$userId.json');
    if (response.status.hasError) {
      return Future.error('Error al eliminar usuario: ${response.statusText}');
    } else {
      print('Usuario eliminado');
    }
  }
}
