import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/items_controller.dart';
import 'package:jdolh_brands/controller/resOptions/res_options_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';

class ResOptionsScreen extends StatelessWidget {
  final bool withArrowBack;
  const ResOptionsScreen({super.key, this.withArrowBack = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResOptionsController());

    return GetBuilder<ResOptionsController>(
        builder: (controller) => Scaffold(
              appBar: appBarWithButtonCreate(
                  onTapCreate: () {
                    controller.goToAddResOption();
                  },
                  withArrowBack: withArrowBack,
                  title: 'التفضيلات',
                  buttonText: 'انشاء تفضيل'),
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.resOptions.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.resOptions.length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) => CustomCardOne(
                                  text: controller
                                      .resOptions[index].resoptionsTitle!,
                                  onTap: () {}))
                          : Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'لا يوجد لديك اي تفضيلات!\n',
                                      style: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo'),
                                    ),
                                    TextSpan(
                                        text: 'اضف اول تفضيل للفرع',
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
