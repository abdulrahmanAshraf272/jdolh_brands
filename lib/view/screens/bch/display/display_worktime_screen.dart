import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/display/display_worktime_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/display_available_time_in_days.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';

class DisplayWorktimeScreen extends StatelessWidget {
  const DisplayWorktimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayWorktimeController());
    return GetBuilder<DisplayWorktimeController>(
        builder: (controller) => Scaffold(
            appBar: appBarWithButtonCreate(
                onTapCreate: () => controller.onTapEdit(),
                title: 'أوقات العمل',
                buttonText: 'تعديل'),
            body: HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 10),
                  DayWorkTimeDisplayer(
                    day: 'السبت',
                    timeFromP1:
                        controller.displayTime(controller.satFromP1, context),
                    timeToP1:
                        controller.displayTime(controller.satToP1, context),
                    timeFromP2:
                        controller.displayTime(controller.satFromP2, context),
                    timeToP2:
                        controller.displayTime(controller.satToP2, context),
                    checkboxInit: controller.isSatOff,
                  ),
                  const SizedBox(height: 20),
                  DayWorkTimeDisplayer(
                    day: 'الاحد',
                    timeFromP1:
                        controller.displayTime(controller.sunFromP1, context),
                    timeToP1:
                        controller.displayTime(controller.sunToP1, context),
                    timeFromP2:
                        controller.displayTime(controller.sunFromP2, context),
                    timeToP2:
                        controller.displayTime(controller.sunToP2, context),
                    checkboxInit: controller.isSunOff,
                  ),
                  DayWorkTimeDisplayer(
                    day: 'الاثنين',
                    timeFromP1:
                        controller.displayTime(controller.monFromP1, context),
                    timeToP1:
                        controller.displayTime(controller.monToP1, context),
                    timeFromP2:
                        controller.displayTime(controller.monFromP2, context),
                    timeToP2:
                        controller.displayTime(controller.monToP2, context),
                    checkboxInit: controller.isMonOff,
                  ),
                  DayWorkTimeDisplayer(
                    day: 'الثلاثاء',
                    timeFromP1:
                        controller.displayTime(controller.tuesFromP1, context),
                    timeToP1:
                        controller.displayTime(controller.tuesToP1, context),
                    timeFromP2:
                        controller.displayTime(controller.tuesFromP2, context),
                    timeToP2:
                        controller.displayTime(controller.tuesToP2, context),
                    checkboxInit: controller.isTuesOff,
                  ),
                  DayWorkTimeDisplayer(
                    day: 'الاربعاء',
                    timeFromP1:
                        controller.displayTime(controller.wedFromP1, context),
                    timeToP1:
                        controller.displayTime(controller.wedToP1, context),
                    timeFromP2:
                        controller.displayTime(controller.wedFromP2, context),
                    timeToP2:
                        controller.displayTime(controller.wedToP2, context),
                    checkboxInit: controller.isWedOff,
                  ),
                  DayWorkTimeDisplayer(
                    day: 'الخميس',
                    timeFromP1:
                        controller.displayTime(controller.thursFromP1, context),
                    timeToP1:
                        controller.displayTime(controller.thursToP1, context),
                    timeFromP2:
                        controller.displayTime(controller.thursFromP2, context),
                    timeToP2:
                        controller.displayTime(controller.thursToP2, context),
                    checkboxInit: controller.isThursOff,
                  ),
                  DayWorkTimeDisplayer(
                    day: 'الجمعة',
                    timeFromP1:
                        controller.displayTime(controller.friFromP1, context),
                    timeToP1:
                        controller.displayTime(controller.friToP1, context),
                    timeFromP2:
                        controller.displayTime(controller.friFromP2, context),
                    timeToP2:
                        controller.displayTime(controller.friToP2, context),
                    checkboxInit: controller.isFriOff,
                  ),
                  const SizedBox(height: 80)
                ]),
              ),
            )));
  }
}
