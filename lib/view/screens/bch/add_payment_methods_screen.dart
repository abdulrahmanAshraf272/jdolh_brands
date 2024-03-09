import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/add_payment_methods_controller.dart';
import 'package:jdolh_brands/controller/bch/add_policy_controller.dart';
import 'package:jdolh_brands/controller/bch/create_bch_controller.dart';
import 'package:jdolh_brands/controller/brand/create_brand_controller.dart';
import 'package:jdolh_brands/controller/legaldata/create_legaldata_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/data/models/payment_method.dart';
import 'package:jdolh_brands/test_screen.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_multi_select.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/skip_and_confirm_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_dropdown.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_holder.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class AddPaymentMethodsScreen extends StatelessWidget {
  const AddPaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddPaymentMethodsController());
    return GetBuilder<AddPaymentMethodsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'طرق الدفع'),
              floatingActionButton: CustomButtonOne(
                  textButton: 'حفظ',
                  onPressed: () => controller.addPaymentMethodsToDB(context)),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  AutoSizeText('أختر طرق الدفع',
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
                            sutitle: controller.appPercent[index],
                            fontSize: 13,
                            onTap: () {
                              controller.addRemovePaymentMethods(index);
                            },
                          ))),
                  const SizedBox(height: 80),
                ]),
              ),
            ));
  }
}
