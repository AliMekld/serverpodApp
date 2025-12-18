import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'shared_pref.dart';

extension WidgetExtensions on Widget {
  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(
        child: this,
      );
  SliverFillRemaining get toExpandedSliver => SliverFillRemaining(
        child: this,
      );
  SizedBox widthBox(double width) => SizedBox(width: width, child: this);
  SizedBox heightBox(double height) => SizedBox(height: height, child: this);

  Center get center => Center(child: this);
  Widget centerWhen(bool cond) => cond ? Center(child: this) : this;
  Expanded get expand => Expanded(child: this);
  Expanded expandFlex({required int flex}) => Expanded(flex: flex, child: this);
  FittedBox get fit => FittedBox(child: this);
  Padding addPaddingVertical({required double padding}) => Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: padding), child: this);
  ScrollConfiguration get withVerticalScroll => ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: true,
          scrollbars: false,
          physics: const BouncingScrollPhysics(),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: this,
        ),
      );
  Widget withVerticalScrollWhen(bool cond) => cond
      ? ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            overscroll: true,
            scrollbars: false,
            physics: const BouncingScrollPhysics(),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: this,
          ),
        )
      : this;

  Padding addPaddingAll({required double padding}) =>
      Padding(padding: EdgeInsetsDirectional.all(padding), child: this);
  Padding addPaddingHorizontal({required double padding}) => Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: padding),
        child: this,
      );
}

extension DoubleExtension on double {
  Widget get widthBox => SizedBox(width: this);
  Widget get heightBox => SizedBox(height: this);
}

extension ContextExtensions on BuildContext {
  bool get _isExpanded => SharedPref.getIsSideBarExpanded();
  double get appWidth =>
      MediaQuery.of(this).size.width.w + (_isExpanded ? 180.w : 80.w);
double get width=> MediaQuery.of(this).size.width;
  bool get isMobile => appWidth < 420.w;
  bool get isTablet => appWidth >= 420.w && appWidth <= 1024.w;
  bool get isTabletOrMobile => appWidth < 1024.w;

  bool get isDeskTop => (!isTablet && !isMobile);
}

/// Extension on String to parse into DateTime
extension DateStringParsing on String {
  /// Converts a `dd/MM/yyyy` string into a `DateTime`
  /// Returns `null` if parsing fails.
  DateTime? toDateTime() {
    try {
      return DateFormat('dd/MM/yyyy').tryParse(this);
    } catch (e) {
      return null; // Return null if parsing fails
    }
  }
}

/// Extension on DateTime to format for display
extension DateTimeFormatting on DateTime {
  /// Formats `DateTime` into `dd/MM/yyyy` string
  String toDisplayFormat() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
