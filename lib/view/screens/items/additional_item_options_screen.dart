import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/additional_item_options_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/list_empty_text.dart';

class AdditionalItemOptionsScreen extends StatelessWidget {
  const AdditionalItemOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdditionalItemOptionsController());
    return Scaffold(
      appBar: customAppBar(title: 'الخيارات الإضافية'),
      body: GetBuilder<AdditionalItemOptionsController>(
        builder: (controller) => Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: controller.itemOptions.isNotEmpty
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.itemOptions.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) => CustomCardOne(
                          text: controller.itemOptions[index].title!,
                          onTap: () {}))
                  : ListIsEmptyTextGeneral(text: 'لا يوجد خيارات اضافية'),
            ),
            GoHomeButton(
                onTap: () {
                  controller.onTapAddOption();
                },
                text: 'اضافة'),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
