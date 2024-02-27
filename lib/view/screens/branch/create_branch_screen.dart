import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/create_branch_part1.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/create_branch_part2.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/create_branch_part3.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/custom_bottom_appbar_two.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/data_or_location_display_container.dart';
import 'package:jdolh_brands/view/widgets/common/flexable_toggle_button.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Future<bool> alerExitCreationProcess() {
  Get.defaultDialog(
      title: 'خروج',
      middleText: 'هل تريد الغاء عملية الإضافة',
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('نعم'),
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('الغاء'))
      ]);
  return Future.value(true);
}

class CreateBranchScreen extends StatelessWidget {
  const CreateBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateBranchController());
    return WillPopScope(
      onWillPop: alerExitCreationProcess,
      child: GetBuilder<CreateBranchController>(
          builder: (controller) => Scaffold(
                appBar: customAppBar(title: 'انشاء فرع'),
                bottomNavigationBar: CustomBottomAppBarCreateBranch(),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        onPageChanged: (int page) {
                          controller.currentPage = page;
                        },
                        children: [
                          CreateBranchPart1(),
                          CreateBranchPart2(),
                          CreateBranchPart3(),
                          CreateBranchPart4(),
                        ],
                      ),
                    ),
                    LinearPercentIndicator(
                        isRTL: true,
                        barRadius: const Radius.circular(5),
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        lineHeight: 6,
                        width: Get.width,
                        animation: true,
                        animateFromLastPercent: true,
                        percent: controller.progressBarPercent,
                        progressColor: AppColors.secondaryColor,
                        backgroundColor: Colors.white.withOpacity(0.1))
                  ],
                ),
              )),
    );
  }
}

class CreateBranchPart4 extends StatelessWidget {
  const CreateBranchPart4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
              child: Icon(Icons.check_circle_outline,
                  size: 150.w, color: AppColors.secondaryColor)),
          Text('تهانيا!', style: headline4),
          const SizedBox(height: 15),
          Text('تمت انشاء الفرق بنجاح',
              style: TextStyle(
                  fontSize: 16, color: Colors.black.withOpacity(0.5))),
          Text('اضغط التالي لاضافة محتويات الفرع ',
              style: TextStyle(
                  fontSize: 12, color: Colors.black.withOpacity(0.5))),
          const Spacer(),
          CustomButtonOne(
              textButton: 'التالي',
              onPressed: () {
                Get.offAllNamed(AppRouteName.mainScreen);
                Get.toNamed(AppRouteName.addAllBranchContent);
              })
        ],
      ),
    );
  }
}
