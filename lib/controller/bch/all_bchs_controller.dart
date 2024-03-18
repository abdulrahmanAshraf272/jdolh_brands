import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/bch.dart';

class AllBchsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  BchData bchData = BchData(Get.find());
  List<Bch> bchs = [];
  MyServices myServices = Get.find();

  onTapCreateBch() {
    if (myServices.getBchstep() != 0) {
      Get.rawSnackbar(
          message: 'لا يمكن انشاء فرع جديد حتى تكمل بيانات الفرع السابق');
    } else {
      //TODO go to create new bch
    }
  }

  getAllBchs() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchData.getAllBchs(brandid: myServices.getBrandid());
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

  goToBchDetails(int index) {
    //Save the bch id in shared prefs
    myServices.setBchid(bchs[index].bchId.toString());
    Get.toNamed(AppRouteName.bchDetails, arguments: bchs[index]);

    // if (bchs[index].bchIsComplete == 1) {
    //   Get.toNamed(AppRouteName.bchDetailsComplete, arguments: bchs[index]);
    // } else {
    //   Get.toNamed(AppRouteName.bchDetails, arguments: bchs[index]);
    // }
  }

  parseValues(response) {
    bchs.clear();
    List data = response['data'];
    bchs = data.map((e) => Bch.fromJson(e)).toList();
  }

  @override
  void onInit() {
    getAllBchs();
    super.onInit();
  }
}
