import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/categories.dart';
import 'package:jdolh_brands/data/models/categories.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';

class CategoriesController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  CategoriesData categoriesData = CategoriesData(Get.find());
  TextEditingController textEC = TextEditingController();
  List<MyCategories> categories = [];
  MyServices myServices = Get.find();

  // deleteCategoryLocale(int index) {
  //   categories.removeAt(index);
  //   update();
  // }

  onTapAddCategory() async {
    Get.defaultDialog(
      title: "اضافة صنف",
      content: Column(
        children: [
          CustomTextField(textEditingController: textEC, hintText: 'أسم الصنف'),
        ],
      ),
      onConfirm: () {
        Get.back();
        if (checkValidInput()) {
          addCategory(textEC.text);
          textEC.clear();
        }
      },
      textConfirm: 'حفظ',
    );
  }

  addCategory(String title) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.addCategories(
        bchid: myServices.getBchid(), title: title);
    statusRequest = handlingData(response);
    print(' ================$statusRequest');

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        if (myServices.getBchstep() < 5) {
          myServices.setBchstep('5');
        }
        MyCategories myCategories = MyCategories.fromJson(response['data']);
        categories.add(myCategories);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  deleteCategory(int index) async {
    String message = myServices.getIsService() == 1
        ? "غير مسموح بحذف الصنف لأنه مرتبط ب$servicesPloral"
        : "غير مسموح بحذف الصنف لأنه مرتبط ب$productsPloral";

    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.deleteCategories(
        categoryid: categories[index].id.toString());
    statusRequest = handlingData(response);
    print(' ================$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        categories.remove(categories[index]);
        print('delete success');
      } else if (response['message'] == "foreign key constraint violation.") {
        update();
        return message;
      } else {
        print('failure ${response['message']}');
      }
    }
    update();
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

  getCategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await categoriesData.getCategories(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseData(response);
      } else {
        //Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    } //
  }

  parseData(response) {
    categories.clear();
    List categoriesJson = response['data'];
    categories = categoriesJson.map((e) => MyCategories.fromJson(e)).toList();
    update();
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
