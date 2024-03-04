import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resOptions.dart';
import 'package:jdolh_brands/view/widgets/common/custom_time_picker.dart';

class CreateResOptionsController extends GetxController with AllTimes {
  //TODO: Get the value from sharedprefs
  bool isService = false;

  StatusRequest statusRequest = StatusRequest.none;
  ResOptionsData resOptionsData = ResOptionsData(Get.find());
  MyServices myServices = Get.find();

  TextEditingController title = TextEditingController();
  TextEditingController countLimit = TextEditingController();
  TextEditingController duration = TextEditingController();
  bool isAlwaysAvailable = true;
  TimeOfDay? timeHelper;

  trySomething() {
    bool encodeDone = encodeAllDays();
    print('encodeDone $encodeDone');
    print('satTime $satTime');
    print('monTime $monTime');
    print('satFromP1 $satFromP1');
  }

  display(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            minuteInterval: 30, // Set the minute interval to 30 minutes
            onDateTimeChanged: (DateTime dateTime) {
              // Handle the selected time
            },
          ),
        );
      },
    );
  }

  createResOption(BuildContext context) async {
    if (allFieldsAdded()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await resOptionsData.createResOptions(
          bchid: '6',
          title: title.text,
          countLimit: countLimit.text,
          duration: isService ? '-1' : duration.text,
          alwaysAvailable: isAlwaysAvailable.toString(),
          satTime: satTime ?? '',
          sunTime: sunTime ?? '',
          monTime: monTime ?? '',
          tuesTime: tuesTime ?? '',
          wedTime: wedTime ?? '',
          thursTime: thursTime ?? '',
          friTime: friTime ?? '');
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

  allFieldsAdded() {
    if (title.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة عنوان التفضيل');
      return false;
    } else if (!checkCountLimit()) {
      return false;
    } else if (!checkDuration()) {
      return false;
    } else if (!isAlwaysAvailable) {
      if (!encodeAllDays()) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  checkCountLimit() {
    if (countLimit.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة الاماكن المتاحة');
      return false;
    } else if (int.parse(countLimit.text) < 1 ||
        int.parse(countLimit.text) > 200) {
      Get.rawSnackbar(message: 'الاماكن المتاحة الذي ادخلتها غير منطقية');
      return false;
    } else {
      return true;
    }
  }

  bool checkDuration() {
    if (!isService) {
      if (duration.text == '') {
        Get.rawSnackbar(message: 'من فضلك قم باضافة مدة الحجز');
        return false;
      } else if (int.parse(duration.text) < 30 ||
          int.parse(duration.text) > 360) {
        Get.rawSnackbar(message: 'مدة الحجز يجب ان تكون اكبر من 30 دقيقة');
        return false;
      } else {
        return true;
      }
    } else {
      return true;
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

  switchIsAlwaysAvailable() {
    isAlwaysAvailable = !isAlwaysAvailable;
    print('isAlwaysAvailable $isAlwaysAvailable');
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
