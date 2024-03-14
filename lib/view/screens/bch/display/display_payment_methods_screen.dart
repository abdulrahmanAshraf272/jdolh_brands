import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/add_payment_methods_controller.dart';
import 'package:jdolh_brands/controller/bch/display/display_payment_methods_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_multi_select.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class DisplayPaymentMethodsScreen extends StatelessWidget {
  const DisplayPaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayPaymentMethodsController());
    return GetBuilder<DisplayPaymentMethodsController>(
        builder: (controller) => Scaffold(
              appBar: appBarWithButtonCreate(
                  onTapCreate: () => controller.onTapEdit(),
                  title: 'طرق الدفع',
                  buttonText: 'تعديل'),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  AutoSizeText('طرق الدفع',
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: AppColors.textDark,
                      )),
                  const SizedBox(height: 10),
                  ListView.builder(
                      itemCount: controller.paymentMethods.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) => MultiSelectItem(
                            title: controller.paymentMethods[index].title!,
                            sutitle: controller.diplayAdminPercent(index),
                            fontSize: 13,
                            onTap: () {},
                            isClickable: false,
                          ))),
                  const SizedBox(height: 80),
                ]),
              ),
            ));
  }
}
