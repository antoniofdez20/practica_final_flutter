import 'package:get/get.dart';

/// controlador de la navegació de la aplicació i controlar en temps real quina
/// es la pantalla actual seleccionada en el bottom navigation bar per part de l'usuari.
class NavigationController extends GetxController {
  var selectedIndex = (-1).obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
