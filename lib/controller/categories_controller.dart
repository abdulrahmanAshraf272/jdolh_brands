import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';

class CategoriesController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController textEC = TextEditingController();
  List<String> categories = [];

  deleteCategoryLocale(int index) {
    categories.removeAt(index);
    update();
  }

  onTapAddCategory() async {
    Get.defaultDialog(
      title: "اضافة صنف",
      content: Column(
        children: [
          CustomTextField(textEditingController: textEC, hintText: 'أسم الصنف'),
        ],
      ),
      onConfirm: () async {
        if (checkValidInput()) {
          Get.back();
          categories.add(textEC.text);
          textEC.clear();

          update();
        }
      },
      textConfirm: 'حفظ',
    );
  }

  bool checkValidInput() {
    if (textEC.text == '') {
      return false;
    } else {
      if (textEC.text.length > 25) {
        Get.rawSnackbar(message: 'الحد الاقصى 25 حرف');
        return false;
      } else if (textEC.text.length < 2) {
        Get.rawSnackbar(message: 'الحد الادنى 3 حروف');
        return false;
      } else if (categories.contains(textEC.text)) {
        Get.rawSnackbar(message: 'الصنف موجود بالفعل!');
        return false;
      } else {
        return true;
      }
    }
  }
}
