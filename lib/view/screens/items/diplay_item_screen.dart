import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/display_item_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/widgets/common/number_display.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_multi_select.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_toggle_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_text_display_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/display_available_time_in_days.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_display.dart';

class DisplayItemScreen extends StatelessWidget {
  const DisplayItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayItemController());
    return GetBuilder<DisplayItemController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: controller.item.itemsTitle ?? ''),
              body: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomSmallBoldTitle(
                          title: 'صورة ${controller.itemText}'),
                      const SizedBox(height: 10),
                      RectImageDisplay(
                        image: controller.item.itemsImage,
                      ),
                      const SizedBox(height: 20),
                      CustomSmallBoldTitle(title: 'اسم ${controller.itemText}'),
                      CustomTextDisplayGeneral(
                        text: controller.item.itemsTitle ?? '',
                      ),
                      const SizedBox(height: 20),
                      CustomSmallBoldTitle(title: 'وصف ${controller.itemText}'),
                      CustomTextDisplayGeneral(
                        text: controller.item.itemsDesc ?? '',
                      ),
                      const SizedBox(height: 20),
                      CustomSmallBoldTitle(
                          title: 'تصنيف ${controller.itemText}'),
                      CustomTextDisplayGeneral(
                        text: controller.categories.title ?? '',
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(title: 'متوفر ضمن تفضيل'),
                      const SizedBox(height: 10),
                      ListView.builder(
                          itemCount: controller.resOptions.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) => MultiSelectItem(
                                title: controller
                                    .resOptions[index].resoptionsTitle!,
                                onTap: () {},
                                isClickable: false,
                                initActiveState: true,
                              ))),
                      NumberDisplayWithTitleAndText(
                        text: controller.item.itemsPrice.toString(),
                        title: 'السعر',
                        endText: 'ريال',
                      ),
                      NumberDisplayWithTitleAndText(
                        text: controller.discount,
                        title: 'التخفيض',
                        endText: controller.discountType,
                        verticalPadding: 0,
                      ),
                      controller.isService
                          ? NumberDisplayWithTitleAndText(
                              text: controller.item.itemsDuration.toString(),
                              title: "مدة الحجز",
                              endText: 'دقيقة',
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      CustomCardOne(
                        text: 'خيارات اضافية',
                        onTap: () {
                          //controller.goToAddOptions();
                        },
                      ),
                      const SizedBox(height: 20),
                      const DisplayAvailableTimeInWeek(),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class DisplayAvailableTimeInWeek extends StatelessWidget {
  const DisplayAvailableTimeInWeek({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayItemController());
    bool isAlwaysAvailable =
        controller.item.itemsAlwaysAvailable == 1 ? true : false;
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
