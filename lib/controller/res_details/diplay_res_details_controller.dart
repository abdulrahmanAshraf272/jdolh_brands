import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resDetails.dart';
import 'package:jdolh_brands/data/models/res_details.dart';

class DisplayResDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  ResDetailsData resDetailsData = ResDetailsData(Get.find());
  late ResDetails resDetails;
  bool isService = false;
  MyServices myServices = Get.find();
  String cost = '';
  String invitorMax = '';
  String invitorMin = '';
  String cosuspensionTimest = '';
  String suspensionTime = '';
  String info = '';

  onTapEdit() {
    Get.offNamed(AppRouteName.addEditResDetails, arguments: resDetails);
  }

  getResDetails() async {
    var response =
        await resDetailsData.getResDetails(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    print('statusRequest =====$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        resDetails = ResDetails.fromJson(response['data']);
        cost = resDetails.cost.toString();
        invitorMax = resDetails.invitorMax.toString();
        invitorMin = resDetails.invitorMin.toString();
        suspensionTime = resDetails.suspensionTimeLimit.toString();
        info = resDetails.additionalInfo ?? '';
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getResDetails();
    isService = myServices.getIsService() == 1 ? true : false;
    super.onInit();
  }
}
