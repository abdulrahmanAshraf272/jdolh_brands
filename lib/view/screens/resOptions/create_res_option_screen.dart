import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/resOptions/create_resOptions_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/select_available_time_in_days.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CreateResOptionsScreen extends StatelessWidget {
  const CreateResOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateResOptionsController());
    return GetBuilder<CreateResOptionsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'انشاء تفضيل'),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'عنوان التفضيل'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textEditingController: controller.title,
                        hintText: 'مثال: طاولات داخلية, طاولات خارجية ..'),
                    NumberTextFieldWithTitleAndText(
                      textEditingController: controller.countLimit,
                      title: "العدد المتاح",
                      endText: 'اشخاص',
                      comment: 'كم عدد الاشخاص الذي يمكن تواجدهم في نفس الوقت',
                    ),
                    AvailableTimeInWeek(),
                    const SizedBox(height: 20),
                    GoHomeButton(
                      onTap: () {},
                      text: 'حفظ',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ));
  }
}

class AvailableTimeInWeek extends StatelessWidget {
  const AvailableTimeInWeek({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CustomSmallBoldTitle(title: 'اوقات المتاحة'),
        const SizedBox(height: 10),
        DayWorkTimePicker(
          day: 'السبت',
          onTapFromP1: () {},
          onTapToP1: () {},
          timeFromP1: '',
          timeToP1: '4:00 pm',
          onTapFromP2: () {},
          onTapToP2: () {},
          timeFromP2: '2:00 am',
          timeToP2: '4:00 pm',
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
        ),
      ],
    );
  }
}

class CustomBottomAppBarCreateResOptions extends StatelessWidget {
  const CustomBottomAppBarCreateResOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateResOptionsController());
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
