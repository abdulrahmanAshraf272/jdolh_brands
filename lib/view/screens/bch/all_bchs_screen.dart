import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/all_bchs_controller.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/list_empty_text.dart';

class AllBchsScreen extends StatelessWidget {
  const AllBchsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AllBchsController());
    return Scaffold(
      appBar: customAppBar(title: 'الفروع'),
      body: GetBuilder<AllBchsController>(
        builder: (controller) => Column(
          children: [
            Expanded(
              child: controller.bchs.isNotEmpty
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.bchs.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) =>
                          CustomCardOne(text: 'sd', onTap: () {}))
                  : ListIsEmptyTextGeneral(
                      text: 'لا يوجد فروع',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
