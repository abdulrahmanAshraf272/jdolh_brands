import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/res_details/add_edit_res_details_controller.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/custom_textform_general.dart';
import 'package:jdolh_brands/view/widgets/number_textfield.dart';

class AddEditResDetailsScreen extends StatelessWidget {
  const AddEditResDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddEditResDetailsController());
    return Scaffold(
      appBar: customAppBar(title: 'تفاصيل الحجز'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NumberTextFieldWithTitleAndText(
              textEditingController: controller.cost,
              title: 'تكلفة الحجز',
              endText: 'ريال',
              comment: 'اذا تركت الحقل فارغ يعني انه بدون رسوم',
            ),
            //Set If it is Product only
            controller.isService
                ? const SizedBox()
                : NumberTextFieldWithTitleAndText(
                    textEditingController: controller.invitorMax,
                    title: 'العدد الاقصى للمدعوين',
                    endText: 'اشخاص',
                    hintText: '∞',
                  ),
            //Set If it is Product only
            controller.isService
                ? const SizedBox()
                : NumberTextFieldWithTitleAndText(
                    textEditingController: controller.invitorMin,
                    title: 'العدد الادنى للمدعوين',
                    endText: 'اشخاص',
                  ),
            controller.isService
                ? const SizedBox()
                : NumberTextFieldWithTitleAndText(
                    textEditingController: controller.suspensionTime,
                    title: 'الوقت الاقصى لتعليق الحجز',
                    endText: 'دقيقة',
                    comment:
                        'يمكن للزبون تعليق الحجز لمدة محددة حتى يقوم بتأكيد الحجز'),
            const CustomSmallBoldTitle(title: 'معلومات وارشادات'),
            const SizedBox(height: 10),
            CustomTextFormGeneral(
              hintText:
                  'ادخل اي معلومات او ارشادات يجب على الزبون معرفتها قبل اتمام عملية الحجز',
              textEditingController: controller.info,
              height: 100.h,
              maxLength: 100,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            GoHomeButton(
              onTap: () {
                controller.addResDetails(context);
              },
              text: 'حفظ',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
