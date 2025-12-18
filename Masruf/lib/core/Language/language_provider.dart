import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utilities/shared_pref.dart';

///-> Languages Enum
enum Languages {
  en(1),
  ar(2);

  final int id;
  static Languages getFromId(int id) {
    return values.firstWhere((element) => element.id == id,
        orElse: () => Languages.en);
  }

  const Languages(this.id);
}


class LanguageProvider extends Cubit<Languages> {
  Locale get appLanguage => Locale(state.name);
  LanguageProvider() : super(SharedPref.getLanguage() ?? Languages.ar);
  Future changeLanguage({required Languages? language}) async {
    if (language == null) return;
    if (language == state) return;
    emit(language);
    await SharedPref.setLanguage(lanId: language.id);
  }
}
