import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';

class CategoriesController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController textEditingController = TextEditingController();
  List<String> categories = [];

  onTapAddCategory() async {
    Get.defaultDialog(
      title: "اضافة صنف",
      content: Column(
        children: [
          CustomTextField(
              textEditingController: textEditingController,
              hintText: 'أسم الصنف'),
        ],
      ),
      onConfirm: () async {},
      textConfirm: 'حفظ',
    );
  }
}
