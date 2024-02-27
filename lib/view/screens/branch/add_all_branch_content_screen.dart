import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/add_all_branch_content_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/screens/categories_screen.dart';
import 'package:jdolh_brands/view/screens/items/items_screen.dart';
import 'package:jdolh_brands/view/screens/resOptions/res_options_screen.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AddAllBranchContent extends StatelessWidget {
  const AddAllBranchContent({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddAllBranchContentController());
    return GetBuilder<AddAllBranchContentController>(
        builder: (controller) => Scaffold(
              bottomNavigationBar: CustomBottomAppBarAddAllBranchContent(),
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
                        CategoriesScreen(withArrowBack: false),
                        ResOptionsScreen(withArrowBack: false),
                        ItemsScreen(withArrowback: false),
                        AddAllBranchContentSuccess()
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
            ));
  }
}

class CustomBottomAppBarAddAllBranchContent extends StatelessWidget {
  const CustomBottomAppBarAddAllBranchContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddAllBranchContentController());
    return BottomAppBar(
        child: controller.currentPage >= controller.pagesNumber - 2
            ? SizedBox()
            : Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: controller.onTapBack,
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          Text('السابق'),
                        ],
                      )),
                  Spacer(),
                  Container(
                    child: GoHomeButton(
                      width: 120.w,
                      onTap: controller.onTapNext,
                      withArrowForwardIcon: true,
                      text: 'التالي',
                    ),
                  ),
                ],
              ));
  }
}

class AddAllBranchContentSuccess extends StatelessWidget {
  const AddAllBranchContentSuccess({super.key});

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
          Text('تمت اضافة محتويات الفرق بنجاح',
              style: TextStyle(
                  fontSize: 16, color: Colors.black.withOpacity(0.5))),
          const Spacer(),
          CustomButtonOne(
              textButton: 'الصفحة الرئيسية',
              onPressed: () {
                Get.offAllNamed(AppRouteName.mainScreen);
              })
        ],
      ),
    );
  }
}
