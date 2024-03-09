import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/auth/login.dart';
import 'package:jdolh_brands/data/models/brandManager.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  get formstate => _formstate;
  TextEditingController usernameOrEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  StatusRequest statusRequest = StatusRequest.none;
  LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();
  bool passwordVisible = true;
  BrandManager brandManager = BrandManager();

  login() async {
    var formdata = _formstate.currentState;
    if (formdata!.validate()) {
      //Get.offAllNamed(AppRouteName.mainScreen);
      statusRequest = StatusRequest.loading;
      update();
      var response =
          await loginData.postData(usernameOrEmail.text, password.text);
      statusRequest = handlingData(response);
      update(); //after status change to display change on the screen.
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          print(' ======== ${response['data']} ======');
          brandManager = BrandManager.fromJson(response['data']);
          if (brandManager.brandManagerApprove == 1) {
            saveUserDataInSharedPreferences(brandManager);
            goToMainScreen();
          } else {
            goToVerifycode();
          }
        } else {
          Get.rawSnackbar(message: 'اسم المستخدم او كلمة المرور غير صحيحة');
        }
      }
    }
  }

  saveUserDataInSharedPreferences(BrandManager brandManager) {
    myServices.sharedPreferences
        .setString("id", brandManager.brandManagerId.toString());
    // myServices.sharedPreferences
    //     .setString("name", brandManager.brandManagerName!);
    // myServices.sharedPreferences
    //     .setString("username", brandManager.brandManagerUsername!);
    // myServices.sharedPreferences
    //     .setString("email", brandManager.brandManagerEmail!);
    // myServices.sharedPreferences
    //     .setString("phone", brandManager.brandManagerPhone!);
    //step 0 onboarding, step 1 login, step 2 mainScreen
    //myServices.sharedPreferences.setString("step", "2");
    print('===== Saving user data in sharedPreferences Done =====');
  }

  goToMainScreen() {
    myServices.sharedPreferences.setString("brandstep", "1");

    String brandstep = '4';
    if (brandstep == '4') {
      Get.offAllNamed(AppRouteName.mainScreen);
    } else {
      Get.offAllNamed(AppRouteName.more);
    }
  }

  createBrandIsDone() {
    //TODO: check if i create brand,
    //TODO: if yes, 1- save brandid, 2- brandstep = 2
  }

  createLegaldataIsDone() {
    //TODO: check if i create legaldata
    //TODO: if yes, brandstep = 3
  }
  createBchIsDone() {
    //TODO: check if i create bch
    //TODO: if yes, brandstep = 4
  }

  goToVerifycode() {
    Get.toNamed(AppRouteName.verifyCode,
        arguments: {"email": usernameOrEmail.text, 'resetPassword': 0});
  }

  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  goToSignUP() {
    Get.offNamed(AppRouteName.signUp);
  }

  goToForgetPassword() {
    if (usernameOrEmail.text.isEmpty) {
      Get.rawSnackbar(message: "من فضلك ادخل الايميل او اسم المستخدم");
    } else {
      Get.toNamed(AppRouteName.forgetPassword,
          arguments: {"email": usernameOrEmail.text, 'resetPassword': 1});
    }
  }

  @override
  void dispose() {
    usernameOrEmail.dispose();
    password.dispose();
    // super.dispose();
  }
}
