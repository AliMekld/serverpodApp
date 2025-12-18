import 'dart:convert';
import 'git_it.dart';
import '../core/theme/theme_model.dart';

// ignore: unused_import
import '../core/Language/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /// Make this prefs as Locator
  static SharedPreferences get prefs => GitIt.instance.get<SharedPreferences>();

  ///=======================>  K E Y S  <=================================//
  static const String _languageCode = 'language_code';
  static const String _appTheme = 'appTheme';
  static const String _isDark = 'isDark';
  static const String _isFirstTimeOpenApp = 'isFirstTimeOpenApp';
  static const String _isLogin = 'isLogin';
  static const String _isSideBarExpanded = 'isSideBarExpanded';

  ///=====================> M E T H O D S <=================================//
  ///SET LANGUAGE
  static Future<void> setLanguage({required int lanId}) async =>
      await prefs.setInt(_languageCode, lanId);

  ///GET LANGUAGE
  static Languages? getLanguage() =>
      Languages.getFromId(prefs.getInt(_languageCode) ?? 1);

  ///SET THEME
  static void setTheme({required ThemeModel theme}) => prefs.setString(_appTheme, jsonEncode(theme.toJson()));
  static void setIsDark({required bool isDark}) => prefs.setBool(_isDark, isDark);
  static  bool get getIsDark => prefs.getBool(_isDark)??false;

  ///GET THEME
  static ThemeModel? getTheme() {
    String? encodedString = prefs.getString(_appTheme);
    if (encodedString != null && (encodedString.isNotEmpty)) {
      Map<String, dynamic> json = jsonDecode(prefs.getString(_appTheme) ?? '');
      return ThemeModel.fromJson(json);
    } else {
      return null;
    }
  }

  /// SET IS FIRST TIME OPEN APP
  static Future<void> setIsFistTimeOpenApp({required bool value}) async {
    await prefs.setBool(_isFirstTimeOpenApp, value);
  }

  /// GET IS FIRST TIME OPEN APP
  static Future<bool?> getIsFistTimeOpenApp() async {
    return prefs.getBool(_isFirstTimeOpenApp) ?? true;
  }

  /// SET IS FIRST TIME OPEN APP
  static void setIsSideBarExpanded({required bool value}) {
    prefs.setBool(_isSideBarExpanded, value);
  }

  /// GET IS FIRST TIME OPEN APP
  static bool getIsSideBarExpanded() {
    return prefs.getBool(_isSideBarExpanded) ?? false;
  }

  /// SET IS LOGIN
  static Future<void> setIsLogin({required bool value}) async {
    await prefs.setBool(_isLogin, value);
  }

  /// SET IS LOGIN
  static Future<void> removeLoginData() async {
    await prefs.remove(_isLogin);
  }

  /// GET IS LOGIN
  static Future<bool?> getIsLogin() async {
    return prefs.getBool(_isLogin) ?? false;
  }

  void clearData() {
    prefs.clear();
  }
}
