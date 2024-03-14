import 'package:get/get.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/models/Item.dart';
import 'package:jdolh_brands/data/models/categories.dart';
import 'package:jdolh_brands/data/models/item_option.dart';
import 'package:jdolh_brands/data/models/resOption.dart';

class DisplayItemController extends GetxController {
  bool isService = false;
  late String itemText;
  late Item item;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;
  ItemsData itemsData = ItemsData(Get.find());

  List<ResOption> resOptions = [];
  List<ItemOption> itemOptions = [];
  late MyCategories categories;

  getItemDetails() async {
    var response = await itemsData.getItemDetails(
        resoptionIds: item.itemsResoptionsids ?? '',
        itemOptionsIds: item.itemsAddedOptions ?? '',
        categoryId: item.itemsCategoriesid.toString());
    statusRequest = handlingData(response);
    print('===== $statusRequest');
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        print('success');
        parseValues(response);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  parseValues(response) {
    List resOptionJson = response['resOptions'];
    List itemOptionsJson = response['itemOptions'];
    print(response['category']);
    categories = MyCategories.fromJson(response['category']);

    resOptions = resOptionJson.map((e) => ResOption.fromJson(e)).toList();
    itemOptions = itemOptionsJson.map((e) => ItemOption.fromJson(e)).toList();

    update();
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      item = Get.arguments;
    } else {
      print('failed to get the item');
    }
    getItemDetails();
    isService = myServices.getIsService() == 1 ? true : false;
    isService ? itemText = 'الحجز' : itemText = 'المنتج';
    super.onInit();
  }
}
