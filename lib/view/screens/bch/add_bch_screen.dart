import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/create_bch_controller.dart';
import 'package:jdolh_brands/controller/brand/create_brand_controller.dart';
import 'package:jdolh_brands/controller/legaldata/create_legaldata_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/skip_and_confirm_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_dropdown.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_holder.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class CreateBchScreen extends StatelessWidget {
  const CreateBchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateBchController());
    return GetBuilder<CreateBchController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(
                title: 'البيانات الأساسية',
              ),
              floatingActionButton: CustomButtonOne(
                  textButton: 'حفظ',
                  onPressed: () => controller.createBch(context)),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Form(
                key: controller.formstatepart,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'اسم الفرع',
                        mustAdded: true,
                      ),
                      CustomTextFormGeneral(
                        hintText: 'ادخل اسم الفرع',
                        textEditingController: controller.bchName,
                        valid: (val) => validInput(val!, 3, 100),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text('المدينة',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: AppColors.textDark,
                                )),
                            Text(
                              '*',
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.redText),
                            ),
                            CustomDropdown(
                              items: cities,
                              width: Get.width / 2.2,
                              title: 'اختر المدينة',
                              onChanged: (String? value) {
                                // Handle selected value
                                controller.city = value;
                                print(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'ارفق صورة من الفرع',
                        mustAdded: true,
                      ),
                      const SizedBox(height: 10),
                      RectImageHolder(
                        onTap: () => controller.uploadImage(),
                        selectedImage: controller.selectedImage,
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'وصف الفرع',
                        mustAdded: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormGeneral(
                        hintText: 'ادخل وصف تشويقي للفرع الذي سيعرض للمسخدمين',
                        textEditingController: controller.bchDesc,
                        valid: (val) => validInput(val!, 3, 100),
                        height: 120.h,
                        maxLength: 255,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'موقع الفرع',
                        mustAdded: true,
                      ),
                      DateOrLocationDisplayContainer(
                          hintText: controller.diplayLocation(),
                          iconData: Icons.place,
                          onTap: () => controller.goToAddLocation()),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'رابط  موقع الفرع',
                        mustAdded: false,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormGeneral(
                        hintText: 'رابط موقع الفرع من خرائط جوجل',
                        textEditingController: controller.bchLocationLink,
                        suffixIcon: const Icon(Icons.link),
                      ),
                      const SizedBox(height: 20),
                      const CustomSmallBoldTitle(
                        title: 'رقم التواصل',
                        mustAdded: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormGeneral(
                        hintText: 'رقم يعرض للزبائن للتواصل مع الفرع',
                        textEditingController: controller.bchPhone,
                        valid: (val) => validInput(val!, 3, 100),
                        textInputType: TextInputType.number,
                        withPhoneKey: true,
                      ),
                      const SizedBox(height: 80),
                    ]),
                  ),
                ),
              ),
            ));
  }
}
