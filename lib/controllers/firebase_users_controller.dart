import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/models.dart';
import 'package:practica_final_flutter/services/services.dart';

class FirebaseUsersController extends GetxController {
  final FirebaseRealtimeService _firebaseRealtimeService =
      FirebaseRealtimeService();
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfPswVisible = false.obs;

  RxList<User> users = <User>[].obs;
  Rx<User> tempUser =
      User(contrasenya: '', email: '', credits: 0, xp: 0, username: '').obs;
  RxString confirmPassword = ''.obs;
  User? newUser;

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

      users.forEach((user) {
        print('Usuario: ${user.username}');
      });
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al cargar usuarios: $e');
    }
  }

  Future<void> createUser(Rx<User> tempUser) async {
    try {
      await _firebaseRealtimeService.addUser(tempUser.value.toMap());
      loadUsers();
    } catch (e) {
      // Manejar adecuadamente el error
      print('Error al crear usuario: $e');
    }
  }
}
