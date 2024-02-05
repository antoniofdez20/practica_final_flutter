import 'dart:convert';

class User {
  String? id;
  String contrasenya;
  String nom;

  User({
    this.id,
    required this.contrasenya,
    required this.nom,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        contrasenya: json["contrasenya"],
        nom: json["nom"],
      );

  Map<String, dynamic> toMap() => {
        "contrasenya": contrasenya,
        "nom": nom,
      };

  User copy() => User(contrasenya: contrasenya, nom: nom, id: id);
}
