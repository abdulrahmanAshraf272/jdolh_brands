import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/all_bchs_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/list_empty_text.dart';

class AllBchsScreen extends StatelessWidget {
  const AllBchsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllBchsController());
    return Scaffold(
      appBar: appBarWithButtonCreate(
          withArrowBack: false,
          onTapCreate: () {
            controller.onTapCreateBch();
          },
          title: 'الفروع',
          buttonText: 'انشاء فرع'),
      body: GetBuilder<AllBchsController>(
        builder: (controller) => Column(
          children: [
            HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Expanded(
                child: controller.bchs.isNotEmpty
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.bchs.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) => CustomCardOne(
                            text: controller.bchs[index].bchBranchName!,
                            onTap: () {
                              controller.goToBchDetails(index);
                            }))
                    : ListIsEmptyTextGeneral(
                        text: 'لا يوجد فروع',
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
