import 'package:shared_preferences/shared_preferences.dart';

/// Classe que gestiona les preferències del tema de la aplicació i les persisteix en el dispositiu.
class PreferencesTheme {
  static late SharedPreferences _prefs;

  static bool _isDarkMode = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }
}
