import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practica_final_flutter/controllers/controllers.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FirebaseUsersController>();
    final tempUser = controller.tempUser;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Quizz Land'),
        ),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'El nom d\'usuari és obligatori';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Color(0xFFFFC300)),
                      cursorColor: const Color(0xFFFFC300),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0xFFFFC300)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF001D3D),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFC300),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        filled: true,
                        fillColor: Color(0xFF001D3D),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onChanged: (value) => tempUser.update((val) {
                        val!.email = value;
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'El correu de l\'usuari és obligatori';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Color(0xFFFFC300)),
                      cursorColor: const Color(0xFFFFC300),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0xFFFFC300)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF001D3D),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFC300),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        filled: true,
                        fillColor: Color(0xFF001D3D),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => TextFormField(
                        onChanged: (value) => tempUser.update((val) {
                          val!.contrasenya = value;
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La contrasenya és obligatoria';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Color(0xFFFFC300)),
                        cursorColor: const Color(0xFFFFC300),
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'Contrasenya',
                          labelStyle: const TextStyle(color: Color(0xFFFFC300)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF001D3D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFFC300),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF001D3D),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
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
                        onChanged: (value) => tempUser.update((val) {
                          val!.email = value;
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Confirma la contrasenya';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Color(0xFFFFC300)),
                        cursorColor: const Color(0xFFFFC300),
                        obscureText: !controller.isConfPswVisible.value,
                        decoration: InputDecoration(
                          labelText: 'Confirmar contrasenya',
                          labelStyle: const TextStyle(color: Color(0xFFFFC300)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF001D3D),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFFC300),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF001D3D),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfPswVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                controller.toggleConfPswVisibility(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(double.maxFinite),
                        backgroundColor: const Color(0xFFFFC300),
                        foregroundColor: const Color(0xFF001D3D),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        // Lógica de inicio de sesión aquí
                        if (controller.formCreateKey.currentState!.validate()) {
                          try {
                            // Reemplaza createUser() con tu método para crear el usuario en Firebase
                            await controller.createUser(controller.tempUser);
                            // Si todo salió bien, muestra el Snackbar de éxito
                            Get.snackbar(
                              "Registre completat",
                              "Benvingut ${tempUser.value.username} a Quizz Land",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              backgroundColor: const Color(0xFF001D3D),
                              colorText: const Color(0xFFFFC300),
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              shouldIconPulse: true,
                            );
                            // Redirige al usuario a la pantalla de inicio de sesión
                            Get.offNamed('/login');
                          } catch (e) {
                            // Si la creación del usuario falla, muestra el Snackbar de error
                            Get.snackbar(
                              "Error",
                              "No s'ha pogut completar el registre: $e",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 4),
                              backgroundColor: const Color(0xFF001D3D),
                              colorText: const Color(0xFFFFC300),
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
                            backgroundColor: const Color(0xFF001D3D),
                            colorText: const Color(0xFFFFC300),
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
                        const TextSpan(
                          text: 'Ja tens un compte? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Iniciar sessió aquí',
                          style: const TextStyle(
                            color: Color(0xFFFFC300),
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


/* onPressed: () async {
  if (controller.formCreateKey.currentState!.validate()) {
    // Si el formulario es válido, procede a crear el usuario
    try {
      // Reemplaza createUser() con tu método para crear el usuario en Firebase
      await controller.createUser(controller.tempUser.value.toMap());
      // Si todo salió bien, muestra el Snackbar de éxito
      Get.snackbar(
        "Registre completat",
        "Benvingut a Quizz Land",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF001D3D),
        colorText: const Color(0xFFFFC300),
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        shouldIconPulse: true,
      );
      // Redirige al usuario a la pantalla de inicio de sesión
      Get.offNamed('/login');
    } catch (e) {
      // Si la creación del usuario falla, muestra el Snackbar de error
      Get.snackbar(
        "Error",
        "No s'ha pogut completar el registre: $e",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: const Color(0xFF001D3D),
        colorText: const Color(0xFFFFC300),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        shouldIconPulse: true,
      );
    }
  } else {
    // Si el formulario no es válido, podrías mostrar un Snackbar o simplemente no hacer nada
  }
},
 */


