import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class NumberTextFieldWithTitleAndText extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;
  final String endText;
  final String comment;
  final String example;
  const NumberTextFieldWithTitleAndText(
      {super.key,
      required this.textEditingController,
      required this.title,
      required this.endText,
      this.comment = '',
      this.example = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                    // contentPadding: const EdgeInsets.symmetric(
                    //     vertical: 5, horizontal: 30),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                endText,
                style: titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: titleSmallGray,
          ),
          Text(
            example,
            style: titleSmallGray,
          ),
        ],
      ),
    );
  }
}
