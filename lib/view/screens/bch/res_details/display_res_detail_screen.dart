import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/res_details/diplay_res_details_controller.dart';
import 'package:jdolh_brands/controller/res_details/add_edit_res_details_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/branch/number_display.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_text_display_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';

class DisplayResDetailsScreen extends StatelessWidget {
  const DisplayResDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayResDetailsController());
    return Scaffold(
        appBar: appBarWithButtonCreate(
            onTapCreate: () => controller.onTapEdit(),
            title: 'تفاصيل الحجز',
            buttonText: 'تعديل'),
        body: GetBuilder<DisplayResDetailsController>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: SingleChildScrollView(
                    child: Column(
                      children: [
                        NumberDisplayWithTitleAndText(
                          text: controller.cost,
                          title: 'تكلفة الحجز',
                          endText: 'ريال',
                        ),
                        //Set If it is Product only
                        controller.isService
                            ? const SizedBox()
                            : NumberDisplayWithTitleAndText(
                                text: controller.invitorMax,
                                title: 'العدد الاقصى للمدعوين',
                                endText: 'اشخاص',
                              ),
                        //Set If it is Product only
                        controller.isService
                            ? const SizedBox()
                            : NumberDisplayWithTitleAndText(
                                text: controller.invitorMin,
                                title: 'العدد الادنى للمدعوين',
                                endText: 'اشخاص',
                              ),
                        //Set If it is Product only
                        controller.isService
                            ? const SizedBox()
                            : NumberDisplayWithTitleAndText(
                                text: controller.suspensionTime,
                                title: 'الوقت الاقصى لتعليق الحجز',
                                endText: 'دقيقة',
                              ),
                        const CustomSmallBoldTitle(title: 'معلومات وارشادات'),
                        const SizedBox(height: 10),
                        CustomTextDisplayGeneral(
                          text: controller.info,
                          //height: 100.h,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )));
  }
}
