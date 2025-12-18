import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Language/language_provider.dart';
import 'color_pallet.dart';
import '../../utilities/constants/constants.dart';
import 'package:provider/provider.dart';

class TextStyleHelper {
  final BuildContext context;
  const TextStyleHelper._(this.context);
  static TextStyleHelper of(BuildContext context) => TextStyleHelper._(context);

  /// Method to return a TextStyle based on font size and font weight

  TextStyle getTextStyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: Constants.notoSansKoufyFontFamily,
      fontSize: fontSize.sp,
      fontStyle: FontStyle.normal,
      locale: Provider.of<LanguageProvider>(context, listen: false).appLanguage,
      fontWeight: fontWeight,
      color: ColorsPalette.of(context).primaryTextColor,
      overflow: TextOverflow.ellipsis,
      height: 1.15.h,
    );
  }

  /// Display
  TextStyle get displayLarge57R => getTextStyle(57, FontWeight.w400);
  TextStyle get displayMedium45R => getTextStyle(45, FontWeight.w400);
  TextStyle get displaySmall36R => getTextStyle(36, FontWeight.w400);

  /// Headline
  TextStyle get headlinelarge32R => getTextStyle(32, FontWeight.w400);
  TextStyle get headlineMedium28R => getTextStyle(28, FontWeight.w400);
  TextStyle get headlineSmall24R => getTextStyle(24, FontWeight.w400);

  /// Title
  TextStyle get titleLarge22R => getTextStyle(22, FontWeight.w400);
  TextStyle get titleMedium16M => getTextStyle(16, FontWeight.w500);
  TextStyle get titleSmall14M => getTextStyle(14, FontWeight.w500);

  /// Label
  TextStyle get lableLarge14M => getTextStyle(14, FontWeight.w500);
  TextStyle get lableMedium12M => getTextStyle(12, FontWeight.w500);
  TextStyle get lableSmall11M => getTextStyle(11, FontWeight.w500);

  /// Body
  TextStyle get bodyLarge16R => getTextStyle(16, FontWeight.w400);
  TextStyle get bodyMedium14R => getTextStyle(14, FontWeight.w400);
  TextStyle get bodySmall12R => getTextStyle(12, FontWeight.w400);
}
