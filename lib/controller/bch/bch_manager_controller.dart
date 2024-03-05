import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch_manager.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/categories.dart';
import 'package:jdolh_brands/data/models/bch_manager.dart';
import 'package:jdolh_brands/data/models/categories.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';

class BchManagerController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  BchManagerData bchManagerData = BchManagerData(Get.find());
  TextEditingController textEC = TextEditingController();

  BchManager? bchManager;
  String name = '';
  String username = '';
  String password = '';

  // deleteCategoryLocale(int index) {
  //   categories.removeAt(index);
  //   update();
  // }

  onTapBchManager() async {
    Get.defaultDialog(
      title: "اسم المدير",
      content: Column(
        children: [
          CustomTextField(
              textEditingController: textEC,
              hintText: 'ادخل الاسم بالإنجليزية'),
        ],
      ),
      onConfirm: () {
        Get.back();
        if (checkValidInput()) {
          textEC.clear();
        }
      },
      textConfirm: 'إضافة',
    );
  }

  addBchManager(String name) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchManagerData.addBchManager(
        brandid: '24', bchid: '6', name: textEC.text);
    statusRequest = handlingData(response);
    print(' ================$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        bchManager = BchManager.fromJson(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  onTapDelete() {
    Get.defaultDialog(
        title: "حذف المدير",
        middleText: 'هل تريد حذف المدير نهائياً؟',
        onConfirm: () {
          Get.back();
          deleteBchManager();
        },
        backgroundColor: Color(0xffffcccc),
        buttonColor: Color(0xffff6666),
        textConfirm: 'نعم',
        confirmTextColor: Colors.white);
  }

  deleteBchManager() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchManagerData.deleteBchManager(
        bchid: '6', bchManagerid: bchManager!.bchmanagerId.toString());
    statusRequest = handlingData(response);
    print(' ================$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.rawSnackbar(message: 'تم حذف المدير نهائياً');
        bchManager = null;
        print('delete success');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  bool checkValidInput() {
    String inputText = textEC.text.trim();

    if (inputText.isEmpty) {
      return false;
    } else {
      // Check if the input contains Arabic characters
      RegExp arabicRegExp = RegExp(r'[\u0600-\u06FF]');
      if (arabicRegExp.hasMatch(inputText)) {
        Get.rawSnackbar(message: 'يرجى إدخال الاسم بالإنجليزية');
        return false;
      } else if (inputText.length > 25) {
        Get.rawSnackbar(message: 'الحد الأقصى 25 حرف');
        return false;
      } else if (inputText.length < 2) {
        Get.rawSnackbar(message: 'الحد الأدنى 3 حروف');
        return false;
      } else {
        return true;
      }
    }
  }

  onTapSwitchEnable() {
    Get.defaultDialog(
      title: bchManager!.bchmanagerIsActive == 1 ? "ايقاف مؤقت" : 'تفعيل',
      middleText: bchManager!.bchmanagerIsActive == 1
          ? 'هل تريد ايقاف صلاحيات المدير مؤقتاً؟'
          : 'هل تريد تفعيل صلاحيات المدير ؟',
      onConfirm: () {
        Get.back();
        switchEnableBchManager();
      },
      textConfirm: 'نعم',
    );
  }

  switchEnableBchManager() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchManagerData.switchEnableBchManager(
        bchManagerid: bchManager!.bchmanagerId.toString());
    statusRequest = handlingData(response);
    print(' ================$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        if (bchManager!.bchmanagerIsActive == 1) {
          bchManager!.bchmanagerIsActive = 0;
          Get.rawSnackbar(message: 'تم ايقاف المدير مؤقتاً');
        } else {
          bchManager!.bchmanagerIsActive = 1;
          Get.rawSnackbar(message: 'تم تفعيل صلاحيات المدير');
        }

        print('switch enable bchManager Done successfuly');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getBchManager() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchManagerData.getBchManager(bchid: '6');
    statusRequest = handlingData(response);
    print(' ================$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        bchManager = BchManager.fromJson(response['data']);
        if (bchManager != null) {
          name = bchManager!.bchmanagerName ?? '';
          username = bchManager!.bchmanagerUsername ?? '';
          password = bchManager!.bchmanagerPassword ?? '';
        }

        print('get bchManager Done successfuly');
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getBchManager();
    super.onInit();
  }
}
