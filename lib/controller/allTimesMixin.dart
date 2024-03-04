import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/functions/decode_encode_time.dart';

mixin AllTimes {
  bool isSatOff = false;
  bool isSunOff = false;
  bool isMonOff = false;
  bool isTuesOff = false;
  bool isWedOff = false;
  bool isThursOff = false;
  bool isFriOff = false;

  switchDayOffSetValue(int i) {
    if (i == 1) {
      isSatOff = !isSatOff;
      satFromP1 = null;
      satFromP2 = null;
      satToP1 = null;
      satToP2 = null;
    } else if (i == 2) {
      isSunOff = !isSunOff;
      sunFromP1 = null;
      sunFromP2 = null;
      sunToP1 = null;
      sunToP2 = null;
    } else if (i == 3) {
      isMonOff = !isMonOff;
      monFromP1 = null;
      monFromP2 = null;
      monToP1 = null;
      monToP2 = null;
    } else if (i == 4) {
      isTuesOff = !isTuesOff;
      tuesFromP1 = null;
      tuesFromP2 = null;
      tuesToP1 = null;
      tuesToP2 = null;
    } else if (i == 5) {
      isWedOff = !isWedOff;
      wedFromP1 = null;
      wedFromP2 = null;
      wedToP1 = null;
      wedToP2 = null;
    } else if (i == 6) {
      isThursOff = !isThursOff;
      thursFromP1 = null;
      thursFromP2 = null;
      thursToP1 = null;
      thursToP2 = null;
    } else if (i == 7) {
      isFriOff = !isFriOff;
      friFromP1 = null;
      friFromP2 = null;
      friToP1 = null;
      friToP2 = null;
    }
  }

  String? satTime;
  String? sunTime;
  String? monTime;
  String? tuesTime;
  String? wedTime;
  String? thursTime;
  String? friTime;

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

  allDaysLikeSatDay() {
    sunFromP1 = satFromP1;
    sunToP1 = satToP1;
    sunFromP2 = satFromP2;
    sunToP2 = satToP2;

    monFromP1 = satFromP1;
    monToP1 = satToP1;
    monFromP2 = satFromP2;
    monToP2 = satToP2;

    tuesFromP1 = satFromP1;
    tuesToP1 = satToP1;
    tuesFromP2 = satFromP2;
    tuesToP2 = satToP2;

    wedFromP1 = satFromP1;
    wedToP1 = satToP1;
    wedFromP2 = satFromP2;
    wedToP2 = satToP2;

    thursFromP1 = satFromP1;
    thursToP1 = satToP1;
    thursFromP2 = satFromP2;
    thursToP2 = satToP2;

    friFromP1 = satFromP1;
    friToP1 = satToP1;
    friFromP2 = satFromP2;
    friToP2 = satToP2;
  }

  String displayTime(TimeOfDay? time, BuildContext context) {
    if (time != null) {
      return time.format(context).toString();
    } else {
      return '';
    }
  }

  encodeAllDays() {
    satTime = encodeTime(satFromP1, satToP1, satFromP2, satToP2);
    sunTime = encodeTime(sunFromP1, sunToP1, sunFromP2, sunToP2);
    monTime = encodeTime(monFromP1, monToP1, monFromP2, monToP2);

    tuesTime = encodeTime(tuesFromP1, tuesToP1, tuesFromP2, tuesToP2);
    wedTime = encodeTime(wedFromP1, wedToP1, wedFromP2, wedToP2);
    thursTime = encodeTime(thursFromP1, thursToP1, thursFromP2, thursToP2);
    friTime = encodeTime(friFromP1, friToP1, friFromP2, friToP2);

    if (checkAllDays() == null) {
      return false;
    } else {
      return true;
    }
  }

  checkAllDays() {
    //it well be null, if the first periud is null- second periud is optinanl
    if (satTime == null && !isSatOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم السبت');
    } else if (sunTime == null && !isSunOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الأحد');
    } else if (monTime == null && !isMonOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الأثنين');
    } else if (tuesTime == null && !isTuesOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الثلثاء');
    } else if (wedTime == null && !isWedOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الأربعاء');
    } else if (thursTime == null && !isThursOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الخميس');
    } else if (friTime == null && !isFriOff) {
      Get.rawSnackbar(message: 'قم بتعيين اوقات عمل يوم الجمعة');
    } else {
      return true;
    }
  }

  setTime(TimeOfDay? value, int d) {
    switch (d) {
      case 1:
        satFromP1 = value;
        break;
      case 2:
        satToP1 = value;
        break;
      case 3:
        satFromP2 = value;
        break;
      case 4:
        satToP2 = value;
        break;
      case 5:
        sunFromP1 = value;
        break;
      case 6:
        sunToP1 = value;
        break;
      case 7:
        sunFromP2 = value;
        break;
      case 8:
        sunToP2 = value;
        break;

      case 9:
        monFromP1 = value;
        break;
      case 10:
        monToP1 = value;
        break;
      case 11:
        monFromP2 = value;
        break;
      case 12:
        monToP2 = value;
        break;

      case 13:
        tuesFromP1 = value;
        break;
      case 14:
        tuesToP1 = value;
        break;
      case 15:
        tuesFromP2 = value;
        break;
      case 16:
        tuesToP2 = value;
        break;

      case 17:
        wedFromP1 = value;
        break;
      case 18:
        wedToP1 = value;
        break;
      case 19:
        wedFromP2 = value;
        break;
      case 20:
        wedToP2 = value;
        break;

      case 21:
        thursFromP1 = value;
        break;
      case 22:
        thursToP1 = value;
        break;
      case 23:
        thursFromP2 = value;
        break;
      case 24:
        thursToP2 = value;
        break;

      case 25:
        friFromP1 = value;
        break;
      case 26:
        friToP1 = value;
        break;
      case 27:
        friFromP2 = value;
        break;
      case 28:
        friToP2 = value;
        break;
    }
  }
}
