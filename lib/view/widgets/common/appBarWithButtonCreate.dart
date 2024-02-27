import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';

AppBar appBarWithButtonCreate(
    {required void Function() onTapCreate,
    bool withArrowBack = true,
    required String title,
    required String buttonText}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColors.white,
      ),
    ),
    leading: withArrowBack
        ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
          )
        : null,
    actions: [
      Padding(
        padding: const EdgeInsets.all(9.0),
        child: CustomButton(onTap: onTapCreate, text: buttonText),
      )
    ],
  );
}
