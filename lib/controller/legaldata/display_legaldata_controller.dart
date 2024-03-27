import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/legaldata.dart';
import 'package:jdolh_brands/data/models/legaldata.dart';

class DisplayLegaldataController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  LegaldataData legaldataData = LegaldataData(Get.find());
  MyServices myServices = Get.find();
  late Legaldata legaldata;

  late int crNumber;
  late int taxNumber;
  late String crPhoto;
  late String taxPhoto;

  getLegaldata() async {
    var response =
        await legaldataData.getLegaldata(brandid: myServices.getBrandid());
    statusRequest = handlingData(response);
    print('statusRequest =====$statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        legaldata = Legaldata.fromJson(response['data']);
        crNumber = legaldata.legaldataCrNumber!;
        taxNumber = legaldata.legaldataTaxNumber!;

        crPhoto = legaldata.legaldataCrPhoto!;
        taxPhoto = legaldata.legaldataTaxPhoto!;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getLegaldata();
    super.onInit();
  }
}
