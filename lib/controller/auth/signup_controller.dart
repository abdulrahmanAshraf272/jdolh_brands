import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/auth/signup.dart';
import 'package:jdolh_brands/data/data_source/remote/view_types_and_subtypes.dart';
import 'package:jdolh_brands/data/models/brandManager.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  SignupData signupData = SignupData(Get.find());
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  bool passwordVisible = true;
  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  goToVerifycode() {
    Get.offNamed(AppRouteName.verifyCode,
        arguments: {"email": email.text, 'resetPassword': 0});
  }

  goToLogin() {
    Get.offAllNamed(AppRouteName.login);
  }

  signup() async {
    var formdata = formstatepart.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await signupData.postData(
        name.text,
        username.text,
        password.text,
        email.text,
        phoneNumber.text,
      );
      statusRequest = handlingData(response);
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          goToVerifycode();
        } else if (response['message'] == 'username exist') {
          Get.defaultDialog(
            title: 'تنبيه',
            middleText: "اسم المستخدم مستعمل, من فضلك اختر اسم اخر",
            textCancel: 'حسنا',
          );
        } else if (response['message'] == "phone exist") {
          Get.defaultDialog(
              title: 'تنبيه',
              middleText: "الحساب موجود بالفعل,قم بتسجيل الدخول",
              textCancel: 'الغاء',
              textConfirm: 'حسنا',
              onConfirm: () => goToLogin());
        } else if (response['message'] == "email exist") {
          Get.defaultDialog(
              title: 'تنبيه',
              middleText: "الحساب موجود بالفعل,قم بتسجيل الدخول",
              textCancel: 'الغاء',
              textConfirm: 'حسنا',
              onConfirm: () => goToLogin());
        }
      } else {
        Get.rawSnackbar(message: 'أختر نوع المتجر من فضلك');
      }
    }
  }

  @override
  void onClose() {
    //if he wants to come back to edit name or somthing to find what he wrote and edit it .
    name.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    super.dispose();
  }
}
