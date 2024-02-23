import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';
import 'package:practica_final_flutter/widgets/image_button.dart';
import 'package:practica_final_flutter/widgets/bottom_navigation_bar.dart';
import 'package:practica_final_flutter/widgets/mydrawer.dart';
import '../widgets/counter_aventatges.dart';
import '../widgets/top_app_bar.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(title: 'Quizzosco'),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // Sobre
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ImageButton(
                    imagePath: 'assets/img/sobre.png',
                    onPressed: () {
                      _opening();
                    });
              },
            ),
          ),
          // Aventatges
          ElevatedButton(
            onPressed: () => _bottomSheet(context),
            child: const Text('Abrir BottomSheet'),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          Get.offAllNamed('/home');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _opening() {
    int rnd = _generateRND();
    String title = "Error!";
    String img = "assets/icons/advertencia.png";

    // mult15 - 35%
    if (rnd <= 3500) {
      title = "Multiplicar els punst per 1.5";
      img = "assets/icons/mult15.png";
    }
    // menos25 - 25%
    else if (rnd > 3500 && rnd <= 6000) {
      title = "Descartar una de les respostes incorrectes";
      img = "assets/icons/menos25.png";
    }
    // mult20 - 20%
    else if (rnd > 6000 && rnd <= 8000) {
      title = "Multiplicar els punst per 2";
      img = "assets/icons/mult20.png";
    }
    // menos50 - 15%
    else if (rnd > 8000 && rnd <= 9500) {
      title = "Descartar dues de les respostes incorrectes";
      img = "assets/icons/menos50.png";
    }
    // resoldre - 5%
    else if (rnd > 9500) {
      title = "Resoldre la pregunta directament";
      img = "assets/icons/resolver.png";
    } else {
      title;
      img;
    }

    Get.defaultDialog(
      title: title,
      content: Image.asset(img),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Recollir!"),
        ),
      ],
    );
  }
  
  _bottomSheet(BuildContext context) {
    Get.bottomSheet(
      Column(
        children: [
          // title
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          const Text(
            'Aventatges',
            style: TextStyle(fontSize: 30),
          ),

          // mult15
          ImageCounter(
            imagePath: 'assets/icons/mult15.png',
            name: 'Multiplicar per 1.5',
            counter: 10,
            size: 50,
          ),

           // mult20
          ImageCounter(
            imagePath: 'assets/icons/mult20.png',
            name: 'Multiplicar per 2',
            counter: 10,
            size: 50,
          ),

          // menos25
          ImageCounter(
            imagePath: 'assets/icons/menos25.png',
            name: 'Descartar 1',
            counter: 10,
            size: 50,
          ),
          
          // menos50
          ImageCounter(
            imagePath: 'assets/icons/menos50.png',
            name: 'Descartar 2',
            counter: 10,
            size: 50,
          ),
          
          // resoldre
          ImageCounter(
            imagePath: 'assets/icons/resolver.png',
            name: 'Resoldre',
            counter: 10,
            size: 50,
          ),
        ],
      ),
      
      backgroundColor: MyColors.blueCharcoal,
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}

int _generateRND() {
  final rnd = Random();
  final number = rnd.nextInt(10000);
  return number;
}
