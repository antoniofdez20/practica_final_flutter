import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';
import 'package:practica_final_flutter/widgets/widgets.dart';

/// pantalla de la botiga on es poden comprar avantatges a canvi de crèdits aconseguits en el joc o tutorial
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final userController = Get.find<FirebaseUsersController>();

    return Scaffold(
      appBar: const TopAppBar(title: 'Quizzosco'),
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
                      _buyPack(userController);
                      // _opening(userController);
                    });
              },
            ),
          ),

          // Aventatges
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 100, right: 100),
            child: ElevatedButton(
              onPressed: () =>
                  _bottomSheet(context, themeController, userController),
              child: const Text('Avantatges'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }

  _buyPack(FirebaseUsersController userController) {
    const int packagePrice = 250;

    if (userController.tempUser.value.credits < packagePrice) {
      Get.defaultDialog(
        title: "No tens crèdits suficients",
        content: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Cada sobre te un cost de 250 crèdits"),
            SizedBox(height: 20),
            Image(
              image: AssetImage('assets/icons/sin_dinero.png'),
            ),
          ],
        
        ),
        backgroundColor: Colors.red,
        titleStyle: const TextStyle(
            color: MyColors.midnight, fontWeight: FontWeight.w500),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
            },
            style: TextButton.styleFrom(
                backgroundColor: MyColors.midnight,
                foregroundColor: Colors.white),
            child: const Text("OK!"),
          ),
        ],
      );
    } else {
      userController.tempUser.value.credits -= packagePrice;
      _opening(userController);
    }
  }

  _opening(FirebaseUsersController userController) {
    int rnd = _generateRND();
    String title = "Error!";
    String img = "assets/icons/advertencia.png";

    // mult15 - 35%
    if (rnd <= 3500) {
      title = "Multiplicar els punst per 1.5";
      img = "assets/icons/mult15.png";
      userController.tempUser.value.avantatges.mult15++;
    }
    // menos25 - 25%
    else if (rnd > 3500 && rnd <= 6000) {
      title = "Descartar una de les respostes incorrectes";
      img = "assets/icons/menos25.png";
      userController.tempUser.value.avantatges.menys25++;
    }
    // mult20 - 20%
    else if (rnd > 6000 && rnd <= 8000) {
      title = "Multiplicar els punst per 2";
      img = "assets/icons/mult20.png";
      userController.tempUser.value.avantatges.mult20++;
    }
    // menos50 - 15%
    else if (rnd > 8000 && rnd <= 9500) {
      title = "Descartar dues de les respostes incorrectes";
      img = "assets/icons/menos50.png";
      userController.tempUser.value.avantatges.menys50++;
    }
    // resoldre - 5%
    else if (rnd > 9500) {
      title = "Resoldre la pregunta directament";
      img = "assets/icons/resolver.png";
      userController.tempUser.value.avantatges.resoldre++;
    } else {
      title;
      img;
    }

    Get.defaultDialog(
      title: title,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("-250 crèdits"),
          const SizedBox(height: 20),
          Image.asset(img),
        ],
      ),
      backgroundColor: MyColors.amber,
      titleStyle: const TextStyle(color: MyColors.midnight, fontWeight: FontWeight.w500),
      actions: [
        TextButton(
          onPressed: () async {
            await userController.updateUser();
            await userController.saveCredencials(
                userController.tempUser.value.username,
                userController.tempUser.value.contrasenya);
            Get.back();
          },
          style: TextButton.styleFrom(
              backgroundColor: MyColors.midnight,
              foregroundColor: MyColors.amber),
          child: const Text("Recollir!"),
        ),
      ],
    );
  }

  _bottomSheet(BuildContext context, ThemeController themeController,
      FirebaseUsersController userController) {
    Get.bottomSheet(
      Obx(
        () => Column(
          children: [
            // title
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            const Text(
              'Avantatges',
              style: TextStyle(fontSize: 30),
            ),

            // mult15
            ImageCounter(
              imagePath: 'assets/icons/mult15.png',
              name: 'Multiplicar per 1.5',
              counter: userController.tempUser.value.avantatges.mult15,
              size: 50,
            ),

            // mult20
            ImageCounter(
              imagePath: 'assets/icons/mult20.png',
              name: 'Multiplicar per 2',
              counter: userController.tempUser.value.avantatges.mult20,
              size: 50,
            ),

            // menos25
            ImageCounter(
              imagePath: 'assets/icons/menos25.png',
              name: 'Descartar 1',
              counter: userController.tempUser.value.avantatges.menys25,
              size: 50,
            ),

            // menos50
            ImageCounter(
              imagePath: 'assets/icons/menos50.png',
              name: 'Descartar 2',
              counter: userController.tempUser.value.avantatges.menys50,
              size: 50,
            ),

            // resoldre
            ImageCounter(
              imagePath: 'assets/icons/resolver.png',
              name: 'Resoldre',
              counter: userController.tempUser.value.avantatges.resoldre,
              size: 50,
            ),
          ],
        ),
      ),
      backgroundColor: themeController.isDarkMode.value
          ? MyColors.blueCharcoal
          : MyColors.easternBlue,
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
