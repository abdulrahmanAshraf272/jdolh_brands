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
      Get.toNamed(AppRouteName.createBch);
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

  goToBchDetails(int index) async {
    //Save the bch id in shared prefs
    myServices.setBchid(bchs[index].bchId.toString());

    if (bchs[index].bchIsComplete == 1) {
      myServices.setBchid(bchs[index].bchId.toString());
      Get.toNamed(AppRouteName.bchDetailsComplete, arguments: bchs[index]);
    } else {
      await checkBchstep(bchs[index]);
      myServices.setBchid(bchs[index].bchId.toString());
      Get.toNamed(AppRouteName.bchDetails, arguments: bchs[index]);
    }
  }

  Future checkBchstep(Bch bch) async {
    var response = await getBchstepFromDb(bch);

    int step = 1;
    if (response['worktime']) {
      step = 2;
    }
    if (bch.bchBillPolicyid != null) {
      step = 3;
    }
    if (response['payment']) {
      step = 4;
    }
    if (response['categories']) {
      step = 5;
    }
    if (response['resoption']) {
      step = 6;
    }
    if (response['items']) {
      step = 7;
    }
    if (response['resdetails']) {
      step = 8;
    }

    myServices.setBchstep(step.toString());
    print(myServices.getBchstep());
  }

  Future getBchstepFromDb(Bch bch) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bchData.getBchstep(bch.bchId.toString());
    statusRequest = handlingData(response);
    print('statusRequest ==== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print(response);
        return response;
      } else {
        print('failure');
      }
    } else {
      print('failure');
    }
    update();
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
