import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';

class CustomBottomAppBarCreateBranch extends StatelessWidget {
  const CustomBottomAppBarCreateBranch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBranchController());
    return BottomAppBar(
        child: controller.currentPage >= controller.pagesNumber - 2
            ? SizedBox()
            : Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: controller.onTapBack,
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          Text('السابق'),
                        ],
                      )),
                  Spacer(),
                  Container(
                    child: GoHomeButton(
                      width: 120.w,
                      onTap: controller.onTapNext,
                      withArrowForwardIcon: true,
                      text: 'التالي',
                    ),
                  ),
                ],
              ));
  }
}
