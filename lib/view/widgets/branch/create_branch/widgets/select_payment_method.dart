import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBranchController());
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        itemCount: controller.paymentMethod.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              //width: 100,
              height: 40,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index == 2
                    ? Colors.grey.shade400
                    : AppColors.secondaryColor,
              ),
              child: Text(
                controller.paymentMethod[index],
                style: titleMediumWhite,
              ),
            )));
  }
}
