import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';
import 'package:jdolh_brands/view/widgets/common/flexable_toggle_button.dart';

class SelectPolicy extends StatefulWidget {
  const SelectPolicy({super.key});

  @override
  State<SelectPolicy> createState() => _SelectPolicyState();
}

class _SelectPolicyState extends State<SelectPolicy> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBranchController());
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        itemCount: controller.resPolicies.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                controller.policySelected = controller.resPolicies[index];
                print(controller.policySelected);
              });
            },
            child: ToggleButtonItem(
              index: index,
              selectedIndex: selectedIndex,
              text: controller.resPolicies[index],
              fontSize: 13,
            )));
  }
}
