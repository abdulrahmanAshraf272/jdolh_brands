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
