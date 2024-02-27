import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/home_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              appBar: appBarWithButtonCreate(
                  onTapCreate: () {
                    Get.toNamed(AppRouteName.createBranch);
                  },
                  withArrowBack: false,
                  title: 'الفروع',
                  buttonText: 'انشاء فرع'),
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.branches.isNotEmpty
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
                                      text: 'لا يوجد لديك اي فروع!\n',
                                      style: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo'),
                                    ),
                                    TextSpan(
                                        text: 'اضف اول فرع لك',
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
