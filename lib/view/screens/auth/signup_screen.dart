import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/auth/signup_controller.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/alert_exit_app.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/auth/have_account_question.dart';
import 'package:jdolh_brands/view/widgets/auth/signup/dropdown_brandTypes.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return Scaffold(
      body: SafeArea(
          child: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignupController>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: (int page) {
                      controller.currentPage = page;
                    },
                    children: [
                      SignupPart1(),
                      SignupPart2(),
                    ],
                  ),
                )),
      )),
    );
  }
}

class SignupPart1 extends StatelessWidget {
  const SignupPart1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.formstatepart1,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(height: Get.height * 0.1),
                  Text('JDOLH',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 33.sp,
                        color: AppColors.primaryColor,
                      )),
                  SizedBox(height: 20),
                  Text('إنشاء حساب جديد', style: headline2),
                  SizedBox(height: 20),
                  CustomTextFormAuthTwo(
                    hintText: 'اسمك',
                    labelText: 'Name',
                    valid: (val) => validInput(val!, 2, 100),
                    iconData: Icons.person,
                    textEditingController: controller.name,
                  ),
                  CustomTextFormAuthTwo(
                    hintText: 'اسم المستخدم',
                    labelText: 'Username',
                    valid: (val) => validInput(val!, 2, 50, 'username'),
                    iconData: Icons.person,
                    textEditingController: controller.username,
                  ),

                  CustomTextFormAuthTwo(
                    hintText: 'البريد الإلكتروني',
                    labelText: 'Email',
                    valid: (val) {
                      return validInput(val!, 5, 100, 'email');
                    },
                    iconData: Icons.email_outlined,
                    textEditingController: controller.email,
                  ),

                  CustomTextFormAuthTwo(
                    obscureText: controller.passwordVisible,
                    visiblePasswordOnTap: () {
                      controller.showPassword();
                    },
                    hintText: 'الرقم السري',
                    labelText: 'Password',
                    valid: (val) {
                      return validInput(val!, 5, 100, 'password');
                    },
                    iconData: Icons.lock_outline,
                    textEditingController: controller.password,
                  ),

                  CustomTextFormAuthTwo(
                    hintText: 'رقم الجوال',
                    labelText: 'Phone',
                    valid: (val) {
                      return validInput(val!, 10, 10, 'phone');
                    },
                    iconData: Icons.phone_android_outlined,
                    textEditingController: controller.phoneNumber,
                  ),
                  const SizedBox(height: 20),
                  CustomButtonOne(
                      textButton: 'التالي',
                      onPressed: () async {
                        await controller.onTapNext();
                      }),
                  HaveAccountQuestion(
                      onPress: () => controller.goToLogin(),
                      text: "لديك حساب بالفعل؟",
                      buttonText: 'تسجيل دخول')
                ]),
          ),
        ),
      ),
    );
  }
}

class SignupPart2 extends StatelessWidget {
  const SignupPart2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.formstatepart2,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(height: 20),
                  Text('JDOLH',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 33.sp,
                        color: AppColors.primaryColor,
                      )),
                  SizedBox(height: 20),
                  Text('بيانات المتجر', style: headline2),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      controller.imageSelected != null
                          ? CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  MemoryImage(controller.imageSelected!),
                            )
                          : const CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  AssetImage('assets/images/person4.jpg'),
                            ),
                      Positioned(
                          bottom: -10,
                          left: 70,
                          child: IconButton(
                              onPressed: controller.selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.black87,
                              )))
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormAuthTwo(
                    hintText: 'اسم المتجر',
                    labelText: 'Name',
                    valid: (val) => validInput(val!, 2, 100),
                    iconData: Icons.person,
                    textEditingController: controller.brandName,
                  ),
                  const SizedBox(height: 10),

                  const DropdownBrandTypes(),

                  const SizedBox(height: 20),
                  CustomButtonOne(
                      textButton: 'انشاء الحساب',
                      onPressed: () async {
                        await controller.signup();
                      }),
                  SizedBox(height: 10),
                  // HaveAccountQuestion(
                  //     onPress: () => controller.goToLogin(),
                  //     text: "لديك حساب بالفعل؟",
                  //     buttonText: 'تسجيل دخول'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: controller.onTapBack,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text('الصفحة السابقة'),
                            ],
                          )),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class CustomBottomAppBarTwo extends StatelessWidget {
  const CustomBottomAppBarTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return BottomAppBar(
        child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: controller.onTapBack,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                ),
                Text('السابق'),
              ],
            )),
        Spacer(),
        Container(
          child: GoHomeButton(
            width: 120.w,
            onTap: controller.onTapNext,
            withArrowForwardIcon: true,
            text: 'التالي',
          ),
        ),
      ],
    ));
  }
}
