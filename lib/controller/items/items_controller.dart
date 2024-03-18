import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/Item.dart';

class ItemsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  ItemsData itemsData = ItemsData(Get.find());
  MyServices myServices = Get.find();
  bool isService = false;

  String itemTextP = 'المنتجات';
  String itemTextS = 'منتج';

  List<Item> items = [];

  onTapCard(int index) async {
    final result =
        await Get.toNamed(AppRouteName.editItem, arguments: items[index]);
    if (result != null) {
      print('result is not null');
    } else {
      print('result is null');
    }
  }

  goToAddItem() async {
    final result = await Get.toNamed(AppRouteName.createItems);
    //Check if i create item ,added to the list to display.
    if (result != null) {
      print('========dsd');
      Item item = result as Item;
      items.add(item);
      update();
    }
  }

  getItems() async {
    var response = await itemsData.getItems(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseValues(response);
      } else {
        statusRequest = StatusRequest.failure;
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
