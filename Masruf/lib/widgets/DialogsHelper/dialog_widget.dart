import 'package:flutter/material.dart';
import 'dialog_helper_mixin.dart';

enum DialogType {
  error,
  success,
  delete,
  editCreate,
  custom,
}

///TODO
enum Priority {
  danger,
  average,
  normal,
}

class DialogHelper with DialogsMixin {
  final DialogType type;
  final String message;
  final Function()? onConfirm;
  final Widget? child;
  final double? height, width;

  /// Creating Named Constructor For Each Type
  const DialogHelper.error({required this.message, this.width, this.height})
      : type = DialogType.error,
        child = null,
        onConfirm = null;

  const DialogHelper.success({
    this.width,
    this.height,
    required this.message,
    this.onConfirm,
  })  : type = DialogType.success,
        child = null;

  const DialogHelper.delete({
    this.width,
    this.height,
    required this.message,
    required this.onConfirm,
  })  : type = DialogType.delete,
        child = null;

  const DialogHelper.create({
    this.width,
    this.height,
    required this.message,
    required this.onConfirm,
  })  : child = null,
        type = DialogType.editCreate;

  const DialogHelper.customDialog({
    this.width,
    this.height,
    this.onConfirm,
    required this.child,
  })  : type = DialogType.custom,
        message = '';

  Dialog _getDialogByType(BuildContext context) {
    switch (type) {
      case DialogType.error:
        return errorDialog(context: context, message: message);
      case DialogType.success:
        return successDialog(
            context: context, message: message, onSuccess: onConfirm);
      case DialogType.delete:
        return deleteDialog(
            context: context, message: message, onDelete: onConfirm!);
      case DialogType.editCreate:
        return editDialog(
            context: context, message: message, onConfirm: onConfirm!);
      case DialogType.custom:
        return dialogFrame(
  
          context: context,
          message: '',
          child: child,
          width: width,
          height: height,
        );
    }
  }

  showDialog(BuildContext context) {
    return showAdaptiveDialog(
        useRootNavigator: false,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        barrierLabel: 'dd',
        useSafeArea: true,
        context: context,
        builder: (context) {
          return _getDialogByType(context);
        });
  }
}
