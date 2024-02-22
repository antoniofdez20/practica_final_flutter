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

  RxList<User> users = <User>[].obs;
  Rx<User> tempUser = User(
          id: PreferencesUserLogin.tempUserID,
          contrasenya: PreferencesUserLogin.tempPassword,
          email: PreferencesUserLogin.tempEmail,
          credits: PreferencesUserLogin.tempCredits,
          xp: PreferencesUserLogin.tempXP,
          username: PreferencesUserLogin.tempUsername)
      .obs;
  RxString confirmPassword = ''.obs;

  FirebaseUsersController() {
    loadUsers();
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
          final auxUser = User.fromMap(value);
          auxUser.id = key;
          users.add(auxUser);
        });
      }
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al cargar usuarios: $e');
    }
  }

  Future<void> createUser(Rx<User> tempUser) async {
    try {
      final userID =
          await _firebaseRealtimeService.addUser(tempUser.value.toMap());
      PreferencesUserLogin.tempUserID = userID;
      loadUsers();
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
        final user = User.fromMap(userData)..id = userID;
        tempUser.value = user;
      }
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al cargar usuario por ID: $e');
    }
  }

  Future<void> deleteUser() async {
    final userID = tempUser.value.id!;
    try {
      await _firebaseRealtimeService.deleteUser(userID);
      resetCredencials();
      loadUsers();
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al eliminar usuario: $e');
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
    }
  }

  void resetCredencials() {
    PreferencesUserLogin.tempUserID = '';
    PreferencesUserLogin.tempUsername = '';
    PreferencesUserLogin.tempPassword = '';
    PreferencesUserLogin.tempEmail = '';
    PreferencesUserLogin.tempCredits = 0;
    PreferencesUserLogin.tempXP = 0;
  }
}
