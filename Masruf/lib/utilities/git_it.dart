import 'package:get_it/get_it.dart';
import '../models/app_setting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GitIt {
  static final GetIt instance = GetIt.instance..allowReassignment = true;
  static AppSettings appSettingsGit = instance.get<AppSettings>();

  static Future initGitIt() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  }
}
