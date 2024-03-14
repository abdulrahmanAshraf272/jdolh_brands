import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/policy..dart';

class DisplayPolicyController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  BchData bchData = BchData(Get.find());
  List<Policy> resPolicies = [];
  List<Policy> billPolicies = [];
  late int selectedResPolicy;
  late int selectedBillPolicy;

  onTapEdit() {
    Get.offNamed(AppRouteName.addPolicy, arguments: {"isEdit": true});
  }

  getSelectedPolicy() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await bchData.getSelectedPolicy(bchid: myServices.getBchid());
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseValues(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    } //
  }

  parseValues(response) {
    List resJson = response['resPolicies'];
    List billJson = response['billPolicies'];

    resPolicies = resJson.map((e) => Policy.fromJsonRes(e)).toList();
    billPolicies = billJson.map((e) => Policy.fromJsonBill(e)).toList();

    selectedResPolicy = response['selectedResPolicy'];
    selectedBillPolicy = response['selectedBillPolicy'];
    print('selectedResPolicy: $selectedResPolicy');
    print('selectedBillPolicy: $selectedBillPolicy');
    update();
  }

  @override
  void onInit() {
    getSelectedPolicy();
    super.onInit();
  }
}
