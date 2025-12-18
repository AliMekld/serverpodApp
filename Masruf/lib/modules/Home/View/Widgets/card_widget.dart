import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color_pallet.dart';
import '../../../../utilities/constants/constants.dart';

class CardWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Widget child;
  const CardWidget({
    super.key,
    this.height,
    this.width,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 600.h,
      width: width ?? 400.w,
      decoration: BoxDecoration(
        borderRadius: Constants.kBorderRaduis16,
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
              color: ColorsPalette.of(context).dividerColor)
        ],
        color: color ?? ColorsPalette.of(context).surfaceColor,
      ),
      child: child,
    );
  }
}
