import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import '../core/theme/color_pallet.dart';
import '../core/theme/typography.dart';
import '../utilities/constants/constants.dart';

enum DecorationType { focused, error, enabled, disabled, validated }

class CustomDropdownWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? selectedItem;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final bool? enabled, autoFocus;
  final String? hint, label;
  final FocusNode? focusNode;
  final Function()? onSuffixTap;
  final Widget? suffix;
  final double? height, width;
  final Color? bgColor;
  const CustomDropdownWidget(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.selectedItem,
      this.focusNode,
      this.enabled,
      this.hint,
      this.label,
      this.onSuffixTap,
      this.suffix,
      this.autoFocus,
      this.validator,
      this.height,
      this.width,
      this.bgColor});

  OutlineInputBorder getInputDecoration(
      {required DecorationType type, required BuildContext context}) {
    switch (type) {
      case DecorationType.focused:
        return OutlineInputBorder(
          borderRadius: Constants.kBorderRaduis16,
          borderSide: BorderSide(
            color: ColorsPalette.of(context).secondaryTextColor,
            width: 1.35,
          ),
        );
      case DecorationType.error:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).errorColor,
            ));
      case DecorationType.enabled:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).secondaryTextColor,
            ));
      case DecorationType.disabled:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).buttonDisabledColor,
            ));
      case DecorationType.validated:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).successColor,
            ));
    }
  }

  InputDecoration getDecoration(BuildContext context) => InputDecoration(
      contentPadding: EdgeInsets.all(Constants.kpaddding16),
      fillColor: bgColor ?? ColorsPalette.of(context).backgroundColor,
      filled: true,
      enabledBorder:
          getInputDecoration(type: DecorationType.enabled, context: context),
      errorBorder:
          getInputDecoration(type: DecorationType.error, context: context),
      border:
          getInputDecoration(type: DecorationType.enabled, context: context),
      disabledBorder:
          getInputDecoration(type: DecorationType.disabled, context: context),
      focusedBorder:
          getInputDecoration(type: DecorationType.focused, context: context),
      labelStyle: TextStyleHelper.of(context).titleLarge22R,
      enabled: enabled ?? true,
      hintText: hint ?? '',
      labelText: label ?? '',
      hintStyle: TextStyleHelper.of(context).titleSmall14M);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 58.h,
      width: width ?? 320.w,
      child: DropdownButtonFormField(
        iconEnabledColor: ColorsPalette.of(context).secondaryTextColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        borderRadius: Constants.kBorderRaduis16,
        decoration: getDecoration(context),
        style: TextStyleHelper.of(context).titleSmall14M,
        dropdownColor: ColorsPalette.of(context).backgroundColor,
        validator: validator,
        hint: Text(
          hint ?? '',
          style: TextStyleHelper.of(context).titleSmall14M,
        ),
        autofocus: autoFocus ?? false,
        focusNode: focusNode,
        items: items,
        onChanged: onChanged,
        value: selectedItem,
        alignment: AlignmentDirectional.center,
      ),
    );
  }
}
