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
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/test_screen.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_radio_button.dart';
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
            appBar: customAppBar(title: 'سياسة الحجز والفاتورة'),
            floatingActionButton: CustomButtonOne(
                textButton: 'حفظ',
                onPressed: () => controller.addPolicy(context)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 20),
                    AutoSizeText('أختر سياسة الحجز',
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: AppColors.textDark,
                        )),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: controller.resPolicies.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) => RadioButtonItem(
                              title: controller.resPolicies[index].title!,
                              onTap: () {
                                controller.setSelectedResPolicy(index);
                              },
                              isSelected: controller.resPolicies[index].id ==
                                  controller.selectedResPolicy,
                            ))),
                    // CustomDropdown(
                    //   items: controller.resPoliciesString,
                    //   title: 'اختر سياسة الحجز',
                    //   displacement: 0,
                    //   listWidth: Get.width - 40,
                    //   onChanged: (String? value) {
                    //     controller.setSelectedResPolicy(value);
                    //   },
                    // ),
                    const SizedBox(height: 30),
                    AutoSizeText('أختر سياسة الفاتورة',
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: AppColors.textDark,
                        )),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: controller.billPolicies.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) => RadioButtonItem(
                              title: controller.billPolicies[index].title!,
                              onTap: () {
                                controller.setSelectedBillPolicy(index);
                              },
                              isSelected: controller.billPolicies[index].id ==
                                  controller.selectedBillPolicy,
                            ))),
                    // CustomDropdown(
                    //   items: controller.billPoliciesString,
                    //   title: 'اختر سياسة الفاتورة',
                    //   listWidth: Get.width - 40,
                    //   displacement: 0,
                    //   onChanged: (String? value) {
                    //     controller.setSelectedBillPolicy(value);
                    //   },
                    // ),
                    const SizedBox(height: 80),
                  ]),
                ))));
  }
}
