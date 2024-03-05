import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/payment_method.dart';

class AddPaymentMethodsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  BchData bchData = BchData(Get.find());
  List<PaymentMethod> paymentMethods = [];

  List<int> selectedPaymentMethods = [];

  addRemovePaymentMethods(int index) {
    if (selectedPaymentMethods.contains(paymentMethods[index].id!)) {
      removePaymentMethod(index);
    } else {
      addPaymentMethod(index);
    }
  }

  addPaymentMethod(int index) {
    selectedPaymentMethods.add(paymentMethods[index].id!);
    print(selectedPaymentMethods);
  }

  removePaymentMethod(int index) {
    selectedPaymentMethods.remove(paymentMethods[index].id!);
    print(selectedPaymentMethods);
  }

  getPaymentMethods() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchData.getPaymentMethods();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('get payment methods success');
        parseValues(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    } //
  }

  parseValues(response) {
    paymentMethods.clear();

    List paymentMethodsJson = response['data'];

    paymentMethods =
        paymentMethodsJson.map((e) => PaymentMethod.fromJson(e)).toList();
    update();
  }

  addPaymentMethodsToDB(BuildContext context) async {
    if (allFieldSelected()) {
      String selectedPaymentMethodsString =
          selectedPaymentMethods.map((int item) => item.toString()).join(',');
      print(selectedPaymentMethodsString);
      statusRequest = StatusRequest.loading;
      update();
      var response = await bchData.addPaymentMethods(
          bchid: '6', //TODO: set the correct bch id
          paymentMethodsid: selectedPaymentMethodsString);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          displayDoneDialog(context, () {});
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  bool allFieldSelected() {
    if (selectedPaymentMethods.isEmpty) {
      Get.rawSnackbar(message: 'اختر طرق الدفع');
      return false;
    } else {
      return true;
    }
  }

  @override
  void onInit() {
    getPaymentMethods();
    super.onInit();
  }
}
