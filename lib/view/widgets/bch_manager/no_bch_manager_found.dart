import 'package:flutter/material.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';

class NoBchManagerFound extends StatelessWidget {
  final void Function() onTapAddManager;
  const NoBchManagerFound({
    super.key,
    required this.onTapAddManager,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '''مدير الفرع هو شخص تعطيه الصلاحية الكاملة للتحكم في الفرع بعد اعطائه اسم المستخدم وكلمة السر فور انشائها,
           ويمكنك ايقاف صلاحياته مؤقتاً, او حذفه نهائياً.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.black.withOpacity(0.7),
                  fontSize: 14,
                  fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 15),
            GoHomeButton(
              onTap: onTapAddManager,
              text: 'إضافة مدير',
            )
          ],
        ),
      ),
    );
  }
}
