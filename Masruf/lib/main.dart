import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/HiveLocalStorage/hive_helper.dart';
import 'core/Language/language_provider.dart';
import 'core/LocalDataBase/database_helper.dart';
import 'core/ServerPod/base_client.dart';
import 'core/network_checker.dart';
import 'core/theme/color_pallet.dart';
import 'core/theme/theme_provider.dart';
import 'utilities/git_it.dart';
import 'utilities/router_config.dart';
import 'widgets/app_settings_loader.dart';
import 'core/Language/app_localization.dart';
import 'utilities/PDFHelper/pdf_widgets.dart';

const Size mobileSize = Size(375, 812);
const Size tabletSize = Size(768, 1024);
const Size desktopSize = Size(1440, 900);
const Size fullHdDesktopSize = Size(1920, 1024);

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsLoader.load();
  await ServerPodClient.init();

  await HiveHelper.init();

  /// [initialize_firebase]
  // try {
  //   if (!isWindowsApp()) {
  //     await Firebase.initializeApp(
  //         options: DefaultFirebaseOptions.currentPlatform);
  //   }
  //   log("success in Firebase Initialization:");
  // } on FirebaseException catch (e) {
  //   log("Error in Firebase Initialization: $e");
  // }

  /// [initialize_git_it]
  await GitIt.initGitIt();

  /// [initialize_pdf]
  await PDFConfig.loadFont();

  if (!kIsWeb) {
    /// [initialize_database_helper]
    await DatabaseHelper().initDataBase();
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeProvider()),
        BlocProvider(create: (context) => LanguageProvider()),
        BlocProvider(create: (context) => NetworkCheckerNotifier()),
      ],
      child: const EntryPoint(),
    ),
  );
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      /// [RESPONSIVE_DESIGN_CONFIGURATION]
      Size? appSize;
      if (constraints.maxWidth >= 1024) {
        if (constraints.maxWidth > 1440) {
          appSize = fullHdDesktopSize;
        } else {
          appSize = desktopSize;
        }
      } else if (constraints.maxWidth >= 600) {
        appSize = tabletSize;
      } else {
        appSize = mobileSize;
      }
      return ScreenUtilInit(
        designSize: appSize,
        child: MaterialApp.router(
          /// [initialize_router]
          routerConfig: router,

          ///[PASSING_THEME]
          theme: ColorsPalette.light,
          darkTheme: ColorsPalette.dark,
          themeAnimationDuration: const Duration(microseconds: 300),
          themeMode: context.watch<ThemeProvider>().themeMode,
          ///[OTHER_CONFIGURATION]
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),

          ///[MULTI_LANGUAGE_CONFIGURATION]
          supportedLocales: Languages.values.map((e) => Locale(e.name)),
          locale: context.watch<LanguageProvider>().appLanguage,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
    });
  }
}

/// Enable scrolling with mouse dragging
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
