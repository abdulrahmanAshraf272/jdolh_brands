import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class SuccessOperation extends StatefulWidget {
  const SuccessOperation({super.key});

  @override
  State<SuccessOperation> createState() => _SuccessOperationState();
}

class _SuccessOperationState extends State<SuccessOperation> {
  int resetPasswordOperation = 0;
  String title = '';
  @override
  void initState() {
    resetPasswordOperation = Get.arguments['resetPassword'];
    if (resetPasswordOperation == 1) {
      title = 'تم عملية تغيير كلمة السر بنجاح';
    } else {
      title = 'تم عملية انشاء الحساب بنجاح';
    }
    super.initState();
  }

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
            Text(title,
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.5))),
            const Spacer(),
            CustomButtonOne(
                textButton: 'ابدأ',
                onPressed: () {
                  if (resetPasswordOperation == 1) {
                    Get.offAllNamed(AppRouteName.login);
                  } else {
                    Get.offAllNamed(AppRouteName.createBrand,
                        arguments: {'afterSignup': true});
                  }
                })
          ],
        ),
      ),
    );
  }
}
