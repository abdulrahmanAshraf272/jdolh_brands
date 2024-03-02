import 'package:flutter/material.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';

class CustomTextFormGeneral extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;
  final String? Function(String?) valid;
  final TextInputType? textInputType;
  const CustomTextFormGeneral({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.valid,
    this.textInputType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        color: AppColors.gray,
      ),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        validator: valid,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14),
            suffixIcon: suffixIcon),
      ),
    );
  }
}
