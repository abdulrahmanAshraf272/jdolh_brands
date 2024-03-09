import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/bch_details_controller.dart';
import 'package:jdolh_brands/controller/more_controller.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/view/widgets/cart_with_checkbox.dart';
import 'package:jdolh_brands/view/widgets/container_with_circular_progress.dart';

class BchDetailsScreen extends StatelessWidget {
  const BchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BchDetailsController());
    return Scaffold(
      body: GetBuilder<BchDetailsController>(
        builder: (controller) => SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              TopContainer(
                donePercent: controller.donePercent,
                title: 'للبدأ في رحلتك التجارية, لابد من اكمال بيانات الفرع',
              ),
              const SizedBox(height: 20),
              CardWithCheckbox(
                title: 'البيانات الاساسية',
                onTapCard: () {
                  controller.trySomething();
                },
                isDone: controller.bchstep > 0,
                isActive: controller.bchstep > 0,
              ),
              CardWithCheckbox(
                title: 'أوقات العمل',
                onTapCard: () => controller.goto(AppRouteName.addWorktime),
                isDone: controller.bchstep > 1,
                isActive: controller.bchstep > 0,
              ),
              CardWithCheckbox(
                title: 'سياسة الحجز والفاتورة',
                onTapCard: () => controller.goto(AppRouteName.addPolicy),
                isDone: controller.bchstep > 2,
                isActive: controller.bchstep > 1,
              ),
              CardWithCheckbox(
                title: 'طرق الدفع',
                onTapCard: () => controller.goto(AppRouteName.addPaymentMethod),
                isDone: controller.bchstep > 3,
                isActive: controller.bchstep > 2,
              ),
              CardWithCheckbox(
                title: 'الأصناف',
                onTapCard: () => controller.goto(AppRouteName.categories),
                isDone: controller.bchstep > 4,
                isActive: controller.bchstep > 3,
              ),
              CardWithCheckbox(
                title: 'التفضيلات',
                onTapCard: () => controller.goto(AppRouteName.resOptions),
                isDone: controller.bchstep > 5,
                isActive: controller.bchstep > 4,
              ),
              CardWithCheckbox(
                title: controller.itemText,
                onTapCard: () => controller.goto(AppRouteName.items),
                isDone: controller.bchstep > 6,
                isActive: controller.bchstep > 5,
              ),
              CardWithCheckbox(
                title: 'مدير الفرع (اختياري)',
                onTapCard: () => controller.goto(AppRouteName.bchManager),
                isDone: controller.bchstep > 7,
                isActive: controller.bchstep > 6,
              ),
              const SizedBox(height: 20)
            ],
          ),
        )),
      ),
    );
  }
}
