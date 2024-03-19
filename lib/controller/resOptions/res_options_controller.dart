import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resOptions.dart';
import 'package:jdolh_brands/data/models/resOption.dart';

class ResOptionsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ResOptionsData resOptionsData = ResOptionsData(Get.find());
  List<ResOption> resOptions = [];
  MyServices myServices = Get.find();

  onTapCard(int index) async {
    final result = await Get.toNamed(AppRouteName.createResOptions,
        arguments: resOptions[index]);
    if (result != null) {
      print('update done');
      resOptions[index] = result;
      update();
    }
  }

  deleteResOption(int index) async {
    String message = myServices.getIsService() == 1
        ? "غير مسموح بحذف التفضيل لأنه مرتبط ب$servicesPloral"
        : "غير مسموح بحذف التفضيل لأنه مرتبط ب$productsPloral";

    statusRequest = StatusRequest.loading;
    update();
    var response = await resOptionsData.deleteResOptions(
      resoptionid: resOptions[index].resoptionsId.toString(),
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('delete success');
        resOptions.remove(resOptions[index]);
      } else if (response['message'] == "foreign key constraint violation.") {
        update();
        return message;
      } else {
        print('failure ${response['message']}');
      }
    }
    update();
  }

  goToAddResOption() async {
    final result = await Get.toNamed(AppRouteName.createResOptions);
    if (result != null) {
      print('create done');
      resOptions.add(result);
      update();
    }
  }

  getResOptions() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await resOptionsData.getResOptions(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        parseValues(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parseValues(response) {
    resOptions.clear();
    List data = response['data'];
    resOptions = data.map((e) => ResOption.fromJson(e)).toList();
  }

  @override
  void onInit() {
    getResOptions();
    super.onInit();
  }
}
