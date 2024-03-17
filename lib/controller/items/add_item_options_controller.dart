import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/create_item_controller.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/ioption_element.dart';
import 'package:jdolh_brands/data/models/item_option.dart';
import 'package:jdolh_brands/data/models/resOption.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class AddItemOptionsController extends GetxController {
  CreateItemsController createItemsController = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  ItemsData itemsData = ItemsData(Get.find());
  ItemOption? itemOption;
  bool isEditAdditionalOptions = false;
  bool isPriceDep = false;

  int isBasic = 0;

  GlobalKey<FormState> formstateOptionName = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();

  List<IOptionElement> addedOptionElement = [];

  goToAddOptionElement() async {
    final result = await Get.toNamed(AppRouteName.addIoptionElement,
        arguments: {"isPriceDep": isPriceDep, "itemOption": itemOption});
    if (result != null) {
      IOptionElement element = result as IOptionElement;
      addedOptionElement.add(element);
      update();
    }
  }

  onTapSave(BuildContext context) {
    if (isEditAdditionalOptions) {
      editItemOption(context);
    } else {
      addItemOption(context);
    }
  }

  editItemOption(BuildContext context) async {
    if (checkValidation()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await itemsData.editItemOption(
        itemoptionid: itemOption!.id.toString(),
        title: title.text,
        priceDep: isPriceDep ? '1' : '0',
        isBasic: isBasic.toString(),
      );
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          //TODO save changes in local.
          displayDoneDialog(context, () {
            itemOption!.title = title.text;
            itemOption!.priceDep = isPriceDep ? 1 : 0;
            itemOption!.isBasic = isBasic;

            Get.back(result: itemOption);
          });
        } else {
          print('no edit happend, same data');
          Get.back();
        }
      }
    }
  }

  addItemOption(BuildContext context) async {
    if (checkValidation()) {
      //Get Element Ids
      String elementsIds =
          addedOptionElement.map((element) => element.id).join(',');

      statusRequest = StatusRequest.loading;
      update();
      var response = await itemsData.addItemOption(
          title: title.text,
          priceDep: isPriceDep ? '1' : '0',
          isBasic: isBasic.toString(),
          elementsIds: elementsIds);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          ItemOption itemOptionCreated = ItemOption.fromJson(response['data']);
          if (isPriceDep) {
            createItemsController.priceDepOption = itemOptionCreated;
            displayDoneDialog(context, () {
              Get.back();
            });
          } else {
            displayDoneDialog(context, () {
              Get.back(result: itemOptionCreated);
            });
          }
          //saveChangesInlocal(response);
        } else {
          print('no edit happend, same data');
          Get.back();
        }
      }
    }
  }

  bool checkValidation() {
    if (title.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة عنوان الاختيار');
      return false;
    }
    if (addedOptionElement.isEmpty) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة الإختيارات');
      return false;
    }
    return true;
  }

  deleteElement(int index) async {
    if (addedOptionElement.length < 2) {
      Get.rawSnackbar(message: 'لا يمكنك حذف جميع الاختيارات');
      return;
    }
    //Deleting element from DB
    var response = await itemsData.deleteItemOptionElement(
        elementId: addedOptionElement[index].id.toString());
    statusRequest = handlingData(response);
    print('======$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success deleting element');
      }
    }
    //Deleting element from list.
    addedOptionElement.remove(addedOptionElement[index]);
    update();
  }

  setValueIsPriceDep(bool isPriceDep) {
    if (isPriceDep) {
      title.text = 'السعر حسب الإختيار';
      price.text = '';
      isBasic = 1;
    }
  }

  getAndDisplayOptionElementIfEdit() async {
    itemOption = Get.arguments['value'];
    if (itemOption != null) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await itemsData.getOptionElements(
          itemoptionid: itemOption!.id!.toString());
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          parseData(response);
        } else {
          statusRequest = StatusRequest.failure;
          print('failute');
        }
      }
      update();
    }
  }

  parseData(response) {
    addedOptionElement.clear();
    List dataJson = response['data'];
    addedOptionElement =
        dataJson.map((e) => IOptionElement.fromJson(e)).toList();
  }

  diplayTitleAndIsBasicIfEdit() {
    if (!isPriceDep && itemOption != null) {
      isEditAdditionalOptions = true;
      isBasic = itemOption!.isBasic == 1 ? 1 : 2;
      title.text = itemOption!.title!;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['isPriceDep'] != null) {
        isPriceDep = Get.arguments['isPriceDep'];
        setValueIsPriceDep(isPriceDep);
      }
      getAndDisplayOptionElementIfEdit();
      diplayTitleAndIsBasicIfEdit();
    }
  }
}
