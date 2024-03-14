import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class CustomTextDisplayGeneral extends StatelessWidget {
  final Widget? suffixIcon;
  final String text;
  final double? height;

  final bool withPhoneKey;

  const CustomTextDisplayGeneral(
      {super.key,
      required this.text,
      this.suffixIcon,
      this.height,
      this.withPhoneKey = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: AppColors.gray,
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          )),
          withPhoneKey
              ? Text(
                  '966+ ',
                  style: titleMedium,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
