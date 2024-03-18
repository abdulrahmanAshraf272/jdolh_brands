import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/bch.dart';

class BchDetailsController extends GetxController {
  late int isService;
  BchData bchData = BchData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  late Bch bch;
  MyServices myServices = Get.find();
  int bchstep = 1;

  String itemText = 'المنتجات';

  int donePercent = 0;

  trySomething() {
    myServices.setBchstep('8');
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

    if (donePercent == 100) {
      bchComplete();
    }

    await Future.delayed(const Duration(milliseconds: 500));
    update();
    print(bchstep);
  }

  bchComplete() async {
    var response = await bchData.bchComplete(bch.bchId.toString());
    statusRequest = handlingData(response);
    print(' ================$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('set bch complete is done');
      } else {
        statusRequest = StatusRequest.failure;
        print('set bch complete failed');
      }
    }
  }

  @override
  void onInit() {
    bch = Get.arguments;
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
