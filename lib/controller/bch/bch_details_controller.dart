import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';

class BchDetailsController extends GetxController {
  late int isService;
  MyServices myServices = Get.find();
  int bchstep = 1;

  String itemText = 'المنتجات';

  int donePercent = 0;

  trySomething() {
    myServices.setBchstep('7');
  }

  onTapCard(int step, routeNameAdd, routeNameDisplay) {
    if (bchstep >= step) {
      Get.toNamed(routeNameDisplay);
    } else {
      Get.toNamed(routeNameAdd)!.then((value) => getBchstepAndSetDonePercent());
    }
  }

  goto(String routeName) {
    Get.toNamed(routeName)!.then((value) => getBchstepAndSetDonePercent());
  }

  getBchstepAndSetDonePercent() async {
    bchstep = myServices.getBchstep();
    if (bchstep == 1) {
      donePercent = 13;
    } else if (bchstep == 2) {
      donePercent = 26;
    } else if (bchstep == 3) {
      donePercent = 40;
    } else if (bchstep == 4) {
      donePercent = 52;
    } else if (bchstep == 5) {
      donePercent = 65;
    } else if (bchstep == 6) {
      donePercent = 78;
    } else if (bchstep == 7) {
      donePercent = 90;
    } else if (bchstep >= 8) {
      donePercent = 100;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    update();
    print(bchstep);
  }

  @override
  void onInit() {
    getBchstepAndSetDonePercent();
    isService = myServices.getIsService();
    if (isService == 1) {
      itemText = 'الحجوزات';
    } else {
      itemText = 'المنتجات';
    }
    super.onInit();
  }
}
