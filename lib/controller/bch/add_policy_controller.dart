import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/policy..dart';

class AddPolicyController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  BchData bchData = BchData(Get.find());
  int? selectedResPolicy;
  int? selectedBillPolicy;

  List<Policy> resPolicies = [];
  List<Policy> billPolicies = [];

  List<String> resPoliciesString = [];
  List<String> billPoliciesString = [];

  addPolicy(BuildContext context) async {
    if (allFieldSelected()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await bchData.addEditPolicy(
          bchid: myServices.getBchid(),
          billPolicyid: selectedBillPolicy.toString(),
          resPolicyid: selectedResPolicy.toString());
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          myServices.setBchstep('3');
          displayDoneDialog(context, () {
            Get.back();
          });
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  bool allFieldSelected() {
    if (selectedBillPolicy == null) {
      Get.rawSnackbar(message: 'اختر سياسة الفاتورة');
      return false;
    } else if (selectedResPolicy == null) {
      Get.rawSnackbar(message: 'اختر سياسة الحجز');
      return false;
    } else {
      return true;
    }
  }

  getPolicy() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchData.getBillResPolicies();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseValues(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    } //
  }

  parseValues(response) {
    resPolicies.clear();
    billPolicies.clear();

    List resJson = response['resPolicies'];
    List billJson = response['billPolicies'];

    resPolicies = resJson.map((e) => Policy.fromJsonRes(e)).toList();
    billPolicies = billJson.map((e) => Policy.fromJsonBill(e)).toList();

    resPoliciesString = resPolicies.map((policy) => policy.title!).toList();
    billPoliciesString = billPolicies.map((policy) => policy.title!).toList();
    update();
  }

  setSelectedResPolicy(int index) {
    selectedResPolicy = resPolicies[index].id;
    update();
  }

  setSelectedBillPolicy(int index) {
    selectedBillPolicy = billPolicies[index].id;
    update();
  }

  // setSelectedBillPolicy(String? value) {
  //   if (value != null) {
  //     selectedBillPolicy =
  //         billPolicies.firstWhere((element) => element.title == value).id;
  //     update();
  //   }
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPolicy();
  }
}
