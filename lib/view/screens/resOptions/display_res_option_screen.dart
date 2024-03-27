import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/resOptions/diplay_res_option_controller.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/view/widgets/common/number_display.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_toggle_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_text_display_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/display_available_time_in_days.dart';

class DisplayResOptionScreen extends StatelessWidget {
  const DisplayResOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayResOptionController());
    return Scaffold(
      appBar: appBarWithButtonCreate(
          onTapCreate: () {
            controller.onTapEdit();
          },
          title: controller.resOption.resoptionsTitle ?? '',
          buttonText: 'تعديل'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CustomSmallBoldTitle(title: 'عنوان التفضيل'),
            const SizedBox(height: 10),
            CustomTextDisplayGeneral(
              text: controller.resOption.resoptionsTitle ?? '',
            ),
            NumberDisplayWithTitleAndText(
              text: controller.resOption.resoptionsCountLimit.toString(),
              title: controller.isService
                  ? resCountTitleIsService
                  : resCountTitleIsProduct,
              endText: controller.isService
                  ? resCountTitleIsServiceEnd
                  : resCountTitleIsProductEnd,
              comment: controller.isService
                  ? resCountTitleCommentIsService
                  : resCountTitleCommentProduct,
              example: controller.isService
                  ? resCountTitleExampleIsService
                  : resCountTitleExampleProduct,
            ),
            controller.isService
                ? const SizedBox()
                : NumberDisplayWithTitleAndText(
                    text: controller.resOption.resoptionsDuration.toString(),
                    title: "مدة الحجز",
                    endText: 'دقيقة',
                    example:
                        'مثال:اذا حجز احمد يمكنه البقاء حتى 120 دقيقة ثم عليه المغادرة للشخص الذي حجز بعده',
                  ),
            DisplayAvailableTimeInWeek(
              onTapAllwaysAvailale: () {
                //controller.display(context);
                //controller.switchIsAlwaysAvailable();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayAvailableTimeInWeek extends StatelessWidget {
  final Function() onTapAllwaysAvailale;
  const DisplayAvailableTimeInWeek({
    super.key,
    required this.onTapAllwaysAvailale,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayResOptionController());
    bool isAlwaysAvailable =
        controller.resOption.resoptionsAlwaysAvailable == 1 ? true : false;
    return Column(
      children: [
        CustomToggleGeneral(
            initialValue: isAlwaysAvailable,
            onTap: () {},
            isClickable: false,
            title: 'متاح دائما'),
        isAlwaysAvailable
            ? const SizedBox()
            : Column(
                children: [
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(title: 'اوقات المتاحة'),
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
                ],
              ),
        const SizedBox(height: 80)
      ],
    );
  }
}
