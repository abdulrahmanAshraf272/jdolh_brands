import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/add_policy_controller.dart';
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

class AddPolicyScreen extends StatelessWidget {
  const AddPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddPolicyController());
    return GetBuilder<AddPolicyController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(
                title: 'سياسة الحجز والفاتورة',
              ),
              floatingActionButton: CustomButtonOne(
                  textButton: 'حفظ',
                  onPressed: () => controller.addPolicy(context)),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'سياسة الحجز',
                    mustAdded: true,
                  ),
                  CustomDropdown(
                    items: controller.resPoliciesString,
                    title: 'اختر سياسة الحجز',
                    displacement: 0,
                    listWidth: Get.width - 40,
                    onChanged: (String? value) {
                      controller.setSelectedResPolicy(value);
                    },
                  ),
                  const SizedBox(height: 30),
                  const CustomSmallBoldTitle(
                    title: 'سياسة الفاتورة',
                    mustAdded: true,
                  ),
                  CustomDropdown(
                    items: controller.billPoliciesString,
                    title: 'اختر سياسة الفاتورة',
                    listWidth: Get.width - 40,
                    displacement: 0,
                    onChanged: (String? value) {
                      controller.setSelectedBillPolicy(value);
                    },
                  ),
                  const SizedBox(height: 80),
                ]),
              ),
            ));
  }
}
