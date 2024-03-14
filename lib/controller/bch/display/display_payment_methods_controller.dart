import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/models/payment_method.dart';

class DisplayPaymentMethodsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  BchData bchData = BchData(Get.find());
  List<PaymentMethod> paymentMethods = [];

  List<int> selectedPaymentMethods = [];

  onTapEdit() {
    Get.offNamed(AppRouteName.addPaymentMethod, arguments: {"isEdit": true});
  }

  getSelectedPaymentMethods() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await bchData.getSelectedPaymentMethods(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('get payment methods success');
        parseValues(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    } //
  }

  String diplayAdminPercent(int index) {
    String adminMoney = '${paymentMethods[index].adminMoney} ريال';
    String adminPercent = '${paymentMethods[index].adminPercent}%';

    if (paymentMethods[index].adminMoney != null &&
        paymentMethods[index].adminPercent != null) {
      return 'رسوم التطبيق $adminMoney + $adminPercent';
    }
    if (paymentMethods[index].adminMoney != null &&
        paymentMethods[index].adminPercent == null) {
      return 'رسوم التطبيق $adminMoney';
    }
    if (paymentMethods[index].adminPercent != null &&
        paymentMethods[index].adminMoney == null) {
      return 'رسوم التطبيق $adminPercent';
    }

    return 'لا يوجد رسوم';
  }

  parseValues(response) {
    paymentMethods.clear();

    List paymentMethodsJson = response['data'];

    paymentMethods =
        paymentMethodsJson.map((e) => PaymentMethod.fromJson(e)).toList();
    update();
  }

  @override
  void onInit() {
    getSelectedPaymentMethods();
    super.onInit();
  }
}
