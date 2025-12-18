import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'color_pallet.dart';
import 'theme_model.dart';
import '../../utilities/shared_pref.dart';

class ThemeProvider extends Cubit<SystemBrightness> {
  ThemeModel get appTheme => (state== SystemBrightness.dark
      ? ColorsPalette.darkTheme
      : ColorsPalette.lightTheme);


  static final ThemeModel _appTheme = ThemeModel.defaultTheme;

  ThemeProvider()
      : super(SharedPref.getIsDark
            ? SystemBrightness.dark: SystemBrightness.light) ;

  ThemeMode get themeMode => state == SystemBrightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  void changeTheme(SystemBrightness brightness) {
    emit(brightness);
    SharedPref.setTheme(theme: _appTheme);
    SharedPref.setIsDark(isDark: brightness.val);
  }
}

enum SystemBrightness {
  light(false),
  dark(true);

  final bool val;
  const SystemBrightness(this.val);
}
