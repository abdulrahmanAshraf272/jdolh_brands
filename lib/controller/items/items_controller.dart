import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/Item.dart';

class ItemsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  ItemsData itemsData = ItemsData(Get.find());
  MyServices myServices = Get.find();
  bool isService = false;

  String itemTextP = 'المنتجات';
  String itemTextS = 'منتج';

  List<Item> items = [];

  goToAddItem() {
    Get.toNamed(AppRouteName.createItems)!.then((value) => update());
  }

  getItems() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await itemsData.getItems(bchid: myServices.getBchid());
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

  parseValues(response) {
    items.clear();
    List data = response['data'];
    items = data.map((e) => Item.fromJson(e)).toList();
  }

  setItemText(bool isService) {
    if (isService) {
      itemTextP = 'الحجوزات';
      itemTextS = 'حجز';
    } else {
      itemTextP = 'المنتجات';
      itemTextS = 'منتج';
    }
  }

  @override
  void onInit() {
    isService = myServices.getIsService() == 1 ? true : false;
    setItemText(isService);
    getItems();
    super.onInit();
  }
}
