import 'package:get/get.dart';
import 'package:jdolh_brands/core/services/services.dart';

class BchDetailsController extends GetxController {
  late int isService;
  MyServices myServices = Get.find();
  int bchstep = 1;

  String itemText = 'المنتجات';

  int donePercent = 0;

  trySomething() {
    myServices.setBchstep('5');
    getBchstepAndSetDonePercent();
  }

  goto(String routeName) {
    Get.toNamed(routeName)!.then((value) => getBchstepAndSetDonePercent());
  }

  getBchstepAndSetDonePercent() async {
    bchstep = myServices.getBchstep();
    if (bchstep == 1) {
      donePercent = 15;
    } else if (bchstep == 2) {
      donePercent = 30;
    } else if (bchstep == 3) {
      donePercent = 45;
    } else if (bchstep == 4) {
      donePercent = 60;
    } else if (bchstep == 5) {
      donePercent = 75;
    } else if (bchstep == 6) {
      donePercent = 90;
    } else if (bchstep == 7) {
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
