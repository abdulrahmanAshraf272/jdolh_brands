import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/ioption_element.dart';
import 'package:jdolh_brands/data/models/item_option.dart';

class AddItemOptionsController extends GetxController {
  //CreateItemsController createItemsController = Get.find();
  int? itemId;
  StatusRequest statusRequest = StatusRequest.none;
  ItemsData itemsData = ItemsData(Get.find());
  ItemOption? itemOption;
  bool isEditAdditionalOptions = false;
  bool isPriceDep = false;

  int isBasic = 0;
  int isMultiselect = 0;

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
          isMultiselect: isMultiselect.toString());
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          //TODO save changes in local.
          displayDoneDialog(context, () {
            itemOption!.title = title.text;
            itemOption!.priceDep = isPriceDep ? 1 : 0;
            itemOption!.isBasic = isBasic;
            itemOption!.isMultiselect = isMultiselect;

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
          itemId: itemId == null ? '' : itemId.toString(),
          title: title.text,
          priceDep: isPriceDep ? '1' : '0',
          isBasic: isBasic.toString(),
          isMultiselect: isMultiselect.toString(),
          elementsIds: elementsIds);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          ItemOption itemOptionCreated = ItemOption.fromJson(response['data']);
          if (isPriceDep) {
            //ValuesController.priceDepOption = itemOptionCreated;
            displayDoneDialog(context, () {
              Get.back(result: itemOptionCreated);
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

      isBasic = itemOption!.isBasic!;
      isMultiselect = itemOption!.isMultiselect!;
      print('multiselect: $isMultiselect');

      title.text = itemOption!.title!;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      //In EditItem , when add item , i have the id of the id, in CreateItem, i don't have the id of the item, it will store null, until i create the item
      if (Get.arguments['itemId'] != null) {
        itemId = Get.arguments['itemId'];
        print('itemId: $itemId');
      }
      if (Get.arguments['isPriceDep'] != null) {
        isPriceDep = Get.arguments['isPriceDep'];
        setValueIsPriceDep(isPriceDep);
      }
      getAndDisplayOptionElementIfEdit();
      diplayTitleAndIsBasicIfEdit();
    }
  }

  @override
  void onClose() {
    title.dispose();
    price.dispose();
    super.onClose();
  }
}
