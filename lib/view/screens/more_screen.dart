import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/more_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/alert_exit_app.dart';
import 'package:jdolh_brands/view/widgets/cart_with_checkbox.dart';
import 'package:jdolh_brands/view/widgets/container_with_circular_progress.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MoreController());
    return WillPopScope(
      onWillPop: alertExitApp,
      child: Scaffold(
        body: GetBuilder<MoreController>(
          builder: (controller) => SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                TopContainer(
                  donePercent: controller.donePercent,
                  title: controller.donePercent < 100
                      ? 'للبدأ في رحلتك التجارية, لابد من اكمال بياناتك'
                      : 'تهانيا لقد اكملت بياناتك بنجاح',
                ),
                const SizedBox(height: 20),
                CardWithCheckbox(
                  title: 'البيانات الشخصية',
                  onTapCard: () {},
                  isDone: controller.brandstep > 0,
                  isActive: controller.brandstep > 0,
                ),
                if (controller.isBrandManager)
                  Column(
                    children: [
                      CardWithCheckbox(
                        title: 'البيانات التجارية',
                        onTapCard: () =>
                            controller.goto(AppRouteName.createBrand),
                        isDone: controller.brandstep > 1,
                        isActive: controller.brandstep > 0,
                      ),
                      CardWithCheckbox(
                        title: 'البيانات القانونية',
                        onTapCard: () =>
                            controller.goto(AppRouteName.createLegaldata),
                        isDone: controller.brandstep > 2,
                        isActive: controller.brandstep > 1,
                      ),
                      controller.donePercent == 100
                          ? const SizedBox()
                          : CardWithCheckbox(
                              title: 'انشاء فرع',
                              onTapCard: () {
                                controller.goto(AppRouteName.createBch);
                              },
                              isDone: controller.brandstep > 3,
                              isActive: controller.brandstep > 2,
                            ),
                    ],
                  ),
                const SizedBox(height: 30),
                TextButton(
                    onPressed: () => controller.logout(),
                    child: Text(
                      'تسجيل خروج',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.redButton,
                      ),
                    ))
              ],
            ),
          )),
        ),
      ),
    );
  }
}
