import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/add_worktime_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class AddWorktimeScreen extends StatelessWidget {
  const AddWorktimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddWorktimeController());
    return GetBuilder<AddWorktimeController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'اوقات العمل'),
              floatingActionButton: CustomButtonOne(
                  textButton: 'حفظ',
                  onPressed: () {
                    controller.addWorktime(context);
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
                      onTapCheckbox: () {
                        controller.switchDayOff(1);
                      },
                    ),
                    CustomButton(
                        onTap: () => controller.applyToAll(),
                        text: 'تطبيق على الكل'),
                    const SizedBox(height: 20),
                    DayWorkTimePicker(
                      day: 'الاحد',
                      onTapFromP1: () {
                        controller.showCustomTimePicker(context, 5);
                      },
                      onTapToP1: () {
                        controller.showCustomTimePicker(context, 6);
                      },
                      timeFromP1:
                          controller.displayTime(controller.sunFromP1, context),
                      timeToP1:
                          controller.displayTime(controller.sunToP1, context),
                      onTapFromP2: () {
                        controller.showCustomTimePicker(context, 7);
                      },
                      onTapToP2: () {
                        controller.showCustomTimePicker(context, 8);
                      },
                      timeFromP2:
                          controller.displayTime(controller.sunFromP2, context),
                      timeToP2:
                          controller.displayTime(controller.sunToP2, context),
                      onTapCheckbox: () => controller.switchDayOff(2),
                    ),
                    DayWorkTimePicker(
                      day: 'الاثنين',
                      onTapFromP1: () {
                        controller.showCustomTimePicker(context, 9);
                      },
                      onTapToP1: () {
                        controller.showCustomTimePicker(context, 10);
                      },
                      timeFromP1:
                          controller.displayTime(controller.monFromP1, context),
                      timeToP1:
                          controller.displayTime(controller.monToP1, context),
                      onTapFromP2: () {
                        controller.showCustomTimePicker(context, 11);
                      },
                      onTapToP2: () {
                        controller.showCustomTimePicker(context, 12);
                      },
                      timeFromP2:
                          controller.displayTime(controller.monFromP2, context),
                      timeToP2:
                          controller.displayTime(controller.monToP2, context),
                      onTapCheckbox: () => controller.switchDayOff(3),
                    ),
                    DayWorkTimePicker(
                      day: 'الثلثاء',
                      onTapFromP1: () {
                        controller.showCustomTimePicker(context, 13);
                      },
                      onTapToP1: () {
                        controller.showCustomTimePicker(context, 14);
                      },
                      timeFromP1: controller.displayTime(
                          controller.tuesFromP1, context),
                      timeToP1:
                          controller.displayTime(controller.tuesToP1, context),
                      onTapFromP2: () {
                        controller.showCustomTimePicker(context, 15);
                      },
                      onTapToP2: () {
                        controller.showCustomTimePicker(context, 16);
                      },
                      timeFromP2: controller.displayTime(
                          controller.tuesFromP2, context),
                      timeToP2:
                          controller.displayTime(controller.tuesToP2, context),
                      onTapCheckbox: () => controller.switchDayOff(4),
                    ),
                    DayWorkTimePicker(
                      day: 'الاربعاء',
                      onTapFromP1: () {
                        controller.showCustomTimePicker(context, 17);
                      },
                      onTapToP1: () {
                        controller.showCustomTimePicker(context, 18);
                      },
                      timeFromP1:
                          controller.displayTime(controller.wedFromP1, context),
                      timeToP1:
                          controller.displayTime(controller.wedToP1, context),
                      onTapFromP2: () {
                        controller.showCustomTimePicker(context, 19);
                      },
                      onTapToP2: () {
                        controller.showCustomTimePicker(context, 20);
                      },
                      timeFromP2:
                          controller.displayTime(controller.wedFromP2, context),
                      timeToP2:
                          controller.displayTime(controller.wedToP2, context),
                      onTapCheckbox: () => controller.switchDayOff(5),
                    ),
                    DayWorkTimePicker(
                      day: 'الخميس',
                      onTapFromP1: () {
                        controller.showCustomTimePicker(context, 21);
                      },
                      onTapToP1: () {
                        controller.showCustomTimePicker(context, 22);
                      },
                      timeFromP1: controller.displayTime(
                          controller.thursFromP1, context),
                      timeToP1:
                          controller.displayTime(controller.thursToP1, context),
                      onTapFromP2: () {
                        controller.showCustomTimePicker(context, 23);
                      },
                      onTapToP2: () {
                        controller.showCustomTimePicker(context, 24);
                      },
                      timeFromP2: controller.displayTime(
                          controller.thursFromP2, context),
                      timeToP2:
                          controller.displayTime(controller.thursToP2, context),
                      onTapCheckbox: () => controller.switchDayOff(6),
                    ),
                    DayWorkTimePicker(
                      day: 'الجمعة',
                      onTapFromP1: () {
                        controller.showCustomTimePicker(context, 25);
                      },
                      onTapToP1: () {
                        controller.showCustomTimePicker(context, 26);
                      },
                      timeFromP1:
                          controller.displayTime(controller.friFromP1, context),
                      timeToP1:
                          controller.displayTime(controller.friToP1, context),
                      onTapFromP2: () {
                        controller.showCustomTimePicker(context, 27);
                      },
                      onTapToP2: () {
                        controller.showCustomTimePicker(context, 28);
                      },
                      timeFromP2:
                          controller.displayTime(controller.friFromP2, context),
                      timeToP2:
                          controller.displayTime(controller.friToP2, context),
                      onTapCheckbox: () => controller.switchDayOff(7),
                    ),
                    const SizedBox(height: 80)
                  ]),
                ),
              ),
            ));
  }
}

class CustomCheckbox extends StatefulWidget {
  final Function() onTap;
  const CustomCheckbox({super.key, required this.onTap});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                isDone = !isDone;
                widget.onTap();
              });
            },
            child: Container(
              width: 80.w,
              height: 35.h,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(8.5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone ? Colors.green : null,
                        border: isDone
                            ? null
                            : Border.all(
                                width: 0.7, color: Colors.grey.shade400)),
                    child: Icon(
                      Icons.done,
                      color: isDone ? Colors.white : Colors.transparent,
                      size: 12,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'أجازة',
                    maxLines: 1,
                    style: TextStyle(fontSize: 10.sp),
                  )),
                  SizedBox(width: 5)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
