import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //el gesturedetector nos va a permitir que si el usuario toca en cualquier parte de la pantalla que no sean los campos de texto el teclado se escondera
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Text('Benvingut',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  TextFormField(
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
                  TextFormField(
                    style: const TextStyle(color: Color(0xFFFFC300)),
                    cursorColor: const Color(0xFFFFC300),
                    obscureText: true, //oculta la contraseña
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
                        icon: const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
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
                      Get.offNamed('/home');
                    },
                    child: const Text('Iniciar Sessió'),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                        text: 'No tens compte? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Crea compte aquí',
                        style: const TextStyle(
                          color: Color(0xFFFFC300),
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
    );
  }
}
