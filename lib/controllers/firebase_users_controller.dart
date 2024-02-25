import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/models.dart';
import 'package:practica_final_flutter/preferences/preferences.dart';
import 'package:practica_final_flutter/services/services.dart';

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
    filteredUsers.value = usersNoAdmin.take(5).toList();
  }

  void filterUsers(String query) {
    if (query.isNotEmpty) {
      var tmpList = usersNoAdmin
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredUsers.value = tmpList.toList();
    } else {
      filterTopFive();
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfPswVisibility() {
    isConfPswVisible.toggle();
  }

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
    try {
      final userID =
          await _firebaseRealtimeService.addUser(tempUser.value.toMap());
      PreferencesUserLogin.tempUserID = userID;
      await loadUsers();
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
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al actualizar usuario: $e');
    }
  }

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
}
