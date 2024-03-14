import 'package:get/get.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/models/bch_worktime.dart';
import 'package:jdolh_brands/data/models/resOption.dart';

class DisplayResOptionController extends GetxController with AllTimes {
  bool isService = false;
  MyServices myServices = Get.find();
  late ResOption resOption;

  onTapEdit() {
    Get.offNamed(AppRouteName.createResOptions, arguments: resOption);
  }

  displayAvailableTime() {
    if (resOption.resoptionsAlwaysAvailable == 0) {
      BchWorktime worktime = BchWorktime(
        bchworktimeSat: resOption.resoptionsSatTime,
        bchworktimeSun: resOption.resoptionsSunTime,
        bchworktimeMon: resOption.resoptionsMonTime,
        bchworktimeTues: resOption.resoptionsTuesTime,
        bchworktimeWed: resOption.resoptionsWedTime,
        bchworktimeThurs: resOption.resoptionsThursTime,
        bchworktimeFri: resOption.resoptionsFriTime,
      );
      decodeFromStringToTimeOfDay(worktime);
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      resOption = Get.arguments;
      print('resOption name: ${resOption.resoptionsAlwaysAvailable}');
    } else {
      print('failed to recieve resOption to display');
    }
    isService = myServices.getIsService() == 1 ? true : false;
    displayAvailableTime();
    super.onInit();
  }
}
