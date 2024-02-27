import 'dart:async';

import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/data/data_source/remote/auth/resend_verifycode.dart';
import 'package:jdolh_brands/data/data_source/remote/auth/verifycode.dart';

class VerifycodeController extends GetxController {
  late String email;
  late int resetPasswordOperation;
  StatusRequest statusRequest = StatusRequest.none;
  late String verifycode;
  late Timer timer;
  RxInt remainingSeconds = 60.obs;
  VerifycodeData verifycodeData = VerifycodeData(Get.find());
  ResendVerifycodeData resendVerifycodeData = ResendVerifycodeData(Get.find());
  bool resendVerifycodeButtonActive = false;

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        timer.cancel();
        //timer = null;
        timerFinished(); // Call your function here
      }
    });
  }

  timerFinished() {
    resendVerifycodeButtonActive = true;
    update();
  }

  checkVerifyIsCorrect() async {
    // statusRequest = StatusRequest.loading;
    // update();
    // var response = await verifycodeData.postData(email, verifycode);
    // statusRequest = handlingData(response);
    // print('============= $statusRequest ============');
    // if (statusRequest == StatusRequest.success) {
    //   if (response['status'] == 'success') {
    //     print('Response ===== ${response['status']}');
    //     update();
    //     goToSuccessScreenOrResetPassword();
    //   } else {
    //     statusRequest = StatusRequest.none;
    //     update();
    //     Get.defaultDialog(
    //       title: 'تنبيه',
    //       middleText: "الرمز الذي ادخلته غير صحيح!",
    //       textCancel: 'حسنا',
    //     );
    //   }
    // }
    goToSuccessScreenOrResetPassword();
  }

  goToSuccessScreenOrResetPassword() {
    if (resetPasswordOperation == 1) {
      Get.offAllNamed(AppRouteName.resetPassword, arguments: {"email": email});
    } else {
      Get.offAllNamed(AppRouteName.successOperation);
    }
  }

  resendVerifycode() async {
    if (!resendVerifycodeButtonActive) {
      return;
    }

    var response = await resendVerifycodeData.postData(email);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.rawSnackbar(message: "تم ارسال الرمز بنجاح!");
      } else {
        Get.rawSnackbar(message: "حدث خطأ حاول مرة اخرى");
      }
    } //else => will be hendled by HandlingDataView.
    remainingSeconds.value = 60;
    resendVerifycodeButtonActive = false;
    _startTimer();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    resetPasswordOperation = Get.arguments['resetPassword'];
    _startTimer();
  }
}
