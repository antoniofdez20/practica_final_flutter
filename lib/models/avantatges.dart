import 'dart:convert';

class Avantatges {
  int menys25;
  int menys50;
  int mult15;
  int mult20;
  int resoldre;

  Avantatges({
    required this.menys25,
    required this.menys50,
    required this.mult15,
    required this.mult20,
    required this.resoldre,
  });

  factory Avantatges.fromJson(String str) =>
      Avantatges.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Avantatges.fromMap(Map<String, dynamic> json) => Avantatges(
        menys25: json["menys25"],
        menys50: json["menys50"],
        mult15: json["mult15"],
        mult20: json["mult20"],
        resoldre: json["resoldre"],
      );

  Map<String, dynamic> toMap() => {
        "menys25": menys25,
        "menys50": menys50,
        "mult15": mult15,
        "mult20": mult20,
        "resoldre": resoldre,
      };
}
