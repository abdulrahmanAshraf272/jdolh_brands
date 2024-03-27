import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resDetails.dart';
import 'package:jdolh_brands/data/models/res_details.dart';

class AddEditResDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ResDetailsData resDetailsData = ResDetailsData(Get.find());
  ResDetails? resDetails;
  bool isService = false;
  bool isEdit = false;

  MyServices myServices = Get.find();

  TextEditingController cost = TextEditingController();
  TextEditingController invitorMin = TextEditingController();
  TextEditingController invitorMax = TextEditingController();
  TextEditingController suspensionTime = TextEditingController();
  TextEditingController info = TextEditingController();

  addResDetails(BuildContext context) async {
    if (!checkValidation()) {
      return;
    }
    statusRequest = StatusRequest.loading;
    update();
    var response = await resDetailsData.addEditResDetails(
        elementId: resDetails != null ? resDetails!.id!.toString() : '',
        bchid: myServices.getBchid(),
        cost: cost.text,
        invitorMax: invitorMax.text,
        invitorMin: invitorMin.text,
        suspensionTime: suspensionTime.text,
        info: info.text);
    statusRequest = handlingData(response);
    print(' ================$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        if (!isEdit) {
          myServices.setBchstep('8');
        }
        displayDoneDialog(context, () {
          Get.back();
        });
      } else {
        statusRequest = StatusRequest.failure;
        print('failute');
      }
      update();
    }
  }

  checkValidation() {
    if (cost.text == '') {
      Get.rawSnackbar(message: 'يجب عليك تحديد تكلفة الحجز');
      return false;
    }
    if (suspensionTime.text == '') {
      Get.rawSnackbar(message: 'يجب عليك تحديد مدة تعليق الحجز');
      return false;
    }
    if (int.parse(suspensionTime.text) < 15) {
      Get.rawSnackbar(message: 'يجب ان تكون مدة تعليق الحجز اكبر من 15 دقيقة');
      return false;
    }
    return true;
  }

  getResDetailsValuesIfEdit() {
    if (Get.arguments != null) {
      isEdit = true;
      resDetails = Get.arguments;
      cost.text = resDetails!.cost.toString();
      invitorMax.text = resDetails!.invitorMax.toString();
      invitorMin.text = resDetails!.invitorMin.toString();
      suspensionTime.text = resDetails!.suspensionTimeLimit.toString();
      info.text = resDetails!.additionalInfo ?? '';
      update();
    }
  }

  @override
  void onInit() {
    //Default value
    suspensionTime.text = '60';
    cost.text = '0';
    getResDetailsValuesIfEdit();
    isService = myServices.getIsService() == 1 ? true : false;

    super.onInit();
  }

  @override
  void onClose() {
    cost.dispose();
    invitorMin.dispose();
    invitorMax.dispose();
    suspensionTime.dispose();
    info.dispose();
    super.onClose();
  }
}
