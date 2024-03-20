import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/models/bch.dart';

class BchDetailsCompleteController extends GetxController {
  String headerMessage =
      'تهانيا! لقد اكملت بياناتك بنجاح, بانتظار موافقة الادارة';
  late int isService;
  late Bch bch;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    bch = Get.arguments;
    isService = myServices.getIsService();
    if (bch.bchIsApproved == 1) {
      headerMessage = 'تهانيا!\n لقد تم الموافقة على الفرع من قبل الإدارة';
    }
    super.onInit();
  }
}
