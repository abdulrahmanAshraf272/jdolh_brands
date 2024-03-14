import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/display_item_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_text_display_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_display.dart';

class DisplayItemScreen extends StatelessWidget {
  const DisplayItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayItemController());
    return GetBuilder<DisplayItemController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: controller.item.itemsTitle ?? ''),
              body: HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomSmallBoldTitle(
                          title: 'صورة ${controller.itemText}'),
                      const SizedBox(height: 10),
                      RectImageDisplay(
                        image: controller.item.itemsImage,
                      ),
                      const SizedBox(height: 20),
                      CustomSmallBoldTitle(title: 'اسم ${controller.itemText}'),
                      CustomTextDisplayGeneral(
                        text: controller.item.itemsTitle ?? '',
                      ),
                      CustomSmallBoldTitle(title: 'وصف ${controller.itemText}'),
                      CustomTextDisplayGeneral(
                        text: controller.item.itemsDesc ?? '',
                      ),
                      CustomSmallBoldTitle(
                          title: 'تصنيف ${controller.itemText}'),
                      CustomTextDisplayGeneral(
                        text: controller.categories.title ?? '',
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
