import 'dart:convert';

class User {
  String? id;
  String contrasenya;
  String nom;
  String username;

  User({
    this.id,
    required this.contrasenya,
    required this.nom,
    required this.username,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        contrasenya: json["contrasenya"],
        nom: json["nom"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "contrasenya": contrasenya,
        "nom": nom,
        "username": username,
      };

  User copy() =>
      User(contrasenya: contrasenya, nom: nom, username: username, id: id);
}
