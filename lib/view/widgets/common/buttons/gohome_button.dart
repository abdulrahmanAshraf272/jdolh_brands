import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class GoHomeButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final double width;
  final double height;
  final bool withArrowForwardIcon;
  const GoHomeButton(
      {super.key,
      required this.onTap,
      this.text = 'الرجوع للرئيسية',
      this.buttonColor = AppColors.secondaryColor,
      this.textColor = AppColors.white,
      this.width = 120,
      this.height = 44,
      this.withArrowForwardIcon = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: MaterialButton(
        onPressed: onTap,
        color: buttonColor,
        child: Container(
          height: height.h,
          width: width.w,
          alignment: Alignment.center,
          child: withArrowForwardIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        textAlign: TextAlign.center,
                        text,
                        style: titleMedium.copyWith(color: textColor),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ))
                  ],
                )
              : Text(
                  textAlign: TextAlign.center,
                  text,
                  style: titleMedium.copyWith(color: textColor),
                ),
        ),
      ),
    );
  }
}
