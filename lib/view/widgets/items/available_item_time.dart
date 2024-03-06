import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/create_item_controller.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_toggle_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';

class AvailableItemTime extends StatefulWidget {
  final Function() onTapAllwaysAvailale;
  const AvailableItemTime({
    super.key,
    required this.onTapAllwaysAvailale,
  });

  @override
  State<AvailableItemTime> createState() => _AvailableItemTimeState();
}

class _AvailableItemTimeState extends State<AvailableItemTime> {
  bool isAlwaysAvailable = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateItemsController>(
        builder: (controller) => Column(
              children: [
                CustomToggleGeneral(
                    onTap: () {
                      setState(() {
                        isAlwaysAvailable = !isAlwaysAvailable;
                        widget.onTapAllwaysAvailale();
                      });

                      widget.onTapAllwaysAvailale;
                    },
                    title: 'متاح دائما'),
                isAlwaysAvailable
                    ? SizedBox()
                    : Column(
                        children: [
                          const SizedBox(height: 20),
                          const CustomSmallBoldTitle(title: 'اوقات المتاحة'),
                          const SizedBox(height: 10),
                          DayWorkTimePicker(
                            day: 'السبت',
                            onTapFromP1: () {
                              controller.showCustomTimePicker(context, 1);
                            },
                            onTapToP1: () {
                              controller.showCustomTimePicker(context, 2);
                            },
                            timeFromP1: controller.displayTime(
                                controller.satFromP1, context),
                            timeToP1: controller.displayTime(
                                controller.satToP1, context),
                            onTapFromP2: () =>
                                controller.showCustomTimePicker(context, 3),
                            onTapToP2: () =>
                                controller.showCustomTimePicker(context, 4),
                            timeFromP2: controller.displayTime(
                                controller.satFromP2, context),
                            timeToP2: controller.displayTime(
                                controller.satToP2, context),
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
                            timeFromP1: controller.displayTime(
                                controller.sunFromP1, context),
                            timeToP1: controller.displayTime(
                                controller.sunToP1, context),
                            onTapFromP2: () {
                              controller.showCustomTimePicker(context, 7);
                            },
                            onTapToP2: () {
                              controller.showCustomTimePicker(context, 8);
                            },
                            timeFromP2: controller.displayTime(
                                controller.sunFromP2, context),
                            timeToP2: controller.displayTime(
                                controller.sunToP2, context),
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
                            timeFromP1: controller.displayTime(
                                controller.monFromP1, context),
                            timeToP1: controller.displayTime(
                                controller.monToP1, context),
                            onTapFromP2: () {
                              controller.showCustomTimePicker(context, 11);
                            },
                            onTapToP2: () {
                              controller.showCustomTimePicker(context, 12);
                            },
                            timeFromP2: controller.displayTime(
                                controller.monFromP2, context),
                            timeToP2: controller.displayTime(
                                controller.monToP2, context),
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
                            timeToP1: controller.displayTime(
                                controller.tuesToP1, context),
                            onTapFromP2: () {
                              controller.showCustomTimePicker(context, 15);
                            },
                            onTapToP2: () {
                              controller.showCustomTimePicker(context, 16);
                            },
                            timeFromP2: controller.displayTime(
                                controller.tuesFromP2, context),
                            timeToP2: controller.displayTime(
                                controller.tuesToP2, context),
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
                            timeFromP1: controller.displayTime(
                                controller.wedFromP1, context),
                            timeToP1: controller.displayTime(
                                controller.wedToP1, context),
                            onTapFromP2: () {
                              controller.showCustomTimePicker(context, 19);
                            },
                            onTapToP2: () {
                              controller.showCustomTimePicker(context, 20);
                            },
                            timeFromP2: controller.displayTime(
                                controller.wedFromP2, context),
                            timeToP2: controller.displayTime(
                                controller.wedToP2, context),
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
                            timeToP1: controller.displayTime(
                                controller.thursToP1, context),
                            onTapFromP2: () {
                              controller.showCustomTimePicker(context, 23);
                            },
                            onTapToP2: () {
                              controller.showCustomTimePicker(context, 24);
                            },
                            timeFromP2: controller.displayTime(
                                controller.thursFromP2, context),
                            timeToP2: controller.displayTime(
                                controller.thursToP2, context),
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
                            timeFromP1: controller.displayTime(
                                controller.friFromP1, context),
                            timeToP1: controller.displayTime(
                                controller.friToP1, context),
                            onTapFromP2: () {
                              controller.showCustomTimePicker(context, 27);
                            },
                            onTapToP2: () {
                              controller.showCustomTimePicker(context, 28);
                            },
                            timeFromP2: controller.displayTime(
                                controller.friFromP2, context),
                            timeToP2: controller.displayTime(
                                controller.friToP2, context),
                            onTapCheckbox: () => controller.switchDayOff(7),
                          ),
                        ],
                      ),
                const SizedBox(height: 80)
              ],
            ));
  }
}
