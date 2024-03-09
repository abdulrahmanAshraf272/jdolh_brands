import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/ioption_element.dart';
import 'package:jdolh_brands/data/models/item_option.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class AddItemOptionsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ItemsData itemsData = ItemsData(Get.find());

  bool isPriceDep = false;

  int isBasic = 0;

  GlobalKey<FormState> formstateOptionName = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController optionName = TextEditingController();
  TextEditingController price = TextEditingController();

  List<int> addedOptionElementIds = [];
  List<IOptionElement> addedOptionElement = [];

  addItemOption() async {
    if (checkValidation()) {
      String elementsIds =
          addedOptionElementIds.map((int item) => item.toString()).join(',');
      statusRequest = StatusRequest.loading;
      update();
      var response = await itemsData.addItemOption(
          title: title.text,
          priceDep: isPriceDep ? '1' : '0',
          isBasic: isBasic.toString(),
          elementids: elementsIds);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          ItemOption itemOption = ItemOption.fromJson(response['data']);

          print('success');
          Get.back(result: itemOption);
          Get.rawSnackbar(message: 'تم اضافة الاختيار');
        } else {
          statusRequest = StatusRequest.failure;
          print('failute');
        }
      }
      update();
    }
  }

  bool checkValidation() {
    if (title.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة عنوان الاختيار');
      return false;
    }
    if (addedOptionElementIds.isEmpty) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة الإختيارات');
      return false;
    }
    return true;
  }

  goToAddOptionElement() async {
    final result = await Get.toNamed(AppRouteName.addIoptionElement,
        arguments: {"isPriceDep": isPriceDep});
    if (result != null) {
      IOptionElement element = result as IOptionElement;
      addedOptionElement.add(element);
      addedOptionElementIds.add(element.id!);
      print(element.name);
      Get.rawSnackbar(message: 'تم اضافة الاختيار');
      update();
    }
  }

  deleteElement(int index) async {
    //Deleting element from list.
    addedOptionElement.remove(addedOptionElement[index]);
    addedOptionElementIds
        .removeWhere((element) => element == addedOptionElement[index].id);
    update();

    //Deleting element from DB
    statusRequest = StatusRequest.loading;
    var response = await itemsData.deleteItemOptionElement(
        elementId: addedOptionElement[index].id.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success deleting element');
      }
    }
  }

  bool validOption() {
    if (optionName.text == '') {
      Get.rawSnackbar(message: 'قم باضافة اسم الخيار');
      return false;
    } else if (isPriceDep && price.text == '') {
      Get.rawSnackbar(message: 'قم باضافة السعر');
      return false;
    } else {
      return true;
    }
  }

  setValueIsPriceDep(bool isPriceDep) {
    if (isPriceDep) {
      title.text = 'السعر حسب الإختيار';
      price.text = '';
      isBasic = 1;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      isPriceDep = Get.arguments['isPriceDep'];

      setValueIsPriceDep(isPriceDep);
    }
  }
}
