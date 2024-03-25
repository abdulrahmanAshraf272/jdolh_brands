import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/values_controller.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/Item.dart';

class ItemsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  ItemsData itemsData = ItemsData(Get.find());
  BchData bchData = BchData(Get.find());
  MyServices myServices = Get.find();
  bool isService = false;

  List<Item> items = [];

  onTapCard(int index) async {
    //clear addedItemOption from values controller
    ValuesController.addedItemOptions.clear();

    final result =
        await Get.toNamed(AppRouteName.editItem, arguments: items[index]);
    if (result != null) {
      items[index] = result;
      update();
    } else {
      print('result is null');
    }
  }

  goToAddItem() async {
    //clear addedItemOption from values controller
    ValuesController.addedItemOptions.clear();

    final result = await Get.toNamed(AppRouteName.createItems);
    //Check if i create item ,added to the list to display.
    if (result != null) {
      print('========result from addItem nav');
      Item item = result as Item;
      items.add(item);
      update();
    } else {
      print('== result from add item is null');
    }
  }

  onTapDelete(int index) {
    Get.defaultDialog(
        title: "حذف",
        middleText: 'هل تريد حذف ${items[index].itemsTitle}',
        onConfirm: () {
          Get.back();
          deleteItem(index);
        },
        buttonColor: const Color(0xffff6666),
        textConfirm: 'نعم',
        confirmTextColor: Colors.white);
  }

  deleteItem(int index) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchData.deleteDataGeneral(
        table: 'items', elementId: items[index].itemsId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        items.remove(items[index]);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  getItems() async {
    var response = await itemsData.getItems(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseValues(response);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  parseValues(response) {
    items.clear();
    List data = response['data'];
    items = data.map((e) => Item.fromJson(e)).toList();
  }

  @override
  void onInit() {
    isService = myServices.getIsService() == 1 ? true : false;
    getItems();
    super.onInit();
  }
}
