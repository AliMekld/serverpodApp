// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/Language/app_localization.dart';
import '../core/theme/color_pallet.dart';
import '../core/theme/typography.dart';
import '../utilities/extensions.dart';

/// single radio value
class CustomRadioWidget<T> extends StatefulWidget {
  final bool isButton;
  final T value;
  final T? groupValue;
  final void Function(T?)? onChanged;
  final String? title;
  const CustomRadioWidget(
      {super.key,
      required this.value,
      required this.groupValue,
      this.onChanged,
      this.title,
      this.isButton = false});

  @override
  State<CustomRadioWidget> createState() => _CustomRadioWidgetState();
}

class _CustomRadioWidgetState<T> extends State<CustomRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: isArabic(context) ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Text(
          // ignore: prefer_single_quotes
          widget.title ?? "",
          style: TextStyleHelper.of(context).bodyMedium14R,
        ),
        16.w.widthBox,
        Transform.scale(
          scale: 1.15,
          child: Radio<T>(
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    ).widthBox(0.3.sw);
  }
}

///============================[multi_radio_Widget]===============================//
enum RadioListType { row, colun, wrap }

class CustomListRadioWidget<T> extends StatefulWidget {
  final bool isButton;
  final RadioListType _listType;
  final List<T> itemsList;
  final T? groupValue;
  final void Function(T?)? onChanged;

  const CustomListRadioWidget.column({
    super.key,
    required this.itemsList,
    required this.groupValue,
    required this.onChanged,
    this.isButton = false,
  }) : _listType = RadioListType.colun;
  const CustomListRadioWidget.row({
    super.key,
    required this.itemsList,
    required this.groupValue,
    required this.onChanged,
    this.isButton = false,
  }) : _listType = RadioListType.row;
  const CustomListRadioWidget.wrap({
    super.key,
    required this.itemsList,
    required this.groupValue,
    required this.onChanged,
    this.isButton = false,
  }) : _listType = RadioListType.wrap;

  @override
  State<CustomListRadioWidget<T>> createState() =>
      _CustomListRadioWidgetState<T>();
}

class _CustomListRadioWidgetState<T> extends State<CustomListRadioWidget<T>> {
  void _onChanged(T? value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  get mapItemsList => widget.itemsList
      .map(
        (T e) => widget.isButton
            ? MaterialButton(
                shape: const BeveledRectangleBorder(),
                color: e == widget.groupValue
                    ? ColorsPalette.of(context).secondaryColor
                    : ColorsPalette.of(context).surfaceColor .withValues(alpha:0.5),
                onPressed: () {
                  setState(() {
                    _onChanged(e);
                  });
                },
                elevation: e == widget.groupValue ? 6 : 0.1,
                child: CustomRadioWidget<T>(
                  isButton: widget.isButton,
                  title: (e as Enum).name,
                  value: e,
                  groupValue: widget.groupValue,
                  onChanged: _onChanged,
                ).addPaddingAll(padding: 8.r),
              )
            : CustomRadioWidget<T>(
                title: (e as Enum).name,
                value: e,
                groupValue: widget.groupValue,
                onChanged: _onChanged,
              ).addPaddingAll(padding: 8.r),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    switch (widget._listType) {
      case RadioListType.wrap:
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: mapItemsList,
        );
      case RadioListType.colun:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mapItemsList,
        );
      case RadioListType.row:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: mapItemsList,
        );
    }
  }
}
