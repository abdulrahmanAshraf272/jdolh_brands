import 'package:flutter/material.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';

class ListIsEmptyTextGeneral extends StatelessWidget {
  final String text;
  final String example;
  const ListIsEmptyTextGeneral(
      {super.key, required this.text, this.example = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: '$text\n',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                example != ''
                    ? TextSpan(
                        text: example,
                        style: TextStyle(
                            color: AppColors.black.withOpacity(0.4),
                            fontSize: 14,
                            fontFamily: 'Cairo'))
                    : TextSpan()
              ])),
        ],
      ),
    );
  }
}
