import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/decode_encode_time.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/view/screens/bch/add_worktime_screen.dart';

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

  addWorktime() {
    satTime = encodeTime(satFromP1, null, null, satToP2);
    print(satTime);
  }

  decodeTime() {
    Map<String, TimeOfDay?> times = decodeTimeCustomMoreClean(satTime!);
    print(times['endTimeP2']);
  }

  void showCustomTimePicker(BuildContext context, int d) {
    final initialTime = TimeOfDay.now();

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
          ),
        );
      },
    ).then((value) {
      setTime(timeHelper, d);
      update();
      print(satFromP1.toString());
    });
  }

  String displayTime(TimeOfDay? time, BuildContext context) {
    if (time != null) {
      return time.format(context).toString();
    } else {
      return '';
    }
  }
}

mixin AllTimes {
  String? satTime;

  TimeOfDay? satFromP1;
  TimeOfDay? satToP1;
  TimeOfDay? satFromP2;
  TimeOfDay? satToP2;

  TimeOfDay? sunFromP1;
  TimeOfDay? sunToP1;
  TimeOfDay? sunFromP2;
  TimeOfDay? sunToP2;

  TimeOfDay? monFromP1;
  TimeOfDay? monToP1;
  TimeOfDay? monFromP2;
  TimeOfDay? monToP2;

  TimeOfDay? tuesFromP1;
  TimeOfDay? tuesToP1;
  TimeOfDay? tuesFromP2;
  TimeOfDay? tuesToP2;

  TimeOfDay? wedFromP1;
  TimeOfDay? wedToP1;
  TimeOfDay? wedFromP2;
  TimeOfDay? wedToP2;

  TimeOfDay? thursFromP1;
  TimeOfDay? thursToP1;
  TimeOfDay? thursFromP2;
  TimeOfDay? thursToP2;

  TimeOfDay? friFromP1;
  TimeOfDay? friToP1;
  TimeOfDay? friFromP2;
  TimeOfDay? friToP2;

  setTime(TimeOfDay? value, int d) {
    if (d == 1) {
      satFromP1 = value;
    } else if (d == 2) {
      satToP1 = value;
    } else if (d == 3) {
      satFromP2 = value;
    } else if (d == 4) {
      satToP2 = value;
    }
  }
}
