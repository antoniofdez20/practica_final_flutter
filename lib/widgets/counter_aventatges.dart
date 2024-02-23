import 'package:flutter/material.dart';

class ImageCounter extends StatelessWidget {
  final String imagePath;
  final String name;
  final int counter;
  final double size;

  const ImageCounter(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.counter,
      required this.size});

  get label => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // imagen
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 25, top: 35),
        ),
        Image.asset(
          imagePath,
          width: size,
          height: size,
        ), // Muestra la imagen

        // nombre
        const Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          name,
          style: const TextStyle(fontSize: 20),
        ),

        // contador
        Expanded(
            child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("x$counter", // Muestra el contador
                style: const TextStyle(fontSize: 20)),
          ),
        )),
      ],
    );
  }
}
