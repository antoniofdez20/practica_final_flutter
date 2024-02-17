import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';
import 'package:practica_final_flutter/utils/custom_input_decoration.dart';
import 'package:practica_final_flutter/utils/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    final tempUser = controller.tempUser;
    //el gesturedetector nos va a permitir que si el usuario toca en cualquier parte de la pantalla que no sean los campos de texto el teclado se escondera
    return Obx(
      () => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Quizz Land'),
          ),
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
                                val!.email = value;
                              }),
                              validator: (value) =>
                                  Validators.emailLoginValidator(
                                      value, controller.users),
                              style:
                                  const TextStyle(color: MyColors.greenVogue),
                              cursorColor: MyColors.greenVogue,
                              decoration:
                                  CustomInputDecorations.buildInputDecoration(
                                      labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => TextFormField(
                                onChanged: (value) => tempUser.update((val) {
                                  val!.contrasenya = value;
                                }),
                                validator: (value) =>
                                    Validators.passwordLoginValidator(value),
                                style:
                                    const TextStyle(color: MyColors.greenVogue),
                                cursorColor: MyColors.greenVogue,
                                obscureText:
                                    !controller.isPasswordVisible.value,
                                decoration:
                                    CustomInputDecorations.buildInputDecoration(
                                  labelText: 'Contrasenya',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: MyColors.greenVogue,
                                    ),
                                    onPressed: () =>
                                        controller.togglePasswordVisibility(),
                                  ),
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
                                          controller.tempUser.value.email,
                                          controller.tempUser.value.contrasenya,
                                          controller.users);
                                  if (canLogin) {
                                    Get.offNamed('/home');
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "No s'ha pogut iniciar sessió, revisa les dades introduïdes",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 4),
                                      backgroundColor: MyColors.greenVogue,
                                      colorText: MyColors.selectiveYellow,
                                      icon: const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                      shouldIconPulse: true,
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "No s'ha pogut iniciar sessió, revisa les dades introduïdes",
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 4),
                                    backgroundColor: MyColors.greenVogue,
                                    colorText: MyColors.selectiveYellow,
                                    icon: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    shouldIconPulse: true,
                                  );
                                }
                              },
                              child: const Text('Iniciar Sessió'),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 12, 0, 12),
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                  text: 'No tens compte? ',
                                  style: TextStyle(color: MyColors.greenVogue),
                                ),
                                TextSpan(
                                  text: 'Crea compte aquí',
                                  style: const TextStyle(
                                    color: MyColors.blueCharcoal,
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
