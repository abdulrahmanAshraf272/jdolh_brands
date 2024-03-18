import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class RectImageHolder extends StatelessWidget {
  final Function() onTap;
  final Uint8List? selectedImage;
  const RectImageHolder(
      {super.key, required this.onTap, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: Get.width / 1.8,
            width: Get.width - 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: selectedImage == null
                    ? const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/placeholder.png'))
                    : DecorationImage(
                        //fit: BoxFit.cover,
                        image: MemoryImage(selectedImage!))),
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

class RectImageHolderAndDispay extends StatelessWidget {
  final Function() onTap;
  final Uint8List? selectedImage;
  final String? imageInit;
  const RectImageHolderAndDispay(
      {super.key,
      required this.onTap,
      required this.selectedImage,
      required this.imageInit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
              height: Get.width / 1.8,
              width: Get.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: selectedImage == null
                      ? const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/placeholder.png'))
                      : DecorationImage(
                          //fit: BoxFit.cover,
                          image: MemoryImage(selectedImage!))),
              child: imageInit != null && selectedImage == null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading2.gif',
                      image: '${ApiLinks.itemsImage}/$imageInit',
                      // width: 100.w,
                      // height: 75,
                      fit: BoxFit.cover,
                    )
                  : null),
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
