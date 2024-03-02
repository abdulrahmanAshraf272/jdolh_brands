import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/test_screen.dart';

class TestController extends GetxController {
  goToScreen2() {
    Get.toNamed(
      AppRouteName.createBrand,
    );
  }
}
