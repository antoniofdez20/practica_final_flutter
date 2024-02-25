import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/models/models.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';

///classe dedicada a la validació dels camps tant del login com del registre
class Validators {
  //validacio del camp de username en el registre
  static String? usernameValidator(String? value, List<User> users) {
    if (value == null || value.isEmpty) return 'El nom d\'usuari és obligatori';

    final regex = RegExp(r'^[a-zA-Z0-9_.-]*$');
    if (!regex.hasMatch(value)) return 'Nom d\'usuari no vàlid';

    if (users.any((user) => user.username == value))
      return 'Aquest nom d\'usuari ja està en ús';
    return null;
  }

  //validacio del camp de username en el login
  static String? usernameLoginValidator(String? value, List<User> users) {
    if (value == null || value.isEmpty) {
      return 'L\'usuari és obligatori';
    }

    return null;
  }

  //validacio del camp de email en el registre
  static String? emailValidator(String? value, List<User> users) {
    if (value == null || value.isEmpty)
      return 'El correu de l\'usuari és obligatori';

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Correu no vàlid';

    if (users.any((user) => user.email == value))
      return 'Aquest correu ja està en ús';
    return null;
  }

  //validacio del camp de email en el login
  static String? passwordLoginValidator(String? value) {
    if (value == null || value.isEmpty) return 'La contrasenya és obligatoria';
    return null;
  }

  //validacio del camp de password en el registre
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'La contrasenya és obligatoria';

    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!regex.hasMatch(value))
      return 'La contrasenya ha de tenir almenys 8 caràcters, lletres i números';
    return null;
  }

  //validacio del camp de confirmacio de password en el registre
  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) return 'Confirma la contrasenya';
    if (value != password) return 'Les contrasenyes no coincideixen';
    return null;
  }

  //validacio de les credencials que introdueix l'usuari en el login per identificar-se
  static bool validateLoginCredentials(String username, String password,
      List<User> users, FirebaseUsersController controller) {
    final User userFinal = users.firstWhere((user) => user.username == username,
        orElse: () => User(
            email: '',
            contrasenya: '',
            credits: 0,
            xp: 0,
            username: '',
            avantatges: Avantatges(
                menys25: 0, menys50: 0, mult15: 0, mult20: 0, resoldre: 0)));
    if (userFinal.contrasenya == password ||
        userFinal.contrasenya == controller.hashPassword(password)) {
      return true; // Las credenciales son correctas
    }
    return false; // Las credenciales son incorrectas
  }

  //mostra un snackbar en cas de que les credencials no siguin correctes en el login
  static void showLoginErrorSnackbar() {
    Get.snackbar(
      "Error",
      "No s'ha pogut iniciar sessió, revisa les dades introduïdes",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
      backgroundColor: MyColors.greenVogue,
      colorText: MyColors.selectiveYellow,
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      shouldIconPulse: true,
    );
  }
}
