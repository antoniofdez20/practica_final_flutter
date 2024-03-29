import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/models.dart';
import 'package:practica_final_flutter/preferences/preferences.dart';
import 'package:practica_final_flutter/services/services.dart';

/// controlador principal de la aplicació el qual realitza les operacions de CRUD
/// amb els usuaris de la base de dades de Firebase i a més a més, gestiona les
/// credencials de l'usuari temporal.
class FirebaseUsersController extends GetxController {
  final FirebaseRealtimeService _firebaseRealtimeService =
      FirebaseRealtimeService();
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfPswVisible = false.obs;
  RxList<User> usersNoAdmin = <User>[].obs;
  RxList<User> users = <User>[].obs;
  RxList<User> filteredUsers = <User>[].obs;
  RxString filter = ''.obs;
  Rx<User> tempUser = User(
          id: PreferencesUserLogin.tempUserID,
          contrasenya: PreferencesUserLogin.tempPassword,
          email: PreferencesUserLogin.tempEmail,
          credits: PreferencesUserLogin.tempCredits,
          xp: PreferencesUserLogin.tempXP,
          username: PreferencesUserLogin.tempUsername,
          avantatges: Avantatges(
              menys25: PreferencesUserLogin.tempMenys25,
              menys50: PreferencesUserLogin.tempMenys50,
              mult15: PreferencesUserLogin.tempMult15,
              mult20: PreferencesUserLogin.tempMult20,
              resoldre: PreferencesUserLogin.tempResoldre))
      .obs;
  RxString confirmPassword = ''.obs;

  /// Aquesta funció s'executa quan el controlador s'inicialitza, aixi obtenim la llista d'usuaris
  /// de la base de dades i la ordenem segons la puntuació per després filtrar els 5 primers en el ranking.
  @override
  void onInit() {
    super.onInit();
    loadUsers().then((_) {
      sortUsers();
    });
  }

  void updateFilter(String value) {
    filter.value = value;
    filterUsers(value);
  }

  void sortUsers() {
    users.sort((a, b) => b.xp.compareTo(a.xp));
    usersNoAdmin.value =
        users.where((user) => user.username.toLowerCase() != "admin").toList();
    filterTopFive();
  }

 void filterTopFive() {
  // Crear un mapa para filtrar usuarios duplicados basándose en su ID o username.
  var uniqueMap = <String, User>{};
  for (var user in usersNoAdmin) {
    if (!uniqueMap.containsKey(user.id)) { // Asumiendo que 'id' es único para cada usuario.
      uniqueMap[user.id!] = user;
    }
  }

  // Tomar los primeros 5 usuarios únicos para el ranking.
  filteredUsers.value = uniqueMap.values.take(5).toList();
}

  void filterUsers(String query) {
  if (query.isNotEmpty) {
    var tmpList = usersNoAdmin.where((user) => user.username.toLowerCase().contains(query.toLowerCase())).toList();
    // Usando un Map para eliminar duplicados basados en el ID o username, lo que prefieras
    var uniqueMap = { for (var user in tmpList) user.id: user };
    filteredUsers.value = uniqueMap.values.toList();
  } else {
    filterTopFive();
  }
}

  ///mètodes per a la gestió de la visibilitat de la contrasenya
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfPswVisibility() {
    isConfPswVisible.toggle();
  }

