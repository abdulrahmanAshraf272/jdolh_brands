import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class SuccessOperation extends StatelessWidget {
  const SuccessOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Text('تمت العملية بنجاح',
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.5))),
            const Spacer(),
            CustomButtonOne(
                textButton: 'ابدأ',
                onPressed: () {
                  Get.offAllNamed(AppRouteName.mainScreen);
                })
          ],
        ),
      ),
    );
  }
}