import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        // definicion del estilo del AppBar
        appBarTheme: const AppBarTheme(
          color: MyColors.easternBlue, // Color del AppBar
          titleTextStyle: TextStyle(
            fontSize: 28,
            color: MyColors.greenVogue, // Color del texto del AppBar
          ),
          actionsIconTheme: IconThemeData(color: MyColors.greenVogue),
        ),

        // definicion del estilo de la pantalla
        scaffoldBackgroundColor: MyColors.cornflower,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 18,
            color: MyColors.greenVogue, // Color del texto
          ), // Color de fondo de pantalla
        ),

        //definicion del estilo de los floating action buttons
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: MyColors.greenVogue,
          foregroundColor: MyColors.cornflower,
        ),

        // definicion del estilo de los campos de texto
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: MyColors.selectiveYellow),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.easternBlue,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.selectiveYellow,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          filled: true,
          fillColor: MyColors.easternBlue,
        ),

        // definicion del estilo de los botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            backgroundColor: MyColors.selectiveYellow,
            foregroundColor: MyColors.greenVogue,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          color: MyColors.midnight, // Color del AppBar
          titleTextStyle: TextStyle(
            fontSize: 28,
            color: MyColors.amber, // Color del texto del AppBar
          ),
          actionsIconTheme: IconThemeData(color: MyColors.amber),
        ),
        
        scaffoldBackgroundColor: MyColors.midnightBlue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 18,
            color: MyColors.amber, // Color del texto
          ), // Color de fondo de pantalla
        ),
        
        //definicion del estilo de los floating action buttons
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: MyColors.amber,
          foregroundColor: MyColors.midnight,
        ),

        // definicion del estilo de los campos de texto
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: MyColors.gold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.gold,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          filled: true,
          fillColor: MyColors.midnight,
        ),
     
        // definicion del estilo de los botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            backgroundColor: MyColors.gold,
            foregroundColor: MyColors.midnightBlue,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );
  }
}

class MyColors {
  // Dark Theme
  static const blueCharcoal = Color(0x0000032e);
  static const midnight = Color(0xFF001D3D);
  static const midnightBlue = Color(0xFF003566);
  static const amber = Color(0xFFFFC300);
  static const gold = Color(0xFFFFD60a);

  // Light Theme
  static const cornflower = Color(0xFF8ECAE6);
  static const easternBlue = Color(0xFF219EBC);
  static const greenVogue = Color(0xFF023047);
  static const selectiveYellow = Color(0xFFFFB703);
  static const flushOrange = Color(0xFFFB8500);

}