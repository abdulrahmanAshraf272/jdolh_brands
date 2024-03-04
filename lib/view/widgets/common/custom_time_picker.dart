import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';

class CustomTimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;
  final Function() onTapSave;
  final Function() onTapReset;
  final Function()? onDismiss;

  CustomTimePicker(
      {required this.initialTime,
      required this.onTimeSelected,
      this.onDismiss,
      required this.onTapSave,
      required this.onTapReset});

  @override
  Widget build(BuildContext context) {
    int adjustedMinute = (initialTime.minute ~/ 30) * 30;
    final initialAdjustedTime =
        TimeOfDay(hour: initialTime.hour, minute: adjustedMinute);

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          'أختر الوقت',
          style: titleMedium,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: Get.height * 0.2,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              initialAdjustedTime.hour,
              initialAdjustedTime.minute,
            ),
            minuteInterval: 30,
            onDateTimeChanged: (DateTime dateTime) {
              final selectedTime = TimeOfDay(
                hour: dateTime.hour,
                minute: dateTime.minute,
              );
              onTimeSelected(selectedTime);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: onTapSave,
              text: '  حفظ  ',
              size: 1.2,
            ),
            SizedBox(width: 15),
            TextButton(onPressed: onTapReset, child: Text('الغاء تعيين'))
          ],
        ),
      ],
    );
  }
}
