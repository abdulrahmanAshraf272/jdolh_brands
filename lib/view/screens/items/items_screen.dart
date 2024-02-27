import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/items_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';

class ItemsScreen extends StatelessWidget {
  final bool withArrowback;
  const ItemsScreen({super.key, this.withArrowback = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemsController());

    return GetBuilder<ItemsController>(
        builder: (controller) => Scaffold(
              appBar: appBarWithButtonCreate(
                  onTapCreate: () {
                    Get.toNamed(AppRouteName.createItems);
                  },
                  withArrowBack: withArrowback,
                  title: 'العناصر',
                  buttonText: 'انشاء عنصر'),
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.items.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) => Container())
                          : Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'لا يوجد لديك اي عناصر!\n',
                                      style: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo'),
                                    ),
                                    TextSpan(
                                        text: 'اضف اول عنصر في القائمة',
                                        style: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontSize: 14,
                                            fontFamily: 'Cairo'))
                                  ])),
                            ),
                    ),
                  )
                ],
              ),
            ));
  }
}
