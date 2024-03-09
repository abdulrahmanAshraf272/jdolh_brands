import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/create_item_controller.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/data/models/item_option.dart';

class AdditionalItemOptionsController extends GetxController {
  CreateItemsController createItemsController =
      Get.put(CreateItemsController());
  List<ItemOption> itemOptions = [];

  onTapAddOption() async {
    final result = await Get.toNamed(AppRouteName.addItemOptions);
    if (result != null) {
      itemOptions.add(result);
      createItemsController.addedItemOptions.add(result);
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    itemOptions = List.from(createItemsController.addedItemOptions);
    itemOptions.removeWhere((element) => element.priceDep == 1);
  }
}
