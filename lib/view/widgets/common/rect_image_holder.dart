import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RectImageHolder extends StatelessWidget {
  final Function() onTap;
  final Uint8List? selectedImage;
  const RectImageHolder(
      {super.key, required this.onTap, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    fit: BoxFit.cover, image: MemoryImage(selectedImage!))),
      ),
    );
  }
}
