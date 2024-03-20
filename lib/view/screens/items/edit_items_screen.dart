import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/edit_item_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/Small_toggle_buttons.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_multi_select.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_toggle_general.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_dropdown.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_holder.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class EditItemsScreen extends StatelessWidget {
  const EditItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditItemsController());
    return GetBuilder<EditItemsController>(
        builder: (controller) => Scaffold(
            appBar: customAppBar(title: 'انشاء ${controller.itemText}'),
            body: HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomSmallBoldTitle(title: 'صورة ${controller.itemText}'),
                    const SizedBox(height: 10),
                    RectImageHolderAndDispay(
                      onTap: () => controller.uploadImage(),
                      selectedImage: controller.selectedImage,
                      imageInit: controller.imageRecieved,
                    ),
                    const SizedBox(height: 20),
                    CustomSmallBoldTitle(title: 'اسم ${controller.itemText}'),
                    const SizedBox(height: 10),
                    CustomTextFormGeneral(
                      hintText: controller.isService
                          ? 'مثال: حلاقة شعر, حلاقة دقن'
                          : 'مثال: شاورما, عصير مانجا ..',
                      textEditingController: controller.title,
                      valid: (val) => validInput(val!, 2, 50),
                    ),
                    const SizedBox(height: 20),
                    CustomSmallBoldTitle(title: 'وصف ${controller.itemText}'),
                    const SizedBox(height: 10),
                    CustomTextFormGeneral(
                      hintText: 'ادخل وصف ${controller.itemText}',
                      textEditingController: controller.desc,
                      valid: (val) => validInput(val!, 3, 100),
                      height: 100.h,
                      maxLength: 100,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'متوفر ضمن صنف'),
                    const SizedBox(height: 10),
                    CustomDropdown(
                      items: controller.categoriesTitle,
                      title: controller.initialCategory,
                      //displacement: 0,
                      //listWidth: Get.width - 40,
                      onChanged: (String? value) {
                        controller.setSelectedCategory(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'متوفر ضمن تفضيل'),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: controller.resOptions.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: ((context, index) => MultiSelectItem(
                              title:
                                  controller.resOptions[index].resoptionsTitle!,
                              onTap: () {
                                controller.addRemoveResOptions(index);
                              },
                              initActiveState:
                                  controller.checkIfResOptionSelected(index),
                            ))),
                    const SizedBox(height: 20),
                    NumberTextFieldWithTitleAndText(
                        textEditingController: controller.price,
                        title: 'السعر',
                        endText: 'ريال',
                        textButtonTitle: 'السعر حسب الإختيار؟',
                        onTapTextButton: () =>
                            controller.goToAddOptionsPriceDep()),
                    NumberTextFieldWithTitleAndText(
                      textEditingController: controller.dicount,
                      title: 'التخفيض',
                      endText: controller.discountIsPercent ? '%' : 'ريال',
                      verticalPadding: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SmallToggleButtons(
                            optionOne: 'مبلغ',
                            optionTwo: 'نسبة',
                            onTapOne: () {
                              controller.changeDiscountIsPercent(false);
                            },
                            onTapTwo: () {
                              controller.changeDiscountIsPercent(true);
                            },
                            initValue: controller.discountIsPercent ? 2 : 1),
                      ),
                    ),
                    controller.isService
                        ? NumberTextFieldWithTitleAndText(
                            textEditingController: controller.duration,
                            title: "مدة الحجز",
                            endText: 'دقيقة',
                            example: '',
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    CustomCardOne(
                      text: 'خيارات اضافية',
                      onTap: () {
                        controller.goToAddOptions();
                      },
                    ),
                    const SizedBox(height: 20),
                    AvailableTimeInWeek(
                      onTapAllwaysAvailale: () {
                        //controller.display(context);
                        controller.switchIsAlwaysAvailable();
                      },
                    ),
                    GoHomeButton(
                      onTap: () => controller.editItem(context),
                      text: 'حفظ',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )));
  }
}

class CustomCardOne extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool cancelArrowForward;
  const CustomCardOne(
      {super.key,
      required this.text,
      required this.onTap,
      this.cancelArrowForward = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 45.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: AutoSizeText(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                    ),
                  )),
                  !cancelArrowForward
                      ? Icon(
                          Icons.arrow_forward,
                          color: Colors.grey.shade500,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
  final controller = Get.put(EditItemsController());
  bool isAlwaysAvailable = true;
  @override
  void initState() {
    isAlwaysAvailable = controller.isAlwaysAvailable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditItemsController>(
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
