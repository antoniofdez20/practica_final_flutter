import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/models/models.dart';

class FirebaseUsersController extends GetxController {
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();
  RxList<User> users = <User>[].obs;
  late User tempUser;
  User? newUser;
  /* final _email = ''.obs;
  final _password = ''.obs;

  String get email => _email.value;
  String get password => _password.value;

  void setEmail(String value) => _email.value = value;
  void setPassword(String value) => _password.value = value; */
}
