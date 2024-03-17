import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

displayDoneDialog(BuildContext context, void Function() onTapDismiss) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.rightSlide,
    title: 'تم حفظ البيانات',
    desc: '',
    onDismissCallback: (dismissType) {
      onTapDismiss();
    },
  ).show();
}

unableToDeleteDialog(BuildContext context, String desc) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    title: 'غير مسموح',
    desc: desc,
    btnOkText: 'حسناً',
  ).show();
}
