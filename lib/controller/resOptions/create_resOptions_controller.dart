import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/controller/resOptions/res_options_controller.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resOptions.dart';
import 'package:jdolh_brands/data/models/bch_worktime.dart';
import 'package:jdolh_brands/data/models/resOption.dart';
import 'package:jdolh_brands/view/widgets/common/custom_time_picker.dart';

class CreateResOptionsController extends GetxController with AllTimes {
  bool isEdit = false;
  ResOption? resOptionSent;

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

  createResOption(BuildContext context) async {
    if (allFieldsAdded()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await resOptionsData.createEditResOptions(
          elementId: resOptionSent != null
              ? resOptionSent!.resoptionsId.toString()
              : '',
          bchid: myServices.getBchid(),
          title: title.text,
          countLimit: countLimit.text,
          duration: isService ? '-1' : duration.text,
          alwaysAvailable: isAlwaysAvailable ? '1' : '0',
          satTime: isAlwaysAvailable ? '' : satTime ?? '',
          sunTime: isAlwaysAvailable ? '' : sunTime ?? '',
          monTime: isAlwaysAvailable ? '' : monTime ?? '',
          tuesTime: isAlwaysAvailable ? '' : tuesTime ?? '',
          wedTime: isAlwaysAvailable ? '' : wedTime ?? '',
          thursTime: isAlwaysAvailable ? '' : thursTime ?? '',
          friTime: isAlwaysAvailable ? '' : friTime ?? '');
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          //Change the donePercent of the bch
          if (!isEdit) {
            if (myServices.getBchstep() < 6) {
              myServices.setBchstep('6');
            }
            //add the item just created to local , to display it.
            ResOption resOption = ResOption.fromJson(response['data']);
            displayDoneDialog(context, () {
              Get.back(result: resOption);
            });
          } else {
            //==== Edit Operation ===//
            //Set all values to save any change happend
            resOptionSent!.resoptionsTitle = title.text;
            resOptionSent!.resoptionsCountLimit = int.parse(countLimit.text);
            resOptionSent!.resoptionsAlwaysAvailable =
                isAlwaysAvailable ? 1 : 0;
            resOptionSent!.resoptionsSatTime =
                isAlwaysAvailable ? '' : satTime ?? '';
            resOptionSent!.resoptionsSunTime =
                isAlwaysAvailable ? '' : sunTime ?? '';
            resOptionSent!.resoptionsMonTime =
                isAlwaysAvailable ? '' : monTime ?? '';
            resOptionSent!.resoptionsTuesTime =
                isAlwaysAvailable ? '' : tuesTime ?? '';
            resOptionSent!.resoptionsWedTime =
                isAlwaysAvailable ? '' : wedTime ?? '';
            resOptionSent!.resoptionsThursTime =
                isAlwaysAvailable ? '' : thursTime ?? '';
            resOptionSent!.resoptionsFriTime =
                isAlwaysAvailable ? '' : friTime ?? '';

            displayDoneDialog(context, () {
              Get.back(result: resOptionSent);
            });
          }
        } else {
          // statusRequest = StatusRequest.failure;
          // update();

          Get.back();
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
      } else if (int.parse(duration.text) % 30 != 0) {
        Get.rawSnackbar(message: 'يجب ان تكون مدة الحجز من مضاعفات ال30 دقيقة');
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

  getAndDisplayResOptionDataIfEdit() {
    if (Get.arguments != null) {
      isEdit = true;
      resOptionSent = Get.arguments;
      title.text = resOptionSent!.resoptionsTitle ?? '';
      duration.text =
          isService ? '-1' : resOptionSent!.resoptionsDuration.toString();

      countLimit.text = resOptionSent!.resoptionsCountLimit.toString();
      isAlwaysAvailable =
          resOptionSent!.resoptionsAlwaysAvailable == 1 ? true : false;
      if (!isAlwaysAvailable) {
        BchWorktime worktime = BchWorktime(
          bchworktimeSat: resOptionSent!.resoptionsSatTime,
          bchworktimeSun: resOptionSent!.resoptionsSunTime,
          bchworktimeMon: resOptionSent!.resoptionsMonTime,
          bchworktimeTues: resOptionSent!.resoptionsTuesTime,
          bchworktimeWed: resOptionSent!.resoptionsWedTime,
          bchworktimeThurs: resOptionSent!.resoptionsThursTime,
          bchworktimeFri: resOptionSent!.resoptionsFriTime,
        );
        decodeFromStringToTimeOfDay(worktime);
      }
    }
  }

  @override
  void onInit() {
    isService = myServices.getIsService() == 1 ? true : false;
    getAndDisplayResOptionDataIfEdit();
    super.onInit();
  }
}
