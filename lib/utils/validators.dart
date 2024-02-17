import 'package:practica_final_flutter/models/models.dart';

class Validators {
  static String? usernameValidator(String? value, List<User> users) {
    if (value == null || value.isEmpty) return 'El nom d\'usuari és obligatori';

    final regex = RegExp(r'^[a-zA-Z0-9_.-]*$');
    if (!regex.hasMatch(value)) return 'Nom d\'usuari no vàlid';

    if (users.any((user) => user.username == value))
      return 'Aquest nom d\'usuari ja està en ús';
    return null;
  }

  static String? emailLoginValidator(String? value, List<User> users) {
    if (value == null || value.isEmpty) {
      return 'El correu de l\'usuari és obligatori';
    }

    if (!users.any((user) => user.email == value)) {
      return 'Aquest correu no existeix';
    } else {
      return null;
    }
  }

  static String? emailValidator(String? value, List<User> users) {
    if (value == null || value.isEmpty)
      return 'El correu de l\'usuari és obligatori';

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Correu no vàlid';

    if (users.any((user) => user.email == value))
      return 'Aquest correu ja està en ús';
    return null;
  }

  static String? passwordLoginValidator(String? value) {
    if (value == null || value.isEmpty) return 'La contrasenya és obligatoria';
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'La contrasenya és obligatoria';

    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!regex.hasMatch(value))
      return 'La contrasenya ha de tenir almenys 8 caràcters, lletres i números';
    return null;
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) return 'Confirma la contrasenya';
    if (value != password) return 'Les contrasenyes no coincideixen';
    return null;
  }

  static bool validateLoginCredentials(
      String email, String password, List<User> users) {
    final User userFinal = users.firstWhere((user) => user.email == email,
        orElse: () =>
            User(email: '', contrasenya: '', credits: 0, xp: 0, username: ''));
    if (userFinal.contrasenya == password) {
      return true; // Las credenciales son correctas
    }
    return false; // Las credenciales son incorrectas
  }
}
