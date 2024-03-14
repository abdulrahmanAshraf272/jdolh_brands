import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resOptions.dart';
import 'package:jdolh_brands/data/models/resOption.dart';

class ResOptionsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ResOptionsData resOptionsData = ResOptionsData(Get.find());
  List<ResOption> resOptions = [];
  MyServices myServices = Get.find();

  onTapCard(int index) {
    Get.toNamed(AppRouteName.displayResOptions, arguments: resOptions[index])!
        .then((value) => update());
  }

  goToAddResOption() {
    Get.toNamed(AppRouteName.createResOptions);
  }

  getResOptions() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await resOptionsData.getResOptions(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        parseValues(response);
      } else {
        print('failure');
      }
    }
    update();
  }

  parseValues(response) {
    resOptions.clear();
    List data = response['data'];
    resOptions = data.map((e) => ResOption.fromJson(e)).toList();
  }

  @override
  void onInit() {
    getResOptions();
    super.onInit();
  }
}
