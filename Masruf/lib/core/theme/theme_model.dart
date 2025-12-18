// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'color_pallet.dart';

class ThemeModel extends ThemeExtension<ThemeModel> {
  /// get default theme from device
  static ThemeModel get defaultTheme =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? ColorsPalette.darkTheme
          : ColorsPalette.lightTheme;

  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color errorColor;
  final Color successColor;
  final Color waitingColor;
  final Color buttonColor;
  final Color buttonDisabledColor;
  final Color dividerColor;
  final Color iconColor;

  ThemeModel({
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.buttonColor,
    required this.buttonDisabledColor,
    required this.dividerColor,
    required this.errorColor,
    required this.iconColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.successColor,
    required this.surfaceColor,
    required this.waitingColor,
  });
  @override
  ThemeExtension<ThemeModel> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? errorColor,
    Color? buttonColor,
    Color? buttonDisabledColor,
    Color? dividerColor,
    Color? iconColor,
    Color? successColor,
    Color? waitingColor,
  }) {
    return ThemeModel(
      isDark: isDark,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      errorColor: errorColor ?? this.errorColor,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonDisabledColor: buttonDisabledColor ?? this.buttonDisabledColor,
      dividerColor: dividerColor ?? this.dividerColor,
      iconColor: iconColor ?? this.iconColor,
      successColor: successColor ?? this.successColor,
      waitingColor: waitingColor ?? this.waitingColor,
    );
  }

  @override
  ThemeModel lerp(covariant ThemeModel? other, double t) {
    return (this != other) ? other ?? this : this;
  }

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        isDark: json['isDark'],
        backgroundColor: Color(json['backgroundColor']),
        primaryColor: Color(json['primaryColor']),
        secondaryColor: Color(json['secondaryColor']),
        buttonColor: Color(json['buttonColor']),
        buttonDisabledColor: Color(json['buttonDisabledColor']),
        dividerColor: Color(json['dividerColor']),
        errorColor: Color(json['errorColor']),
        iconColor: Color(json['iconColor']),
        primaryTextColor: Color(json['primaryTextColor']),
        secondaryTextColor: Color(json['secondaryTextColor']),
        successColor: Color(json['successColor']),
        surfaceColor: Color(json['surfaceColor']),
        waitingColor: Color(json['waitingColor']),
      );
  Map<String, dynamic> toJson() => {
        'isDark': isDark,
        'backgroundColor': backgroundColor.value,
        'primaryColor': primaryColor.value,
        'secondaryColor': secondaryColor.value,
        'buttonColor': buttonColor.value,
        'buttonDisabledColor': buttonDisabledColor.value,
        'dividerColor': dividerColor.value,
        'errorColor': errorColor.value,
        'iconColor': iconColor.value,
        'primaryTextColor': primaryTextColor.value,
        'secondaryTextColor': secondaryTextColor.value,
        'successColor': successColor.value,
        'surfaceColor': surfaceColor.value,
        'waitingColor': waitingColor.value,
      };
}
