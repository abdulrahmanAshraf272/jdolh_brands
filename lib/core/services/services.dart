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

  //====== is user is BrandManager ====//
  setIsBrandManager(bool isBrandManager) {
    sharedPreferences.setBool("isBrandManager", isBrandManager);
  }

  bool getIsBrandManager() {
    return sharedPreferences.getBool("isBrandManager") ?? true;
  }

  //  ====== Brand Manager id  if ,if exist ======//
  setBrandManagerid(String step) {
    sharedPreferences.setString("id", step);
  }

  String getBrandManagerId() {
    return sharedPreferences.getString("id") ?? '0';
  }

  //  ====== BchManager id  if ,if exist ======//
  setBchManagerid(String step) {
    sharedPreferences.setString("bchManagerid", step);
  }

  String getBchManagerId() {
    return sharedPreferences.getString("bchManagerid") ?? '0';
  }

  //===== Brand step ====//
  setBrandstep(String step) {
    sharedPreferences.setString("brandstep", step);
  }

  int getBrandstep() {
    int brandstep = int.parse(sharedPreferences.getString("brandstep") ?? '0');
    return brandstep;
  }

  //===== Bch step ====//
  setBchstep(String step) {
    sharedPreferences.setString("bchstep", step);
  }

  int getBchstep() {
    int brandstep = int.parse(sharedPreferences.getString("bchstep") ?? '0');
    return brandstep;
  }

//===== Brand id ====//
  setBrandid(String id) {
    sharedPreferences.setString("brandid", id);
  }

  String getBrandid() {
    String brandid = sharedPreferences.getString("brandid") ?? '0';
    return brandid;
  }

  //===== Bch id ====//
  setBchid(String id) {
    sharedPreferences.setString("bchid", id);
  }

  String getBchid() {
    String bchid = sharedPreferences.getString("bchid") ?? '0';
    return bchid;
  }

// ========== isService =======//
  setIsService(int isService) {
    sharedPreferences.setInt("isService", isService);
  }

  int getIsService() {
    int isService = sharedPreferences.getInt("isService") ?? 0;
    return isService;
  }

  clearSharedPrefsData() {
    setBchid('0');
    setBrandid('0');
    setBchstep('0');
    setBrandstep('0');
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
