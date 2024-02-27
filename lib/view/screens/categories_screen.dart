import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/categories_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';

class CategoriesScreen extends StatelessWidget {
  final bool withArrowBack;
  const CategoriesScreen({super.key, this.withArrowBack = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());

    return GetBuilder<CategoriesController>(
        builder: (controller) => Scaffold(
              appBar:
                  customAppBar(title: 'الاصناف', withArrowBack: withArrowBack),
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.categories.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) => Container())
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              'اضف الاصناف التي سوف تعرض في القائمة\n',
                                          style: TextStyle(
                                              color: AppColors.black
                                                  .withOpacity(0.7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo'),
                                        ),
                                        TextSpan(
                                            text: 'مثال: مشويات , وجبات',
                                            style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.4),
                                                fontSize: 14,
                                                fontFamily: 'Cairo'))
                                      ])),
                                  SizedBox(height: 10),
                                  GoHomeButton(
                                      onTap: () {
                                        controller.onTapAddCategory();
                                      },
                                      text: 'أضافة',
                                      height: 40,
                                      width: 100),
                                  // CustomButton(
                                  //     onTap: () {
                                  //       controller.onTapAddCategory();
                                  //     },
                                  //     text: ' أضف ')
                                ],
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ));
  }
}
