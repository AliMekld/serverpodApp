import 'package:flutter/material.dart';
import 'theme_model.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';

class ColorsPalette {
  static ThemeData get dark => ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        extensions: <ThemeExtension<ThemeModel>>[darkTheme],
        scaffoldBackgroundColor: darkTheme.backgroundColor,
        tooltipTheme: const TooltipThemeData(
          waitDuration: Duration(days: 1),
        ),
      );

  static ThemeData get light => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        extensions: <ThemeExtension<ThemeModel>>[lightTheme],
        scaffoldBackgroundColor: lightTheme.backgroundColor,
        tooltipTheme: const TooltipThemeData(
          waitDuration: Duration(days: 1),
        ),
      );

  static ThemeModel of(BuildContext context) =>
      context.watch<ThemeProvider>().appTheme;

  ///==============================>>[dark_palette]<<=================================///
  static ThemeModel get darkTheme => ThemeModel(
        isDark: true,
        primaryColor: const Color(0xff0760FB),
        secondaryColor: const Color(0xff6C8BC2),
        backgroundColor: const Color(0xff303D4D),
        surfaceColor: const Color(0xff363535),
        primaryTextColor: const Color(0xffF3F7FF),
        secondaryTextColor: const Color(0xffA0A0A0),
        errorColor: const Color(0xffD81515),
        buttonColor: const Color(0xff0760FB),
        buttonDisabledColor: const Color(0xff3E3E3E),
        dividerColor: const Color(0xff2B2B2B),
        iconColor: const Color(0xffA0A0A0),
        successColor: const Color(0xff27A745),
        waitingColor: const Color(0xffFCED25),
      );

  ///==============================>>[light_palette]<<=================================///
  static ThemeModel get lightTheme => ThemeModel(
        isDark: false,
        primaryColor: const Color(0xff0760FB),
        secondaryColor: const Color(0xff6C8BC2),
        backgroundColor: const Color(0xffF4F6F8),
        surfaceColor: const Color(0xffFFFFFF),
        primaryTextColor: const Color(0xff000000),
        secondaryTextColor: const Color(0xff757575),
        errorColor: const Color(0xffD81515),
        buttonColor: const Color(0xff0760FB),
        buttonDisabledColor: const Color(0xffBDBDBD),
        dividerColor: const Color(0xffDCDDDF),
        iconColor: const Color(0xff757575),
        successColor: const Color(0xff27A745),
        waitingColor: const Color(0xffFCED25),
      );
}
