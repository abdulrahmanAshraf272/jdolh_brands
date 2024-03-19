import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/items_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/custom_card_with_delete.dart';

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
                    controller.goToAddItem();
                  },
                  withArrowBack: withArrowback,
                  title: controller.isService
                      ? 'ال$servicesPloral'
                      : 'ال$productsPloral',
                  buttonText: controller.isService
                      ? 'انشاء $services'
                      : 'انشاء $products'),
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.items.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.items.length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) =>
                                  CustomCardWithDelete(
                                    text: controller.items[index].itemsTitle!,
                                    onTap: () {
                                      controller.onTapCard(index);
                                    },
                                    onDelete: () =>
                                        controller.onTapDelete(index),
                                  ))
                          : Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: controller.isService
                                          ? 'لا يوجد لديك $servicesPloral'
                                          : 'لا يوجد لديك $productsPloral',
                                      style: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo'),
                                    ),
                                    TextSpan(
                                        text: controller.isService
                                            ? 'اضف اول $services في القائمة'
                                            : 'اضف اول $products في القائمة',
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
