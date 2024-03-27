import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/add_ioption_element_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';
import 'package:jdolh_brands/view/widgets/number_textfield.dart';

class AddIoptionElementScreen extends StatelessWidget {
  const AddIoptionElementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddIoptionElementController());
    return Scaffold(
      appBar: customAppBar(title: 'اضافة'),
      body: GetBuilder<AddIoptionElementController>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(title: 'اسم الخيار'),
                  CustomTextFormGeneral(
                    hintText: 'مثال: كبير, متوسط ,صغير ..',
                    textEditingController: controller.name,
                  ),
                  NumberTextFieldWithTitleAndText(
                    textEditingController: controller.price,
                    title: "السعر",
                    endText: 'ريال',
                  ),
                  GoHomeButton(
                    onTap: () => controller.onTapAddElement(),
                    text: 'اضافة',
                  )
                ],
              ))),
    );
  }
}
