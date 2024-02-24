import 'dart:convert';
import 'package:practica_final_flutter/models/models.dart';

class User {
  String? id;
  Avantatges avantatges;
  String email;
  String contrasenya;
  int credits;
  int xp;
  String username;

  User({
    this.id,
    required this.avantatges,
    required this.email,
    required this.contrasenya,
    required this.credits,
    required this.xp,
    required this.username,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        avantatges: Avantatges.fromMap(json["avantatges"]),
        email: json["email"],
        contrasenya: json["contrasenya"],
        credits: json["credits"],
        xp: json["xp"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "avantatges": avantatges.toMap(),
        "email": email,
        "contrasenya": contrasenya,
        "credits": credits,
        "xp": xp,
        "username": username,
      };

  User copy() => User(
      avantatges: avantatges,
      email: email,
      contrasenya: contrasenya,
      credits: credits,
      xp: xp,
      username: username,
      id: id);
}
