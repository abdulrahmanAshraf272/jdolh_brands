import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class CustomCardWithDelete extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Function() onDelete;
  const CustomCardWithDelete(
      {super.key,
      required this.text,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Row(
                children: [
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
                  TextButton(
                      onPressed: onDelete,
                      child: Text(
                        'حذف',
                        style: titleSmall2.copyWith(color: Colors.red),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
