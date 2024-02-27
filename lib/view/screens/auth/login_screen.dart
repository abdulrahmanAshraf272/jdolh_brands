import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/auth/login_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/alert_exit_app.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/auth/have_account_question.dart';
import 'package:jdolh_brands/view/widgets/auth/login/forget_pass_button.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
          child: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginController>(
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
                            Text('JDOLH',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 33.sp,
                                  color: AppColors.primaryColor,
                                )),
                            SizedBox(height: 20),
                            //SizedBox(height: Get.height * 0.1),
                            Text('تسجيل دخول', style: headline2),
                            SizedBox(height: Get.height * 0.06),

                            CustomTextFormAuthTwo(
                              hintText: 'اسم المستخدم او البريد الالكتروني',
                              labelText: 'Email',
                              valid: (val) {
                                return validInput(
                                  val!,
                                  3,
                                  100,
                                );
                              },
                              iconData: Icons.person,
                              textEditingController: controller.usernameOrEmail,
                            ),

                            CustomTextFormAuthTwo(
                              obscureText: controller.passwordVisible,
                              visiblePasswordOnTap: () {
                                controller.showPassword();
                              },
                              hintText: 'كلمة السر',
                              labelText: 'Password',
                              valid: (val) {
                                return validInput(val!, 3, 100, 'password');
                              },
                              iconData: Icons.lock_outline,
                              textEditingController: controller.password,
                            ),
                            ForgetPassButton(
                              onPress: () => controller.goToForgetPassword(),
                            ),
                            const SizedBox(height: 20),
                            CustomButtonOne(
                                textButton: 'تسجيل دخول',
                                onPressed: () async {
                                  await controller.login();
                                }),
                            const SizedBox(height: 20),
                            HaveAccountQuestion(
                                onPress: () => controller.goToSignUP(),
                                text: "ليس لديك حساب؟",
                                buttonText: 'انشاء حساب')
                          ]),
                    ),
                  ),
                ),
              )),
        ),
      )),
    );
  }
}
