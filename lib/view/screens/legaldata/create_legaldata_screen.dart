import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/brand/create_brand_controller.dart';
import 'package:jdolh_brands/controller/legaldata/create_legaldata_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/skip_and_confirm_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_holder.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class CreateLegaldataScreen extends StatelessWidget {
  const CreateLegaldataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateLegaldataController());
    return GetBuilder<CreateLegaldataController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(
                  title: 'البيانات القانونية',
                  withArrowBack: controller.afterSignup ? false : true),
              floatingActionButton: SaveAndSkipButton(
                confirmOnTap: () => controller.createBrand(context),
                skipOnTap: controller.afterSignup ? controller.onTapSkip : null,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Form(
                key: controller.formstatepart,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'رقم السجل التجاري',
                        mustAdded: true,
                      ),
                      CustomTextFormGeneral(
                        hintText: 'ادخل رقم السجل التجاري',
                        textEditingController: controller.crNumber,
                        valid: (val) => validInput(val!, 3, 100),
                        textInputType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'ارفق صورة من السجل التجاري',
                        mustAdded: true,
                      ),
                      const SizedBox(height: 10),
                      RectImageHolder(
                        onTap: () => controller.uploadImageCr(),
                        selectedImage: controller.selectedImageCr,
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'رقم الضريبة',
                        mustAdded: true,
                      ),
                      CustomTextFormGeneral(
                        hintText: 'ادخل رقم الرقم الضريبي',
                        textEditingController: controller.taxNumber,
                        valid: (val) => validInput(val!, 3, 100),
                        textInputType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'ارفق صورة الشهادة الضريبية',
                        mustAdded: true,
                      ),
                      const SizedBox(height: 10),
                      RectImageHolder(
                        onTap: () => controller.uploadImageTax(),
                        selectedImage: controller.selectedImageTax,
                      ),
                      const SizedBox(height: 80),
                    ]),
                  ),
                ),
              ),
            ));
  }
}
