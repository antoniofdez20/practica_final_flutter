import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUserLogin {
  static late SharedPreferences _prefs; //objeto de tipo SharedPreferences

  static String _tempUserID = '';
  static String _tempUsername = '';
  static String _tempEmail = '';
  static String _tempPassword = '';
  static int _tempCredits = 0;
  static int _tempXP = 0;
  //he tenido que persistir los datos asi porque al intentar persistir el objeto avantatges directamente me daba error
  static int _tempMenys50 = 0;
  static int _tempMenys25 = 0;
  static int _tempMult15 = 0;
  static int _tempMult20 = 0;
  static int _tempResoldre = 0;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int get tempMenys50 {
    return _prefs.getInt('tempMenys50') ?? _tempMenys50;
  }

  static set tempMenys50(int value) {
    _tempMenys50 = value;
    _prefs.setInt('tempMenys50', value);
  }

  static int get tempMenys25 {
    return _prefs.getInt('tempMenys25') ?? _tempMenys25;
  }

  static set tempMenys25(int value) {
    _tempMenys25 = value;
    _prefs.setInt('tempMenys25', value);
  }

  static int get tempMult15 {
    return _prefs.getInt('tempMult15') ?? _tempMult15;
  }

  static set tempMult15(int value) {
    _tempMult15 = value;
    _prefs.setInt('tempMult15', value);
  }

  static int get tempMult20 {
    return _prefs.getInt('tempMult20') ?? _tempMult20;
  }

  static set tempMult20(int value) {
    _tempMult20 = value;
    _prefs.setInt('tempMult20', value);
  }

  static int get tempResoldre {
    return _prefs.getInt('tempResoldre') ?? _tempResoldre;
  }

  static set tempResoldre(int value) {
    _tempResoldre = value;
    _prefs.setInt('tempResoldre', value);
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
