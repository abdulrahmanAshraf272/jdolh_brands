import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/create_item_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_multi_select.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_dropdown.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_holder.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';
import 'package:jdolh_brands/view/widgets/items/available_item_time.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CreateItemsScreen extends StatelessWidget {
  const CreateItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateItemsController());
    return GetBuilder<CreateItemsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'انشاء عنصر'),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'صورة العنصر'),
                    const SizedBox(height: 10),
                    RectImageHolder(
                      onTap: () => controller.uploadImage(),
                      selectedImage: controller.selectedImage,
                    ),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'اسم العنصر'),
                    const SizedBox(height: 10),
                    CustomTextFormGeneral(
                      hintText: 'مثال: شاورما, عصير مانجا ..',
                      textEditingController: controller.title,
                      valid: (val) => validInput(val!, 2, 50),
                    ),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'وصف العنصر'),
                    const SizedBox(height: 10),
                    CustomTextFormGeneral(
                      hintText: 'ادخل وصف العنصر',
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
                      title: "السعر",
                      endText: 'ريال',
                    ),
                    AvailableItemTime(
                      onTapAllwaysAvailale: () {
                        //controller.display(context);
                        controller.switchIsAlwaysAvailable();
                      },
                    ),
                    GoHomeButton(
                      onTap: () {},
                      text: 'حفظ',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
  }
}
