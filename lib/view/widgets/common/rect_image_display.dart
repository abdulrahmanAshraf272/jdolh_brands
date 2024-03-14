import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class RectImageDisplay extends StatelessWidget {
  final String? image;
  const RectImageDisplay({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.width / 1.8,
          width: Get.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: image != null
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading2.gif',
                  image: '${ApiLinks.itemsImage}/$image',
                  width: 100.w,
                  height: 75,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/noImageAvailable.jpg',
                  height: 75,
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(height: 8),
        Text(
          'حجم الصورة لا بتجاوز: 5M',
          style: titleSmallGray,
        )
      ],
    );
  }
}
