import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';
import 'package:practica_final_flutter/utils/custom_colors.dart';
import 'package:practica_final_flutter/utils/custom_input_decoration.dart';
import 'package:practica_final_flutter/utils/validators.dart';
import 'package:practica_final_flutter/widgets/top_app_bar.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    final themeController = Get.find<ThemeController>();
    final tempUser = controller.tempUser;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const TopAppBar(title: 'Quizz Land'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: controller.formCreateKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 35),
                      child: Text('Crea un compte',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                    ),
                    TextFormField(
                      onChanged: (value) => tempUser.update((val) {
                        val!.username = value;
                      }),
                      validator: (value) =>
                          Validators.usernameValidator(value, controller.users),
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? MyColors.amber
                            : MyColors.greenVogue,
                      ),
                      cursorColor: themeController.isDarkMode.value
                          ? MyColors.amber
                          : MyColors.greenVogue,
                      decoration: CustomInputDecorations.buildInputDecoration(
                          labelText: 'Username',
                          themeController: themeController),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onChanged: (value) => tempUser.update((val) {
                        val!.email = value;
                      }),
                      validator: (value) =>
                          Validators.emailValidator(value, controller.users),
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? MyColors.amber
                            : MyColors.greenVogue,
                      ),
                      cursorColor: themeController.isDarkMode.value
                          ? MyColors.amber
                          : MyColors.greenVogue,
                      decoration: CustomInputDecorations.buildInputDecoration(
                          labelText: 'Email', themeController: themeController),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => TextFormField(
                        onChanged: (value) => tempUser.update((val) {
                          val!.contrasenya = value;
                        }),
                        validator: (value) =>
                            Validators.passwordValidator(value),
                        style: TextStyle(
                          color: themeController.isDarkMode.value
                              ? MyColors.amber
                              : MyColors.greenVogue,
                        ),
                        cursorColor: themeController.isDarkMode.value
                            ? MyColors.amber
                            : MyColors.greenVogue,
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: CustomInputDecorations.buildInputDecoration(
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
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => TextFormField(
                        onChanged: (value) =>
                            controller.confirmPassword.value = value,
                        validator: (value) =>
                            Validators.confirmPasswordValidator(
                                value, tempUser.value.contrasenya),
                        style: TextStyle(
                          color: themeController.isDarkMode.value
                              ? MyColors.amber
                              : MyColors.greenVogue,
                        ),
                        cursorColor: themeController.isDarkMode.value
                            ? MyColors.amber
                            : MyColors.greenVogue,
                        obscureText: !controller.isConfPswVisible.value,
                        decoration: CustomInputDecorations.buildInputDecoration(
                          labelText: 'Confirmar contrasenya',
                          themeController: themeController,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfPswVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: themeController.isDarkMode.value
                                  ? MyColors.amber
                                  : MyColors.greenVogue,
                            ),
                            onPressed: () =>
                                controller.toggleConfPswVisibility(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Lógica de inicio de sesión aquí
                        if (controller.formCreateKey.currentState!.validate()) {
                          try {
                            await controller.createUser(controller.tempUser);
                            await controller.saveCredencials(
                                tempUser.value.username,
                                tempUser.value.contrasenya);
                            await controller.loadUserByID();
                            // Si todo salió bien, muestra el Snackbar de éxito
                            Get.snackbar(
                              "Registre completat",
                              "Benvingut ${tempUser.value.username} a Quizz Land",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              backgroundColor: MyColors.greenVogue,
                              colorText: MyColors.selectiveYellow,
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              shouldIconPulse: true,
                            );
                            // Redirige al usuario al breve tutorial
                            Get.offNamed('/tutorial');
                          } catch (e) {
                            // Si la creación del usuario falla, muestra el Snackbar de error
                            Get.snackbar(
                              "Error",
                              "No s'ha pogut completar el registre: $e",
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
                            "Completa tots els camps abans de continuar",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
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
                      child: const Text('Crear compte'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Ja tens un compte? ',
                          style: TextStyle(
                            color: themeController.isDarkMode.value
                                ? Colors.white
                                : MyColors.greenVogue,
                          ),
                        ),
                        TextSpan(
                          text: 'Iniciar sessió aquí',
                          style: TextStyle(
                            color: themeController.isDarkMode.value
                                ? MyColors.amber
                                : MyColors.blueCharcoal,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offNamed('/login');
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
    );
  }
}
