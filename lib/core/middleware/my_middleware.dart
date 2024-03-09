import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    //String step = myServices.sharedPreferences.getString('step') ?? '0';
    String brandstep =
        myServices.sharedPreferences.getString('brandstep') ?? '0';
    if (brandstep == '0') {
      return const RouteSettings(name: AppRouteName.login);
    } else if (brandstep == '4') {
      return const RouteSettings(name: AppRouteName.mainScreen);
    } else {
      return const RouteSettings(name: AppRouteName.more);
    }
  }
}
