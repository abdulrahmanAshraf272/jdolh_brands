//import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  //Any thing want to be init when the app open but it in this function.
  Future<MyServices> init() async {
    //await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
    //locationPermissionRequest();
    return this;
  }

  setBrandstep(String step) {
    sharedPreferences.setString("brandstep", step);
  }

  int getBrandstep() {
    int brandstep = int.parse(sharedPreferences.getString("brandstep") ?? '0');
    return brandstep;
  }

  setBchstep(String step) {
    sharedPreferences.setString("bchstep", step);
  }

  int getBchstep() {
    int brandstep = int.parse(sharedPreferences.getString("bchstep") ?? '0');
    return brandstep;
  }

  setBrandid(String id) {
    sharedPreferences.setString("brandid", id);
  }

  String getBrandid() {
    String brandid = sharedPreferences.getString("brandid") ?? '0';
    return brandid;
  }

  setBchid(String id) {
    sharedPreferences.setString("bchid", id);
  }

  String getBchid() {
    String bchid = sharedPreferences.getString("bchid") ?? '0';
    return bchid;
  }

  setIsService(int isService) {
    sharedPreferences.setInt("isService", isService);
  }

  int getIsService() {
    int isService = sharedPreferences.getInt("isService") ?? 0;
    return isService;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
