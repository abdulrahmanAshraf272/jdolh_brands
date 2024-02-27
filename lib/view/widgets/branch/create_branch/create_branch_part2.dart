import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/branch/create_branch_controller.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/select_payment_method.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/select_policy.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';

class CreateBranchPart2 extends StatelessWidget {
  const CreateBranchPart2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBranchController());
    return SingleChildScrollView(
      child: Column(
        children: [
          NumberTextFieldWithTitleAndText(
            textEditingController: controller.resCost,
            title: 'رسوم الحجز',
            endText: 'ريال',
            comment:
                'ملاحظة: سوف يقوم تطبيق جدولة بخصم (10 ريال) او 15% من رسوم الحجز بالإضافة الى تكاليف رسوم دفع الحجز على كل عملية',
          ),
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'سياسة الحجز'),
          const SizedBox(height: 10),
          SelectPolicy(),
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'طرق الدفع'),
          const SizedBox(height: 15),
          SelectPaymentMethod(),
          const SizedBox(height: 20),
          const CustomSmallBoldTitle(title: 'معلومات اضافية'),
          const SizedBox(height: 10),
          //TODO: make the field bigger and limited in letters.
          CustomTextField(
              textEditingController: controller.branchName,
              hintText: 'يمكنك اضافة ملاحظة او تنبيه للعميل قبل الحجز'),
          NumberTextFieldWithTitleAndText(
            textEditingController: controller.resSuspensionLimitTime,
            title: "تعليق الحجز",
            endText: 'دقيقة',
            comment:
                'الوقت المتاح للعميل لتعليق الحجز الى ان يتم دفع الرسوم وتأكيد الحجز',
          ),
          // NumberTextFieldWithTitleAndText(
          //   textEditingController: controller.resSuspensionLimitTime,
          //   title: 'العدد المتاح',
          //   endText: 'اشخاص',
          //   comment: 'العدد الاقصى للاشخاص الذي يمكن تواجدهم في نفس الوقت',
          // ),
        ],
      ),
    );
  }
}
