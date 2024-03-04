import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/decode_encode_time.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/view/screens/bch/add_worktime_screen.dart';
import 'package:jdolh_brands/view/widgets/common/custom_time_picker.dart';

class AddWorktimeController extends GetxController with AllTimes {
  StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  BchData bchData = BchData(Get.find());
  MyServices myServices = Get.find();

  TimeOfDay? timeHelper;

  // setTime(BuildContext context) {
  //   showTimePicker(context: context, initialTime: TimeOfDay.now())
  //       .then((value) {
  //     setSatFromP1(value);
  //     update();
  //     print(satFromP1.toString());
  //   });
  // }
  // print('satTime: $satTime');
  // print('sunTime: $sunTime');
  // print('monTime: $monTime');
  // print('tuesTime: $tuesTime');
  // print('wedTime: $wedTime');
  // print('thursTime: $thursTime');
  // print('friTime: $friTime');

  addWorktime(BuildContext context) async {
    if (encodeAllDays()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await bchData.addWorktime(
          bchid: '6',
          satTime: satTime!,
          sunTime: sunTime!,
          monTime: monTime!,
          tuesTime: tuesTime!,
          wedTime: wedTime!,
          thursTime: thursTime!,
          friTime: friTime!);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          displayDoneDialog(context, () {});
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  applyToAll() {
    if (satFromP1 == null || satToP1 == null) {
      Get.rawSnackbar(
          message:
              'يجب تعيين اوقات عمل يوم السبت , ليتم تطبيق باقي الايام مثل يوم السبت',
          duration: Duration(seconds: 5));
      return;
    }
    allDaysLikeSatDay();
    update();
  }

  switchDayOff(int i) {
    switchDayOffSetValue(i);
    update();
  }

  void showCustomTimePicker(BuildContext context, int d) {
    final initialTime = TimeOfDay.now();
    int adjustedMinute = (initialTime.minute ~/ 30) * 30;
    final initialAdjustedTime =
        TimeOfDay(hour: initialTime.hour, minute: adjustedMinute);
    timeHelper = initialAdjustedTime;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CustomTimePicker(
            initialTime: initialTime,
            onTimeSelected: (selectedTime) {
              timeHelper = selectedTime;
            },
            onTapSave: () {
              Get.back();
              setTime(timeHelper, d);
              update();
            },
            onTapReset: () {
              Get.back();
              setTime(null, d);
              update();
            },
          ),
        );
      },
    );
  }
}
