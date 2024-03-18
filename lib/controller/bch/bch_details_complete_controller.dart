import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/models/bch.dart';

class BchDetailsCompleteController extends GetxController {
  late int isService;
  late Bch bch;
  MyServices myServices = Get.find();

  String itemText = 'المنتجات';

  @override
  void onInit() {
    bch = Get.arguments;
    isService = myServices.getIsService();
    if (isService == 1) {
      itemText = 'الحجوزات';
    } else {
      itemText = 'المنتجات';
    }
    super.onInit();
  }
}
