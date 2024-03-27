import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/add_item_options_controller.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/ioption_element.dart';
import 'package:jdolh_brands/data/models/item_option.dart';

class AddIoptionElementController extends GetxController {
  bool isPriceDep = false;
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  ItemOption? itemOption;

  ItemsData itemsData = ItemsData(Get.find());

  onTapAddElement() async {
    if (checkValidation()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await itemsData.addItemOptionElement(
          itemoptionid: itemOption != null ? itemOption!.id.toString() : '',
          name: name.text,
          price: price.text);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          IOptionElement element = IOptionElement.fromJson(response['data']);
          Get.back(result: element);
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  bool checkValidation() {
    if (name.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة اسم الاختيار');
      return false;
    }

    if (isPriceDep) {
      if (price.text == '') {
        Get.rawSnackbar(message: 'من فضلك قم باضافة سعر الاختيار');
        return false;
      }
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isPriceDep = Get.arguments['isPriceDep'];
      itemOption = Get.arguments['itemOption'];
    }
  }

  @override
  void onClose() {
    name.dispose();
    price.dispose();
    super.onClose();
  }
}
