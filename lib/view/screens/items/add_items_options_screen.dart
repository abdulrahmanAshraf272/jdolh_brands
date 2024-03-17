import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/add_item_options_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/screens/categories_screen.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/Small_toggle_buttons.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_text_display_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/list_empty_text.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class AddItemsOptionsScreen extends StatelessWidget {
  const AddItemsOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddItemOptionsController());
    return Scaffold(
      appBar: controller.isPriceDep
          ? customAppBar(title: 'السعر حسب الاختيار')
          : customAppBar(title: 'الاختيار'),
      body: GetBuilder<AddItemOptionsController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Column(
              children: [
                const SizedBox(height: 20),
                controller.isPriceDep
                    ? const SizedBox()
                    : TitleAndIsBasicToggle(),
                Row(
                  children: [
                    Expanded(
                      child: CustomSmallBoldTitle(
                        title: 'الخيارات',
                      ),
                    ),
                    CustomButton(
                        onTap: () => controller.goToAddOptionElement(),
                        text: 'إضافة'),
                    const SizedBox(width: 20)
                  ],
                ),
                Expanded(
                  child: controller.addedOptionElement.isNotEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.addedOptionElement.length,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) => ItemOptionListItem(
                                title:
                                    controller.addedOptionElement[index].name ??
                                        '',
                                price:
                                    controller.addedOptionElement[index].price,
                                onTapDelete: () {
                                  controller.deleteElement(index);
                                },
                              ))
                      : ListIsEmptyTextGeneral(
                          text: 'لا يوجد خيارات',
                        ),
                ),
                controller.isPriceDep && controller.itemOption != null
                    ? const SizedBox()
                    : GoHomeButton(
                        onTap: () {
                          controller.onTapSave(context);
                        },
                        text: 'حفظ'),
                const SizedBox(height: 20)
              ],
            )),
      ),
    );
  }
}

class TitleAndIsBasicToggle extends StatelessWidget {
  const TitleAndIsBasicToggle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddItemOptionsController>(
        builder: (controller) => Column(
              children: [
                const SizedBox(height: 20),
                const CustomSmallBoldTitle(title: 'عنوان الخيار'),
                CustomTextFormGeneral(
                  hintText: 'مثال: الحجم, النوع ,اضافات ..',
                  textEditingController: controller.title,
                  valid: (val) => validInput(val!, 2, 50),
                ),
                const SizedBox(height: 10),
                SmallToggleButtons(
                  optionOne: 'مطلوب',
                  optionTwo: 'اختياري',
                  initValue: controller.isEditAdditionalOptions
                      ? controller.isBasic
                      : 2,
                  onTapOne: () {
                    controller.isBasic = 1;
                  },
                  onTapTwo: () {
                    controller.isBasic = 0;
                  },
                ),
              ],
            ));
  }
}

class ItemOptionListItem extends StatelessWidget {
  final String title;
  final price;
  final void Function() onTapDelete;

  const ItemOptionListItem(
      {super.key,
      required this.title,
      required this.onTapDelete,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AutoSizeText(title,
                  maxLines: 1,
                  minFontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmall),
            ),
          ),
          Text('$price ريال', style: titleSmall),
          TextButton(
              onPressed: onTapDelete,
              child: Text(
                'حذف',
                style: titleSmall2.copyWith(color: Colors.red),
              ))
        ],
      ),
    );
  }
}
