import 'package:flutter/material.dart';

class ImageCounter extends StatelessWidget {
  final String imagePath;
  final int counter;

  ImageCounter({required this.imagePath, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ), // Muestra la imagen
        const SizedBox(width: 10), // Añade un espacio entre la imagen y el contador
        Text("x$counter", // Muestra el contador
            style: const TextStyle(fontSize: 20)), // Ajusta el estilo del texto como necesites
      ],
    );
  }
}