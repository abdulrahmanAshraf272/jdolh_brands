import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class CustomTextFormGeneral extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;
  final String? Function(String?)? valid;
  final TextInputType? textInputType;
  final double? height;
  final int maxLines;
  final int? maxLength;
  final bool withPhoneKey;

  const CustomTextFormGeneral(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      this.valid,
      this.textInputType,
      this.suffixIcon,
      this.height,
      this.maxLength,
      this.maxLines = 1,
      this.withPhoneKey = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: AppColors.gray,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              keyboardType: textInputType,
              maxLines: maxLines,
              maxLength: maxLength,
              validator: valid,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(fontSize: 14),
                  suffixIcon: suffixIcon),
            ),
          ),
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
