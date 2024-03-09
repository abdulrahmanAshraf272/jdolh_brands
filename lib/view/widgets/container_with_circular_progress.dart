import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class TopContainer extends StatelessWidget {
  final int donePercent;
  final String title;
  const TopContainer(
      {super.key, required this.donePercent, required this.title});

  @override
  Widget build(BuildContext context) {
    double indicatorRadius = 60.w;
    return Container(
      height: Get.height * 0.25,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:
            AppColors.primaryColor, // Set the background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Set the shadow color
            spreadRadius: 5, // Set the spread radius of the shadow
            blurRadius: 7, // Set the blur radius of the shadow
            offset: Offset(0, 3), // Set the offset of the shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          )),
          Container(
            height: 120.w,
            width: 120.w,
            child: Stack(children: [
              Positioned.fill(
                child: CircularPercentIndicator(
                  arcType: ArcType.FULL,
                  startAngle: 240,
                  radius: indicatorRadius,
                  lineWidth: 9.w,
                  percent: 1,
                  progressColor: Color(0xFF737d74),
                  backgroundColor: Color(0xFF6f7b6f),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
              Positioned.fill(
                child: CircularPercentIndicator(
                  arcType: ArcType.FULL,
                  curve: Curves.ease,
                  startAngle: 240,
                  animationDuration: 2000,
                  animation: true,
                  radius: indicatorRadius,
                  lineWidth: 9.w,
                  animateFromLastPercent: true,
                  percent: donePercent / 100,
                  progressColor: Color(0xFFffc13d),
                  backgroundColor: Color(0xFF6f7b6f),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: NumberCountAnimation(
                    endValue: donePercent,
                    duration: Duration(seconds: 2),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      // Other properties of the container...
    );
  }
}

class NumberCountAnimation extends StatefulWidget {
  final int endValue;
  final Duration duration;

  NumberCountAnimation(
      {required this.endValue, required this.duration, Key? key})
      : super(key: key);

  @override
  _NumberCountAnimationState createState() => _NumberCountAnimationState();
}

class _NumberCountAnimationState extends State<NumberCountAnimation> {
  late Key key; // Store a key to be used for rebuilding the animation

  @override
  void initState() {
    super.initState();
    key = UniqueKey(); // Generate a unique key for the initial build
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: key, // Use the key to force the rebuild
      tween: IntTween(begin: 0, end: widget.endValue),
      duration: widget.duration,
      builder: (context, int value, child) {
        return Text(
          "$value%",
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFFfcfffa)),
          maxLines: 1,
        );
      },
    );
  }
}
