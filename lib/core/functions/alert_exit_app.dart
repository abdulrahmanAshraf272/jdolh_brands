import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: 'خروج',
      middleText: 'هل تريد الخروج من التطبيق؟',
      actions: [
        ElevatedButton(
          onPressed: () {
            exit(0);
          },
          child: const Text('نعم'),
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('الغاء'))
      ]);
  return Future.value(true);
}
