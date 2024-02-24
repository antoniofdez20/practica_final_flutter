import 'package:practica_final_flutter/models/avantatges.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUserLogin {
  static late SharedPreferences _prefs; //objeto de tipo SharedPreferences

  static String _tempUserID = '';
  static String _tempUsername = '';
  static String _tempEmail = '';
  static String _tempPassword = '';
  static int _tempCredits = 0;
  static int _tempXP = 0;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Avantatges get tempAvantatges {
    String avantatgesStr = _prefs.getString('tempAvantatges') ??
        '{"menys25":0,"menys50":0,"mult15":0,"mult20":0,"resoldre":0}';
    return Avantatges.fromJson(avantatgesStr);
  }

  static set tempAvantatges(Avantatges value) {
    String avantatgesStr = value.toJson();
    _prefs.setString('tempAvantatges', avantatgesStr);
  }

  static String get tempUserID {
    return _prefs.getString('tempUserID') ?? _tempUserID;
  }

  static set tempUserID(String value) {
    _tempUserID = value;
    _prefs.setString('tempUserID', value);
  }

  static String get tempUsername {
    return _prefs.getString('tempUsername') ?? _tempUsername;
  }

  static set tempUsername(String value) {
    _tempUsername = value;
    _prefs.setString('tempUsername', value);
  }

  static String get tempEmail {
    return _prefs.getString('tempEmail') ?? _tempEmail;
  }

  static set tempEmail(String value) {
    _tempEmail = value;
    _prefs.setString('tempEmail', value);
  }

  static String get tempPassword {
    return _prefs.getString('tempPassword') ?? _tempPassword;
  }

  static set tempPassword(String value) {
    _tempPassword = value;
    _prefs.setString('tempPassword', value);
  }

  static int get tempCredits {
    return _prefs.getInt('tempCredits') ?? _tempCredits;
  }

  static set tempCredits(int value) {
    _tempCredits = value;
    _prefs.setInt('tempCredits', value);
  }

  static int get tempXP {
    return _prefs.getInt('tempXP') ?? _tempXP;
  }

  static set tempXP(int value) {
    _tempXP = value;
    _prefs.setInt('tempXP', value);
  }
}
