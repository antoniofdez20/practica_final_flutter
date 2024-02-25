import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/utils/utils.dart';
import 'package:practica_final_flutter/widgets/top_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    final themeController = Get.find<ThemeController>();
    final tempUser = controller.tempUser;
    //el gesturedetector nos va a permitir que si el usuario toca en cualquier parte de la pantalla que no sean los campos de texto el teclado se escondera
    return Obx(
      () => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: const TopAppBar(title: 'Quizz Land'),
          //SafeArea nos permite que el contenido de la pantalla no se superponga con el notch de las diferentes pantallas, los diferentes bordes que puedan tener, etc
          body: controller.users.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Form(
                        key: controller.formLoginKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 35),
                              child: Text('Benvingut',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                            ),
                            TextFormField(
                              onChanged: (value) => tempUser.update((val) {
                                val!.username = value;
                              }),
                              validator: (value) =>
                                  Validators.usernameLoginValidator(
                                      value, controller.users),
                              style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? MyColors.amber
                                    : MyColors.greenVogue,
                              ),
                              cursorColor: themeController.isDarkMode.value
                                  ? MyColors.amber
                                  : MyColors.greenVogue,
                              decoration:
                                  CustomInputDecorations.buildInputDecoration(
                                      labelText: 'Username',
                                      themeController: themeController),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              onChanged: (value) => tempUser.update((val) {
                                val!.contrasenya = value;
                              }),
                              validator: (value) =>
                                  Validators.passwordLoginValidator(value),
                              style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? MyColors.amber
                                    : MyColors.greenVogue,
                              ),
                              cursorColor: themeController.isDarkMode.value
                                  ? MyColors.amber
                                  : MyColors.greenVogue,
                              obscureText: !controller.isPasswordVisible.value,
                              decoration:
                                  CustomInputDecorations.buildInputDecoration(
                                labelText: 'Contrasenya',
                                themeController: themeController,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off_outlined,
                                    color: themeController.isDarkMode.value
                                        ? MyColors.amber
                                        : MyColors.greenVogue,
                                  ),
                                  onPressed: () =>
                                      controller.togglePasswordVisibility(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                if (controller.formLoginKey.currentState!
                                    .validate()) {
                                  bool canLogin =
                                      Validators.validateLoginCredentials(
                                          tempUser.value.username,
                                          tempUser.value.contrasenya,
                                          controller.users);
                                  if (canLogin) {
                                    await controller.saveCredencials(
                                        tempUser.value.username,
                                        tempUser.value.contrasenya);
                                    await controller.loadUserByID();
                                    Get.offNamed('/home');
                                  } else {
                                    Validators.showLoginErrorSnackbar();
                                  }
                                } else {
                                  Validators.showLoginErrorSnackbar();
                                }
                              },
                              child: const Text('Iniciar Sessió'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 12, 0, 12),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'No tens compte? ',
                                  style: TextStyle(
                                    color: themeController.isDarkMode.value
                                        ? Colors.white
                                        : MyColors.greenVogue,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Crea compte aquí',
                                  style: TextStyle(
                                    color: themeController.isDarkMode.value
                                        ? MyColors.amber
                                        : MyColors.blueCharcoal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offNamed('/create_account');
                                    },
                                ),
                              ])),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
