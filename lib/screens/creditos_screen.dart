import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Espacio para la foto
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/img/redonda.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Título
            Text(
              'La Mesa Pentagonal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Nombres
            _buildCreditRow('Alex Alameda Petersen '),
            _buildCreditRow('Adrián Aguiló Ruiz'),
            _buildCreditRow('Antonio Fernandez Muñoz'),
            _buildCreditRow('Marc Sans Vera'),
            _buildCreditRow('Andreu Pons Bestard'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offNamed('/home'); // Redirige a la ruta /home
              },
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir una fila de créditos
  Widget _buildCreditRow(String nombre) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        nombre,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
