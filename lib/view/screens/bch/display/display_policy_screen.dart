import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/add_policy_controller.dart';
import 'package:jdolh_brands/controller/bch/display/display_policy_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_radio_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class DisplayPolicyScreen extends StatelessWidget {
  const DisplayPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayPolicyController());
    return GetBuilder<DisplayPolicyController>(
        builder: (controller) => Scaffold(
            appBar: appBarWithButtonCreate(
                onTapCreate: () => controller.onTapEdit(),
                title: 'سياسة الحجز والفاتورة',
                buttonText: 'تعديل'),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  AutoSizeText('سياسة الحجز',
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
                            onTap: () {},
                            isSelected: controller.resPolicies[index].id ==
                                controller.selectedResPolicy,
                          ))),
                  const SizedBox(height: 30),
                  AutoSizeText('سياسة الفاتورة',
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
                            onTap: () {},
                            isSelected: controller.billPolicies[index].id ==
                                controller.selectedBillPolicy,
                          ))),
                  const SizedBox(height: 80),
                ]),
              ),
            )));
  }
}