  ///mètode per encriptar la contrasenya de l'usuari registrat
  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  ///mètodes per a les accions CRUD amb la base de dades de Firebase
  Future<void> loadUsers() async {
    users.clear();
    try {
      final response = await _firebaseRealtimeService.readData('users.json');

      if (response.isNotEmpty) {
        response.forEach((key, value) {
          Map<String, dynamic> userData = value as Map<String, dynamic>;
          final auxUser = User.fromMap(userData);
          auxUser.id = key;
          // Asegurarse de que la clave usada aquí coincida con la de tus datos
          auxUser.avantatges = Avantatges.fromMap(
              userData['avantatges'] as Map<String, dynamic>);
          users.add(auxUser);
        });
      }
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }

  Future<void> createUser(Rx<User> tempUser) async {
    tempUser.value.contrasenya = hashPassword(tempUser.value.contrasenya);
    try {
      final userID =
          await _firebaseRealtimeService.addUser(tempUser.value.toMap());
      PreferencesUserLogin.tempUserID = userID;
      await loadUsers();
      sortUsers();
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al crear usuario: $e');
    }
  }

  Future<void> loadUserByID() async {
    final userID = PreferencesUserLogin.tempUserID;

    try {
      final userData = await _firebaseRealtimeService.readUserById(userID);
      if (userData.isNotEmpty) {
        Map<String, dynamic> userMap = Map<String, dynamic>.from(userData);
        final user = User.fromMap(userMap);
        user.id = userID;

        // Asegurarte de que el avantatges se carga correctamente
        if (userMap.containsKey('avantatges') && userMap['avantatges'] is Map) {
          user.avantatges = Avantatges.fromMap(userMap['avantatges']);
        } else {
          // Asignar valores predeterminados o manejar la ausencia de avantatges de alguna manera
          user.avantatges = Avantatges(
              menys25: 0, menys50: 0, mult15: 0, mult20: 0, resoldre: 0);
        }

        tempUser.value = user;
      }
    } catch (e) {
      print('Error al cargar usuario por ID: $e');
    }
  }

  Future<void> deleteUser() async {
    final userID = tempUser.value.id!;
    try {
      await _firebaseRealtimeService.deleteUser(userID);
      resetCredencials();
      await loadUsers();
      sortUsers();
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al eliminar usuario: $e');
    }
  }

  Future<void> updateUser() async {
    final userID = tempUser.value.id!;
    try {
      await _firebaseRealtimeService.updateUser(tempUser.value.toMap(), userID);
      await loadUsers();
      sortUsers();
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al actualizar usuario: $e');
    }
  }

  ///mètodes per a la gestió de les credencials de l'usuari temporal, d'aquesta manera
  ///es poden persistir i recuperar les dades de l'usuari temporal.
  Future<void> saveCredencials(String username, String password) async {
    final user = users.firstWhereOrNull((u) => u.username == username);
    if (user != null) {
      PreferencesUserLogin.tempUserID = user.id!;
      PreferencesUserLogin.tempUsername = username;
      PreferencesUserLogin.tempPassword = password;
      PreferencesUserLogin.tempEmail = user.email;
      PreferencesUserLogin.tempCredits = user.credits;
      PreferencesUserLogin.tempXP = user.xp;
      PreferencesUserLogin.tempMenys25 = user.avantatges.menys25;
      PreferencesUserLogin.tempMenys50 = user.avantatges.menys50;
      PreferencesUserLogin.tempMult15 = user.avantatges.mult15;
      PreferencesUserLogin.tempMult20 = user.avantatges.mult20;
      PreferencesUserLogin.tempResoldre = user.avantatges.resoldre;
    }
  }

  void resetCredencials() {
    PreferencesUserLogin.tempUserID = '';
    PreferencesUserLogin.tempUsername = '';
    PreferencesUserLogin.tempPassword = '';
    PreferencesUserLogin.tempEmail = '';
    PreferencesUserLogin.tempCredits = 0;
    PreferencesUserLogin.tempXP = 0;
    PreferencesUserLogin.tempMenys25 = 0;
    PreferencesUserLogin.tempMenys50 = 0;
    PreferencesUserLogin.tempMult15 = 0;
    PreferencesUserLogin.tempMult20 = 0;
    PreferencesUserLogin.tempResoldre = 0;

    // Actualizar el tempUser de acuerdo a las nuevas preferencias reseteadas
    //esto lo hago porque en el caso de que el usuario cierre sesion pero no reinicie la app
    //las credenciales de tempUser no se actualizan y da pie a errores en campos como la puntuacion
    tempUser.value = User(
      id: PreferencesUserLogin.tempUserID,
      username: PreferencesUserLogin.tempUsername,
      contrasenya: PreferencesUserLogin.tempPassword,
      email: PreferencesUserLogin.tempEmail,
      credits: PreferencesUserLogin.tempCredits,
      xp: PreferencesUserLogin.tempXP,
      avantatges: Avantatges(
          menys25: PreferencesUserLogin.tempMenys25,
          menys50: PreferencesUserLogin.tempMenys50,
          mult15: PreferencesUserLogin.tempMult15,
          mult20: PreferencesUserLogin.tempMult20,
          resoldre: PreferencesUserLogin.tempResoldre),
    );
  }

   void addXP(int xp) {
  tempUser.value.xp += xp;
  updateUser();
  PreferencesUserLogin.tempXP = tempUser.value.xp;
}

void addCredits(int credits) {
  tempUser.value.credits += credits;
  updateUser();
  PreferencesUserLogin.tempCredits = tempUser.value.credits;
}

void updateUserVentajas() {
  tempUser.value.avantatges.menys25 = PreferencesUserLogin.tempMenys25;
  tempUser.value.avantatges.menys50 = PreferencesUserLogin.tempMenys50;
  tempUser.value.avantatges.mult15 = PreferencesUserLogin.tempMult15;
  tempUser.value.avantatges.mult20 = PreferencesUserLogin.tempMult20;
  tempUser.value.avantatges.resoldre = PreferencesUserLogin.tempResoldre;
  updateUser();
}


  void usarVentaja(String ventaja) {
    switch (ventaja) {
      case 'mult15':
        if (PreferencesUserLogin.tempMult15 > 0) {
          PreferencesUserLogin.tempMult15--;
        }
        break;
      case 'mult20':
        if (PreferencesUserLogin.tempMult20 > 0) {
          PreferencesUserLogin.tempMult20--;
        }
        break;
      case 'menos25':
        if (PreferencesUserLogin.tempMenys25 > 0) {
          PreferencesUserLogin.tempMenys25--;
        }
        break;
      case 'menos50':
        if (PreferencesUserLogin.tempMenys50 > 0) {
          PreferencesUserLogin.tempMenys50--;
        }
        break;
      case 'resolver':
        if (PreferencesUserLogin.tempResoldre > 0) {
          PreferencesUserLogin.tempResoldre--;
        }
        break;
    }
    updateUserVentajas();  // Actualiza la información en el usuario y posiblemente en Firebase.
    update();  // Actualiza los widgets que dependen de este controlador.
  }

  int getVentajaCount(String ventaja) {
    switch (ventaja) {
      case 'mult15':
        return PreferencesUserLogin.tempMult15;
      case 'mult20':
        return PreferencesUserLogin.tempMult20;
      case 'menos25':
        return PreferencesUserLogin.tempMenys25;
      case 'menos50':
        return PreferencesUserLogin.tempMenys50;
      case 'resolver':
        return PreferencesUserLogin.tempResoldre;
      default:
        return 0;
    }
  }


}
