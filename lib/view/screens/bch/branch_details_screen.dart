import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/branch_details_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';

class BranchDetailsScreen extends StatelessWidget {
  const BranchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BranchDetailsController());
    return GetBuilder<BranchDetailsController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'تفاصيل الفرع',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ),
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings, color: AppColors.white),
                  )
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SettingsButton(
                        text: 'الأصناف',
                        onTap: () {},
                        iconData: Icons.category),
                    SettingsButton(
                        text: 'تفضيلات الحجز',
                        onTap: () {},
                        iconData: Icons.select_all),
                    SettingsButton(
                        text: 'العناصر',
                        onTap: () {},
                        iconData: Icons.data_object),
                  ],
                ),
              ),
            ));
  }
}

class SettingsButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final IconData iconData;
  final bool cancelArrowForward;
  const SettingsButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.iconData,
      this.cancelArrowForward = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 45.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      iconData,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Expanded(
                      child: AutoSizeText(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                    ),
                  )),
                  !cancelArrowForward
                      ? Icon(
                          Icons.arrow_forward,
                          color: Colors.grey.shade500,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleWithButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const TitleWithButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.textDark,
            ),
          )),
          CustomButton(onTap: onTap, text: 'إضافة'),
        ],
      ),
    );
  }
}
