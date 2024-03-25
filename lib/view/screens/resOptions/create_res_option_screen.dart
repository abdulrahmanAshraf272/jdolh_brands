import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/resOptions/create_resOptions_controller.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_toggle_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class CreateResOptionsScreen extends StatelessWidget {
  const CreateResOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateResOptionsController());
    return GetBuilder<CreateResOptionsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'انشاء تفضيل'),
              floatingActionButton: CustomButtonOne(
                  textButton: 'حفظ',
                  onPressed: () => controller.createResOption(context)),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'عنوان التفضيل'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textEditingController: controller.title,
                        hintText: controller.isService
                            ? resTitleExampleIsService
                            : resTitleExampleIsProduct),
                    NumberTextFieldWithTitleAndText(
                      textEditingController: controller.countLimit,
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
                        ? SizedBox()
                        : NumberTextFieldWithTitleAndText(
                            textEditingController: controller.duration,
                            title: "مدة الحجز",
                            endText: 'دقيقة',
                            comment:
                                'يجب ان تكون مدة الحجز من مضاعفات ال30 دقيقة',
                            example:
                                'مثال:اذا حجز احمد يمكنه البقاء حتى 120 دقيقة ثم عليه المغادرة للشخص الذي حجز بعده',
                          ),
                    AvailableTimeInWeek(
                      onTapAllwaysAvailale: () {
                        //controller.display(context);
                        controller.switchIsAlwaysAvailable();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
  }
}

class AvailableTimeInWeek extends StatefulWidget {
  final Function() onTapAllwaysAvailale;
  const AvailableTimeInWeek({
    super.key,
    required this.onTapAllwaysAvailale,
  });

  @override
  State<AvailableTimeInWeek> createState() => _AvailableTimeInWeekState();
}

class _AvailableTimeInWeekState extends State<AvailableTimeInWeek> {
  final controller = Get.put(CreateResOptionsController());
  bool isAlwaysAvailable = true;
  @override
  void initState() {
    isAlwaysAvailable = controller.isAlwaysAvailable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateResOptionsController>(
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
                    title: 'متاح دائما',
                    initialValue: isAlwaysAvailable),
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
                            checkboxInit: controller.isSatOff,
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
                            checkboxInit: controller.isSunOff,
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



// class CustomBottomAppBarCreateResOptions extends StatelessWidget {
//   const CustomBottomAppBarCreateResOptions({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CreateResOptionsController());
//     return BottomAppBar(
//         child: controller.currentPage >= controller.pagesNumber - 2
//             ? SizedBox()
//             : Row(
//                 //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                       onPressed: controller.onTapBack,
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.arrow_back_ios,
//                             size: 16,
//                           ),
//                           Text('السابق'),
//                         ],
//                       )),
//                   Spacer(),
//                   Container(
//                     child: GoHomeButton(
//                       width: 120.w,
//                       onTap: controller.onTapNext,
//                       withArrowForwardIcon: true,
//                       text: 'التالي',
//                     ),
//                   ),
//                 ],
//               ));
//   }
// }
