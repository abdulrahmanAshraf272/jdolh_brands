import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/auth/reset_password_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ResetPasswordController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Form(
              key: controller.formstate,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //SizedBox(height: Get.height * 0.1),
                          Text('من فضلك اكتب كلمة السر الجديدة',
                              textAlign: TextAlign.center, style: headline2),
                          SizedBox(height: Get.height * 0.06),

                          CustomTextFormAuthTwo(
                            obscureText: controller.passwordVisible,
                            visiblePasswordOnTap: () {
                              controller.showPassword();
                            },
                            hintText: 'كلمة السر',
                            labelText: 'Password',
                            valid: (val) {
                              return validInput(val!, 5, 100, 'password');
                            },
                            iconData: Icons.lock_outline,
                            textEditingController: controller.password,
                          ),
                          CustomTextFormAuthTwo(
                            obscureText: controller.passwordVisible,
                            visiblePasswordOnTap: () {
                              controller.showPassword();
                            },
                            hintText: 'اعد ادخال كلمة السر',
                            labelText: 'Password Again',
                            valid: (val) {
                              return validInput(val!, 5, 100, 'password');
                            },
                            iconData: Icons.lock_outline,
                            textEditingController:
                                controller.checkMatchPassword,
                          ),
                          CustomButtonOne(
                              textButton: 'حفظ',
                              onPressed: () async {
                                await controller.resetPassword();
                              }),
                        ]),
                  ),
                ),
              ),
            )),
      )),
    );
  }
}
