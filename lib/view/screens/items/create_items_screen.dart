import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/create_item_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/Small_toggle_buttons.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_multi_select.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_dropdown.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_holder.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';
import 'package:jdolh_brands/view/widgets/items/available_item_time.dart';
import 'package:jdolh_brands/view/widgets/number_textfield.dart';

class CreateItemsScreen extends StatelessWidget {
  const CreateItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    successDialog(void Function() onTap) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'تمت الاضافة',
          desc: '',
          onDismissCallback: (type) {
            onTap();
          }).show();
    }

    Get.put(CreateItemsController());
    return GetBuilder<CreateItemsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'انشاء ${controller.itemText}'),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomSmallBoldTitle(title: 'صورة ${controller.itemText}'),
                    const SizedBox(height: 10),
                    RectImageHolder(
                      onTap: () => controller.uploadImage(),
                      selectedImage: controller.selectedImage,
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
                      title: 'اختر الصنف',
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
                              initActiveState: true,
                            ))),
                    const SizedBox(height: 20),
                    NumberTextFieldWithTitleAndText(
                        textEditingController: controller.price,
                        title: 'السعر',
                        endText: 'ريال',
                        comment: 'تم اضافة الاسعار  ✅',
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
                            }),
                      ),
                    ),
                    controller.isService
                        ? NumberTextFieldWithTitleAndText(
                            textEditingController: controller.duration,
                            title: "مدة الحجز",
                            comment:
                                'يجب ان تكون مدة الحجز من مضاعفات ال30 دقيقة',
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
                    AvailableItemTime(
                      onTapAllwaysAvailale: () {
                        //controller.display(context);
                        controller.switchIsAlwaysAvailable();
                      },
                    ),
                    GoHomeButton(
                      onTap: () async {
                        final result = await controller.createItem(context);
                        if (result != null) {
                          successDialog(() {
                            Get.back(result: result);
                          });
                        }
                      },
                      text: 'حفظ',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
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
