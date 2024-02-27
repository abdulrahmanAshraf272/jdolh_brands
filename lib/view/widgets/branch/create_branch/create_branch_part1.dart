import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';

import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/data_or_location_display_container.dart';

class CreateBranchPart1 extends StatelessWidget {
  const CreateBranchPart1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBranchController());
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'صورة من الفرع'),
          const SizedBox(height: 10),
          BranchImage(),
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'اسم الفرع'),
          const SizedBox(height: 10),
          CustomTextField(
              textEditingController: controller.branchName,
              hintText: 'مثال: الرياض, جدة, حي السلامة .'),
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'اسم مدير الفرع'),
          const SizedBox(height: 10),
          CustomTextField(
              textEditingController: controller.branchManagerName,
              hintText: 'ادخل اسم مدير الفرع'),
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'الموقع'),
          DateOrLocationDisplayContainer(
              hintText: 'حدد موقع المناسبة',
              iconData: Icons.place,
              onTap: () {}),
          const SizedBox(height: 10),
          const CustomSmallBoldTitle(title: 'رابط الموقع'),
          const SizedBox(height: 10),
          CustomTextField(
              textEditingController: controller.branchLocationLink,
              hintText: 'اضف رابط الموقع من خرائط جوجل'),
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'وصف الفرع'),
          const SizedBox(height: 10),
          //TODO: make the field larger
          //TODO: make limit the the desc and show the amount of letters valid.
          CustomTextField(
              textEditingController: controller.branchDesc,
              hintText: 'اضف وصف للفرع'),
          //TODO: add branch image
        ],
      ),
    );
  }
}

class BranchImage extends StatelessWidget {
  const BranchImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBranchController());
    return Stack(
      children: [
        controller.imageSelected != null
            ? CircleAvatar(
                radius: 55,
                backgroundImage: MemoryImage(controller.imageSelected!),
              )
            : Container(
                height: 150.h,
                width: 260.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/placeholder.png',
                        ),
                        fit: BoxFit.cover)),
              ),
        Positioned(
            bottom: -10,
            right: -10,
            child: IconButton(
                onPressed: controller.selectImage,
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.black87,
                )))
      ],
    );
  }
}
