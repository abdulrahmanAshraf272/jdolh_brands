import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';

class MoreController extends GetxController {
  MyServices myServices = Get.find();
  int brandstep = 1;

  int donePercent = 50;

  trySomething() {
    Get.offAllNamed(AppRouteName.login);
    myServices.clearSharedPrefsData();
  }

  goto(String routeName) {
    Get.toNamed(routeName)!.then((value) => getBrandstepAndSetDonePercent());
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
    super.onInit();
  }
}
