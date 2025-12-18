import 'package:hive_flutter/hive_flutter.dart';

import '../../utilities/constants/constants.dart';


class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter().then((_) async {
      await Future.wait([
        Hive.openBox(Constants.dashboardKey),
        Hive.openBox(Constants.expensesKey),
        Hive.openBox(Constants.categoriesKey),
        Hive.openBox(Constants.incomeKey),
        Hive.openBox(Constants.profileKey),
        Hive.openBox(Constants.settingsKey),
      ]);
    });
  }

}
