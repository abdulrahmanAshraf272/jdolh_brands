import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/screens/bch/add_worktime_screen.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';

class DayWorkTimePicker extends StatelessWidget {
  final String day;
  final void Function() onTapFromP1;
  final void Function() onTapToP1;
  final String timeFromP1;
  final String timeToP1;
  final void Function() onTapFromP2;
  final void Function() onTapToP2;
  final String timeFromP2;
  final String timeToP2;
  final Function() onTapCheckbox;
  const DayWorkTimePicker(
      {super.key,
      required this.day,
      required this.onTapFromP1,
      required this.onTapToP1,
      required this.timeFromP1,
      required this.timeToP1,
      required this.onTapFromP2,
      required this.onTapToP2,
      required this.timeFromP2,
      required this.timeToP2,
      required this.onTapCheckbox});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            SizedBox(width: 85.w),
            Spacer(),
            Text(
              day,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: AppColors.textDark,
              ),
            ),
            const Spacer(),
            CustomCheckbox(onTap: onTapCheckbox),
            const SizedBox(width: 20),
          ],
        ),
        const Divider(
          endIndent: 30,
          indent: 30,
        ),
        const CustomSmallTitle(title: 'الفترة الاولى', rightPdding: 30),
        FromToTimePicker(
            onTapFrom: onTapFromP1,
            onTapTo: onTapToP1,
            timeFrom: timeFromP1,
            timeTo: timeToP1),
        const SizedBox(height: 20),
        const CustomSmallTitle(
            title: 'الفترة الثانية (اختياري)', rightPdding: 30),
        FromToTimePicker(
            onTapFrom: onTapFromP2,
            onTapTo: onTapToP2,
            timeFrom: timeFromP2,
            timeTo: timeToP2),
        const SizedBox(height: 20)
      ],
    );
  }
}

class FromToTimePicker extends StatelessWidget {
  final void Function() onTapFrom;
  final void Function() onTapTo;
  final String timeFrom;
  final String timeTo;
  const FromToTimePicker({
    super.key,
    required this.onTapFrom,
    required this.onTapTo,
    required this.timeFrom,
    required this.timeTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 30),
        Text(
          'من',
          maxLines: 1,
          style: titleMedium,
        ),
        SmallTimePicker(onTap: onTapFrom, timeText: timeFrom),
        const SizedBox(width: 20),
        Text(
          'الى',
          maxLines: 1,
          style: titleMedium,
        ),
        SmallTimePicker(onTap: onTapTo, timeText: timeTo),
      ],
    );
  }
}

class SmallTimePicker extends StatelessWidget {
  final void Function() onTap;
  final String timeText;
  const SmallTimePicker({
    super.key,
    required this.onTap,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 75.w,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          //border: Border.all(color: Colors.black26),
          color: AppColors.gray,
        ),
        child: AutoSizeText(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          timeText,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
