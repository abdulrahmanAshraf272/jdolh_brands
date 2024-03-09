import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';

class SmallToggleButtons extends StatefulWidget {
  final String optionOne;
  final String optionTwo;
  final Function() onTapOne;
  final Function() onTapTwo;
  final int initValue;
  const SmallToggleButtons(
      {super.key,
      required this.optionOne,
      required this.optionTwo,
      required this.onTapOne,
      required this.onTapTwo,
      this.initValue = 1});

  @override
  State<SmallToggleButtons> createState() => _SmallToggleButtonsState();
}

class _SmallToggleButtonsState extends State<SmallToggleButtons> {
  int selectedOption = 1;
  Color firstColor = AppColors.secondaryColor;
  Color secondColor = AppColors.gray400;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedOption = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.secondaryColor95),
      //width: 80.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              widget.onTapOne();
              setState(() {
                selectedOption = 1;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: selectedOption == 1 ? firstColor : null,
              ),
              alignment: Alignment.center,
              child: Text(
                widget.optionOne,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: selectedOption == 1
                      ? AppColors.white
                      : AppColors.grayText,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onTapTwo();
              setState(() {
                selectedOption = 2;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: selectedOption == 2 ? firstColor : null,
              ),
              child: Text(
                widget.optionTwo,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: selectedOption == 2
                      ? AppColors.white
                      : AppColors.grayText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
