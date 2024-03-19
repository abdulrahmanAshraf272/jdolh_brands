import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/create_item_controller.dart';
import 'package:jdolh_brands/controller/values_controller.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/item_option.dart';

class AdditionalItemOptionsController extends GetxController {
  //CreateItemsController createItemsController = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  BchData bchData = BchData(Get.find());
  int? itemid;
  List<ItemOption> itemOptions = [];

  onTapCard(int index) async {
    final result = await Get.toNamed(AppRouteName.addItemOptions,
        arguments: {'value': itemOptions[index]});
    if (result != null) {
      //itemOptions[index] = result;
      ValuesController.addedItemOptions[index] = result;
      itemOptions = List.from(ValuesController.addedItemOptions);
      update();
    }
  }

  onTapAddOption() async {
    final result = await Get.toNamed(AppRouteName.addItemOptions,
        arguments: {'itemId': itemid});
    if (result != null) {
      itemOptions.add(result);
      ValuesController.addedItemOptions.add(result);
      update();
    }
  }

  onTapDelete(int index) {
    Get.defaultDialog(
        title: "حذف",
        middleText: 'هل تريد حذف ${itemOptions[index].title}',
        onConfirm: () {
          Get.back();
          deleteItem(index);
        },
        buttonColor: const Color(0xffff6666),
        textConfirm: 'نعم',
        confirmTextColor: Colors.white);
  }

  deleteItem(int index) async {
    final String id = itemOptions[index].id.toString();
    itemOptions.remove(itemOptions[index]);
    var response =
        await bchData.deleteDataGeneral(table: 'itemsoption', elementId: id);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('delete Succeed');
      } else {
        print('delete failed');
      }
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    itemOptions = List.from(ValuesController.addedItemOptions);
    //itemOptions.removeWhere((element) => element.priceDep == 1);
    if (Get.arguments != null) {
      if (Get.arguments['itemId'] != null) {
        itemid = Get.arguments['itemId'];
        print('item id: $itemid');
      }
    }
  }
}
