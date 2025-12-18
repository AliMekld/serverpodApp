import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/theme/color_pallet.dart';
import '../core/theme/typography.dart';
import '../utilities/constants/constants.dart';
import '../utilities/extensions.dart';

enum _DecorationType { focused, error, enabled, disabled, validated }

class CustomDateTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool? enabled;
  final String label;
  final double? width, height;

  const CustomDateTextField({
    super.key,
    required this.controller,
    required this.label,
    this.height,
    this.width,
    this.enabled = true,
  });

  @override
  State<CustomDateTextField> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomDateTextField> {
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              labelLarge: TextStyleHelper.of(context).lableMedium12M,
              bodyLarge: TextStyleHelper.of(context).bodyLarge16R,
            ),
            primaryTextTheme: TextTheme(
                bodyLarge: TextStyleHelper.of(context).bodyLarge16R,
                bodyMedium: TextStyleHelper.of(context).bodyMedium14R,
                bodySmall: TextStyleHelper.of(context).bodySmall12R),
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorsPalette.of(context).primaryColor,
              brightness: ColorsPalette.of(context).isDark
                  ? Brightness.dark
                  : Brightness.light,
              primary: ColorsPalette.of(context)
                  .primaryColor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.teal, // Button text color
                  elevation: 20),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Update the text field with the formatted date
      setState(() {
        widget.controller.text = pickedDate.toDisplayFormat();
      });
    }
  }

  OutlineInputBorder getInputDecoration({required _DecorationType type}) {
    switch (type) {
      case _DecorationType.focused:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
                color: ColorsPalette.of(context).primaryTextColor, width: 1.5));
      case _DecorationType.error:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).errorColor,
            ));
      case _DecorationType.enabled:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).primaryTextColor,
            ));
      case _DecorationType.disabled:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).buttonDisabledColor,
            ));
      case _DecorationType.validated:
        return OutlineInputBorder(
            borderRadius: Constants.kBorderRaduis16,
            borderSide: BorderSide(
              color: ColorsPalette.of(context).successColor,
            ));
    }
  }

  InputDecoration get getDecoration => InputDecoration(
        errorStyle: const TextStyle(fontSize: 0, height: 0),
        labelStyle: TextStyleHelper.of(context).titleMedium16M,
        enabled: widget.enabled ?? true,
        labelText: widget.label,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
              onTap: _pickDate,
              child: Icon(
                Icons.calendar_today,
                color: ColorsPalette.of(context).secondaryTextColor,
              )),
        ),
        prefixIconConstraints: const BoxConstraints(
            maxHeight: 32, maxWidth: 32, minHeight: 32, minWidth: 32),
        suffixIconConstraints: const BoxConstraints(
            maxHeight: 32, maxWidth: 48, minHeight: 32, minWidth: 32),
        border: getInputDecoration(type: _DecorationType.enabled),
        enabledBorder: getInputDecoration(type: _DecorationType.enabled),
        errorBorder: getInputDecoration(
          type: _DecorationType.error,
        ),
        focusedBorder: getInputDecoration(type: _DecorationType.focused),
        disabledBorder: getInputDecoration(type: _DecorationType.disabled),
      );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 58.h,
      width: widget.width ?? 320.w,
      child: TextFormField(
        style: TextStyleHelper.of(context).bodyLarge16R,
        controller: widget.controller,
        inputFormatters: [DateInputFormatter()],
        decoration: getDecoration,
      ),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove non-digit or non-slash characters
    final sanitizedText = newValue.text.replaceAll(RegExp(r'[^\d/]'), '');

    // Restrict length to 10 characters (dd/MM/yyyy)
    if (sanitizedText.length > 10) {
      return oldValue;
    }

    final buffer = StringBuffer();
    final text = sanitizedText.replaceAll('/', '');

    // Automatically insert '/' after day and month
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();

    // Validate the complete date only if it's fully entered
    if (formatted.length == 10 && !_isValidDate(formatted)) {
      return oldValue; // Reject invalid dates
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Validate a date string in dd/MM/yyyy format
  bool _isValidDate(String input) {
    try {
      final parts = input.split('/');

      if (parts.length != 3) return false;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      if (month > 12) return false;
      if (int.parse(parts[1]) > 12) return false;

      final date = DateTime(year, month, day);

      // Ensure day and month match input (e.g., no 30th February)
      return date.day == day && date.month == month && date.year == year;
    } catch (e) {
      return false;
    }
  }
}
