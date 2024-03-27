import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';

class MoreController extends GetxController {
  bool isBrandManager = true;
  MyServices myServices = Get.find();
  int brandstep = 1;

  int donePercent = 50;

  onTapCard(int step, routeNameAdd, routeNameDisplay) {
    if (brandstep >= step) {
      Get.toNamed(routeNameDisplay);
    } else {
      Get.toNamed(routeNameAdd)!
          .then((value) => getBrandstepAndSetDonePercent());
    }
  }

  trySomething() {
    Get.offAllNamed(AppRouteName.login);
    myServices.clearSharedPrefsData();
  }

  goto(String routeName) {
    Get.toNamed(routeName)!.then((value) => getBrandstepAndSetDonePercent());
  }

  logout() {
    myServices.clearSharedPrefsData();
    Get.offAllNamed(AppRouteName.login);
  }

  getBrandstepAndSetDonePercent() async {
    brandstep = myServices.getBrandstep();
    if (brandstep == 1) {
      donePercent = 25;
    } else if (brandstep == 2) {
      donePercent = 50;
    } else if (brandstep == 3) {
      donePercent = 75;
    } else {
      donePercent = 100;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    update();
    print(brandstep);
  }

  @override
  void onInit() {
    getBrandstepAndSetDonePercent();
    isBrandManager = myServices.getIsBrandManager();
    super.onInit();
  }
}
