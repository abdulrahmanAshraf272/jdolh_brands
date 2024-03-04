import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';

class CreateBranchPart3 extends StatelessWidget {
  const CreateBranchPart3({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBranchController());
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'اوقات عمل الفرع'),
          const SizedBox(height: 10),
          DayWorkTimePicker(
            day: 'السبت',
            onTapFromP1: () {
              controller.setTime(context);
            },
            onTapToP1: () {},
            timeFromP1:
                controller.displayTime(controller.satTimeFromP1, context),
            timeToP1: '4:00 pm',
            onTapFromP2: () {},
            onTapToP2: () {},
            timeFromP2: '2:00 am',
            timeToP2: '4:00 pm',
            onTapCheckbox: () {},
          ),
          DayWorkTimePicker(
            day: 'الاحد',
            onTapFromP1: () {},
            onTapToP1: () {},
            timeFromP1: '2:00 am',
            timeToP1: '4:00 pm',
            onTapFromP2: () {},
            onTapToP2: () {},
            timeFromP2: '2:00 am',
            timeToP2: '4:00 pm',
            onTapCheckbox: () {},
          ),
          DayWorkTimePicker(
            day: 'الاثنين',
            onTapFromP1: () {},
            onTapToP1: () {},
            timeFromP1: '2:00 am',
            timeToP1: '4:00 pm',
            onTapFromP2: () {},
            onTapToP2: () {},
            timeFromP2: '2:00 am',
            timeToP2: '4:00 pm',
            onTapCheckbox: () {},
          ),
          DayWorkTimePicker(
            day: 'الثلثاء',
            onTapFromP1: () {},
            onTapToP1: () {},
            timeFromP1: '2:00 am',
            timeToP1: '4:00 pm',
            onTapFromP2: () {},
            onTapToP2: () {},
            timeFromP2: '2:00 am',
            timeToP2: '4:00 pm',
            onTapCheckbox: () {},
          ),
          DayWorkTimePicker(
            day: 'الاربعاء',
            onTapFromP1: () {},
            onTapToP1: () {},
            timeFromP1: '2:00 am',
            timeToP1: '4:00 pm',
            onTapFromP2: () {},
            onTapToP2: () {},
            timeFromP2: '2:00 am',
            timeToP2: '4:00 pm',
            onTapCheckbox: () {},
          ),
          DayWorkTimePicker(
            day: 'الخميس',
            onTapFromP1: () {},
            onTapToP1: () {},
            timeFromP1: '2:00 am',
            timeToP1: '4:00 pm',
            onTapFromP2: () {},
            onTapToP2: () {},
            timeFromP2: '2:00 am',
            timeToP2: '4:00 pm',
            onTapCheckbox: () {},
          ),
          DayWorkTimePicker(
            day: 'الجمعة',
            onTapFromP1: () {},
            onTapToP1: () {},
            timeFromP1: '2:00 am',
            timeToP1: '4:00 pm',
            onTapFromP2: () {},
            onTapToP2: () {},
            timeFromP2: '2:00 am',
            timeToP2: '4:00 pm',
            onTapCheckbox: () {},
          ),
        ],
      ),
    );
  }
}
