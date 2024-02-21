import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controllers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Quizz Land"),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                controller.resetCredencials();
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
        body: controller.users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(controller.tempUser.value.email),
              ),
      ),
    );
  }
}
