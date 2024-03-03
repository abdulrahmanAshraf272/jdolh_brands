import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/add_worktime_controller.dart';
import 'package:jdolh_brands/controller/bch/create_bch_controller.dart';
import 'package:jdolh_brands/controller/brand/create_brand_controller.dart';
import 'package:jdolh_brands/controller/legaldata/create_legaldata_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/skip_and_confirm_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_dropdown.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_holder.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class AddWorktimeScreen extends StatelessWidget {
  const AddWorktimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddWorktimeController());
    return GetBuilder<AddWorktimeController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(
                title: 'اوقات العمل',
              ),
              floatingActionButton: CustomButtonOne(
                  textButton: 'حفظ',
                  onPressed: () {
                    controller.addWorktime();
                  }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Form(
                key: controller.formstatepart,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 10),
                    DayWorkTimePicker(
                      day: 'السبت',
                      onTapFromP1: () {
                        controller.showCustomTimePicker(context, 1);
                      },
                      onTapToP1: () {
                        controller.showCustomTimePicker(context, 2);
                      },
                      timeFromP1:
                          controller.displayTime(controller.satFromP1, context),
                      timeToP1:
                          controller.displayTime(controller.satToP1, context),
                      onTapFromP2: () =>
                          controller.showCustomTimePicker(context, 3),
                      onTapToP2: () =>
                          controller.showCustomTimePicker(context, 4),
                      timeFromP2:
                          controller.displayTime(controller.satFromP2, context),
                      timeToP2:
                          controller.displayTime(controller.satToP2, context),
                    ),
                    DayWorkTimePicker(
                      day: 'الاحد',
                      onTapFromP1: () {
                        //controller.showCustomTimePicker(context);
                      },
                      onTapToP1: () {},
                      timeFromP1: '2:00 am',
                      timeToP1: '4:00 pm',
                      onTapFromP2: () {},
                      onTapToP2: () {},
                      timeFromP2: '2:00 am',
                      timeToP2: '4:00 pm',
                    ),
                    DayWorkTimePicker(
                      day: 'الاثنين',
                      onTapFromP1: () {},
                      onTapToP1: () {},
                      timeFromP1: '2:00 am',
                      timeToP1: '4:00 pm',
                      onTapFromP2: () {},
                      onTapToP2: () {},
                      timeFromP2: '2:00 am',
                      timeToP2: '4:00 pm',
                    ),
                    DayWorkTimePicker(
                      day: 'الثلثاء',
                      onTapFromP1: () {},
                      onTapToP1: () {},
                      timeFromP1: '2:00 am',
                      timeToP1: '4:00 pm',
                      onTapFromP2: () {},
                      onTapToP2: () {},
                      timeFromP2: '2:00 am',
                      timeToP2: '4:00 pm',
                    ),
                    DayWorkTimePicker(
                      day: 'الاربعاء',
                      onTapFromP1: () {},
                      onTapToP1: () {},
                      timeFromP1: '2:00 am',
                      timeToP1: '4:00 pm',
                      onTapFromP2: () {},
                      onTapToP2: () {},
                      timeFromP2: '2:00 am',
                      timeToP2: '4:00 pm',
                    ),
                    DayWorkTimePicker(
                      day: 'الخميس',
                      onTapFromP1: () {},
                      onTapToP1: () {},
                      timeFromP1: '2:00 am',
                      timeToP1: '4:00 pm',
                      onTapFromP2: () {},
                      onTapToP2: () {},
                      timeFromP2: '2:00 am',
                      timeToP2: '4:00 pm',
                    ),
                    DayWorkTimePicker(
                      day: 'الجمعة',
                      onTapFromP1: () {},
                      onTapToP1: () {},
                      timeFromP1: '2:00 am',
                      timeToP1: '4:00 pm',
                      onTapFromP2: () {},
                      onTapToP2: () {},
                      timeFromP2: '2:00 am',
                      timeToP2: '4:00 pm',
                    ),
                  ]),
                ),
              ),
            ));
  }
}

class CustomTimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;
  final int minuteInterval;

  CustomTimePicker({
    required this.initialTime,
    required this.onTimeSelected,
    this.minuteInterval = 30,
  });

  @override
  Widget build(BuildContext context) {
    int adjustedMinute =
        (initialTime.minute ~/ minuteInterval) * minuteInterval;
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
            minuteInterval: minuteInterval,
            onDateTimeChanged: (DateTime dateTime) {
              final selectedTime = TimeOfDay(
                hour: dateTime.hour,
                minute: dateTime.minute,
              );
              onTimeSelected(selectedTime);
            },
          ),
        ),
        // CustomButton(
        //   onTap: () {},
        //   text: ' حفظ',
        //   size: 1.2,
        // )
      ],
    );
  }
}
