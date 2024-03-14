import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/decode_encode_time.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/bch_worktime.dart';

class DisplayWorktimeController extends GetxController with AllTimes {
  StatusRequest statusRequest = StatusRequest.loading;
  BchData bchData = BchData(Get.find());
  MyServices myServices = Get.find();
  late BchWorktime worktime;

  onTapEdit() {
    Get.offNamed(AppRouteName.addWorktime, arguments: {"isEdit": true});
  }

  getWorktime() async {
    var response = await bchData.getWorktime(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        worktime = BchWorktime.fromJson(response['data']);
        decodeFromStringToTimeOfDay(worktime);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getWorktime();
    super.onInit();
  }
}
