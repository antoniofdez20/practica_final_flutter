import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/models.dart';

class FirebaseUsersController extends GetxController {
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfPswVisible = false.obs;

  RxList<User> users = <User>[].obs;
  late User tempUser;
  User? newUser;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfPswVisibility() {
    isConfPswVisible.toggle();
  }
}
