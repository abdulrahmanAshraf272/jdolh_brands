import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/location_services.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/view/screens/bch/all_bchs_screen.dart';
import 'package:jdolh_brands/view/screens/home_screen.dart';
import 'package:jdolh_brands/view/screens/more_screen.dart';

class MainController extends GetxController {
  // late bool serviceEnabled;
  // LocationPermission? permission;
  final LocationService locationService = LocationService();
  late Position position;
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  int currentPage = 0;
  List<Widget> listPage = [
    const AllBchsScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const MoreScreen()
  ];
  changePage(int i) {
    currentPage = i;
    update();
  }
}
