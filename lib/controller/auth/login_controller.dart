import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/auth/login.dart';
import 'package:jdolh_brands/data/models/brand.dart';
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
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          parseData(response);
        } else {
          if (response['message'] == "The password is not correct") {
            Get.rawSnackbar(message: 'كلمة السر غير صحيحة');
          } else {
            Get.rawSnackbar(
                message: 'اسم المستخدم او البريد الالكتروني غير صحيح');
          }
        }
      }
    }
  }

  parseData(response) {
    bool isBrandManager = response['isBrandManager'];
    if (isBrandManager) {
      myServices.setIsBrandManager(true);

      final brandManager = BrandManager.fromJson(response['brandManager']);
      myServices.setBrandManagerid(brandManager.brandManagerId.toString());
      if (brandManager.brandManagerApprove == 0) {
        goToVerifycode();
        return;
      }

      //Brand == false? the manager doesn't create brand.
      var brandJson = response['brand'];
      if (brandJson == false) {
        print('brand not created = false');
        myServices.setBrandstep('1');
        Get.offAllNamed(AppRouteName.more);
        return;
      }

      //manager create brand, save brand id and change step to 2.
      Brand brand = Brand.fromJson(brandJson);
      myServices.setBrandid(brand.brandId.toString());
      myServices.setIsService(brand.brandIsService!);
      myServices.setBrandstep('2');
      print('brandTitle: ${brand.brandStoreName}');

      bool isLegalDataDone = response['isLegalDataDone'];
      if (isLegalDataDone) {
        myServices.setBrandstep('3');
        print('isLegalData = true');
      }

      bool isCreateBch = response['bchs'];
      if (isCreateBch) {
        myServices.setBrandstep('4');
        print('bchs = true');
      }

      print('brandstep = ${myServices.getBrandstep()}');
      if (myServices.getBrandstep() == 4) {
        Get.offAllNamed(AppRouteName.mainScreen);
      } else {
        Get.offAllNamed(AppRouteName.more);
      }
    } else if (isBrandManager == false) {
      //// ============ USER IS BCH MANAGER =============//
      myServices.setIsBrandManager(false);

      var bchManager = response['bchManager'];
      myServices.setBchManagerid(bchManager['bchmanager_id'].toString());
      print('bch manager id: ${myServices.getBchManagerId()}');

      var brandJson = response['brand'];
      Brand brand = Brand.fromJson(brandJson);
      myServices.setBrandid(brand.brandId.toString());
      myServices.setIsService(brand.brandIsService!);
      myServices.setBrandstep('4');

      Get.offAllNamed(AppRouteName.mainScreen);
    }
  }

  // saveUserDataInSharedPreferences(BrandManager brandManager) {
  //   myServices.sharedPreferences
  //       .setString("id", brandManager.brandManagerId.toString());
  //   // myServices.sharedPreferences
  //   //     .setString("name", brandManager.brandManagerName!);
  //   // myServices.sharedPreferences
  //   //     .setString("username", brandManager.brandManagerUsername!);
  //   // myServices.sharedPreferences
  //   //     .setString("email", brandManager.brandManagerEmail!);
  //   // myServices.sharedPreferences
  //   //     .setString("phone", brandManager.brandManagerPhone!);
  //   //step 0 onboarding, step 1 login, step 2 mainScreen
  //   //myServices.sharedPreferences.setString("step", "2");
  //   print('===== Saving user data in sharedPreferences Done =====');
  // }

  // goToMainScreen() {
  //   myServices.sharedPreferences.setString("brandstep", "1");

  //   String brandstep = '4';
  //   if (brandstep == '4') {
  //     Get.offAllNamed(AppRouteName.mainScreen);
  //   } else {
  //     Get.offAllNamed(AppRouteName.more);
  //   }
  // }

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
    super.dispose();
    usernameOrEmail.dispose();
    password.dispose();
  }
}
