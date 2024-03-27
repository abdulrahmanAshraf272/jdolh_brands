import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class NumberDisplayWithTitleAndText extends StatelessWidget {
  final String text;
  final String title;
  final String endText;
  final String? comment;
  final String? example;
  final void Function()? onTapTextButton;
  final String textButtonTitle;
  final double horizontalPadding;
  final double verticalPadding;
  final String hintText;
  const NumberDisplayWithTitleAndText(
      {super.key,
      required this.text,
      required this.title,
      required this.endText,
      this.comment,
      this.example,
      this.onTapTextButton,
      this.textButtonTitle = '',
      this.horizontalPadding = 20,
      this.verticalPadding = 20,
      this.hintText = '0'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: AutoSizeText(
                  maxLines: 2,
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                  height: 45,
                  width: 100,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                    color: AppColors.gray,
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )),
              Text(
                endText,
                style: titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 10),
          comment != null
              ? Text(
                  comment!,
                  style: titleSmallGray,
                )
              : const SizedBox(),
          example != null
              ? Text(
                  example!,
                  style: titleSmallGray,
                )
              : const SizedBox(),
          onTapTextButton != null
              ? TextButton(
                  onPressed: onTapTextButton,
                  child: Text(textButtonTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                        color: AppColors.textDark,
                      )))
              : const SizedBox()
        ],
      ),
    );
  }
}
