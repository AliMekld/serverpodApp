import '../../core/Language/app_localization.dart';
import '../../core/theme/color_pallet.dart';
import '../../core/theme/typography.dart';
import '../../utilities/constants/Strings.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/extensions.dart';
import 'dialog_widget.dart';
import '../cutom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../utilities/constants/assets.dart';

mixin DialogsMixin {
  Dialog errorDialog(
      {Priority? priority,
      required BuildContext context,
      required String message}) {
    return Dialog(
      elevation: 16,
      shadowColor: ColorsPalette.of(context).buttonDisabledColor,
      shape: RoundedRectangleBorder(
        borderRadius: Constants.kBorderRaduis16,
      ),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 600.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80.r,
              color: ColorsPalette.of(context).errorColor,
            ).fit,
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 16.w,
                  height: 360.h,
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  color:
                      ColorsPalette.of(context).secondaryColor .withValues(alpha:0.8),
                ),
                Container(
                    height: 360.h,
                    width: 320,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color:
                          ColorsPalette.of(context).errorColor .withValues(alpha:0.1),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SelectableText(
                        message,
                        style: TextStyleHelper.of(context)
                            .titleMedium16M
                            .copyWith(height: 1.25),
                        maxLines: 16,
                        textAlign: TextAlign.center,
                        enableInteractiveSelection: true,
                      ),
                    )),
              ],
            ).expand,
            24.h.heightBox,
            CustomButtonWidget.backButton(context),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog successDialog(
      {required BuildContext context,
      required String message,
      Function()? onSuccess}) {
    return Dialog(
      elevation: 16,
      shadowColor: ColorsPalette.of(context).buttonDisabledColor,
      shape: RoundedRectangleBorder(borderRadius: Constants.kBorderRaduis16),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 400.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.imagesAppLogo,
              width: 112.w,
              height: 112.h,
              colorFilter: ColorFilter.mode(
                  ColorsPalette.of(context).successColor, BlendMode.srcIn),
            ),
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 16,
                  color:
                      ColorsPalette.of(context).secondaryColor .withValues(alpha:0.8),
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color:
                        ColorsPalette.of(context).successColor .withValues(alpha:0.1),
                  ),
                  child: Text(
                    message,
                    style: TextStyleHelper.of(context).titleMedium16M,
                  ),
                ).heightBox(120.h).expand,
              ],
            ).heightBox(120.h),
            24.h.heightBox,
            CustomButtonWidget.primary(
              context: context,
              buttonTitle: Strings.save.tr,
              onTap: () {
                if (onSuccess != null) onSuccess();
                context.pop();
              },
            ),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog editDialog(
      {required BuildContext context,
      required String message,
      required Function() onConfirm}) {
    return Dialog(
      elevation: 28,
      shadowColor: ColorsPalette.of(context).secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: Constants.kBorderRaduis16,
      ),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 400.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ///todo add this asset
              Assets.imagesAppLogo,
              width: 112.w,
              height: 112.h,
              colorFilter: ColorFilter.mode(
                  ColorsPalette.of(context).secondaryColor, BlendMode.srcIn),
            ),
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 16,
                  color: ColorsPalette.of(context).secondaryColor,
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color:
                        ColorsPalette.of(context).waitingColor .withValues(alpha:0.1),
                  ),
                  child: Text(
                    message,
                    style: TextStyleHelper.of(context).titleMedium16M,
                  ),
                ).heightBox(120.h).expand,
              ],
            ).heightBox(120.h),
            24.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget.backButton(context, width: 112.w),
                CustomButtonWidget.primary(
                  width: 120.w,
                  context: context,
                  buttonTitle: Strings.confirm.tr,
                  onTap: onConfirm,
                ),
              ],
            ).widthBox(1.sw),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog deleteDialog({
    required BuildContext context,
    required String message,
    required Function() onDelete,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: Constants.kBorderRaduis16),
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: SizedBox(
        height: 400.h,
        width: 400.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dangerous_outlined,
              size: 44,
              color: ColorsPalette.of(context).errorColor,
            ),
            24.h.heightBox,
            Row(
              children: [
                Container(
                  width: 8,
                  color: ColorsPalette.of(context).errorColor .withValues(alpha:0.8),
                ),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color:
                        ColorsPalette.of(context).errorColor .withValues(alpha:0.1),
                  ),
                  child: Text(
                    message,
                    style: TextStyleHelper.of(context)
                        .titleMedium16M
                        .copyWith(height: 1.5),
                    maxLines: 6,
                    locale: AppLocalizations.of(context)?.locale,
                    textAlign: TextAlign.center,
                  ),
                ).heightBox(120.h).expand,
              ],
            ).heightBox(120.h),
            24.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonWidget.backButton(context, width: 112.w),
                CustomButtonWidget.primary(
                  context: context,
                  width: 120.w,
                  color: ColorsPalette.of(context).errorColor,
                  buttonTitle: Strings.delete.tr,
                  onTap: onDelete,
                ),
              ],
            ).widthBox(1.sw),
          ],
        ).addPaddingAll(padding: 16.r),
      ),
    );
  }

  Dialog dialogFrame(
      {required BuildContext context,
      required String message,
      Widget? child,
      double? height,
      width}) {
    return Dialog(
      elevation: 6,
      surfaceTintColor:
          ColorsPalette.of(context).backgroundColor .withValues(alpha:0.1),
      shadowColor: ColorsPalette.of(context).surfaceColor,
      shape: RoundedRectangleBorder(borderRadius: Constants.kBorderRaduis16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: ColorsPalette.of(context).backgroundColor,
      child: child?.addPaddingAll(padding: 24.r),
    );
  }
}
