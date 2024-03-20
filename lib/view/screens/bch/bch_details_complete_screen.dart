import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/bch/bch_details_complete_controller.dart';
import 'package:jdolh_brands/controller/bch/bch_details_controller.dart';
import 'package:jdolh_brands/controller/more_controller.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/strings.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/view/widgets/cart_with_checkbox.dart';
import 'package:jdolh_brands/view/widgets/container_with_circular_progress.dart';

class BchDetailsCompleteScreen extends StatelessWidget {
  const BchDetailsCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BchDetailsCompleteController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          controller.bch.bchBranchName ?? '',
        ),
        centerTitle: true,
      ),
      body: GetBuilder<BchDetailsCompleteController>(
        builder: (controller) => SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              TopContainer(
                donePercent: 100,
                title: controller.headerMessage,
              ),
              const SizedBox(height: 20),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: 'البيانات الاساسية',
                onTapCard: () {},
              ),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: 'أوقات العمل',
                onTapCard: () {
                  Get.toNamed(AppRouteName.displayWorktime);
                },
              ),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: 'سياسة الحجز والفاتورة',
                onTapCard: () {
                  Get.toNamed(AppRouteName.displayPolicy);
                },
              ),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: 'طرق الدفع',
                onTapCard: () {
                  Get.toNamed(AppRouteName.displayPaymentMethods);
                },
              ),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: 'الأصناف',
                onTapCard: () {
                  Get.toNamed(AppRouteName.categories);
                },
              ),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: 'التفضيلات',
                onTapCard: () {
                  Get.toNamed(AppRouteName.resOptions);
                },
              ),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: controller.isService == 1
                    ? 'ال$servicesPloral'
                    : 'ال$productsPloral',
                onTapCard: () {
                  Get.toNamed(AppRouteName.items);
                },
              ),
              CardWithCheckbox(
                isDone: true,
                isActive: true,
                title: 'تفاصيل الحجز',
                onTapCard: () {
                  Get.toNamed(AppRouteName.displayResDetails);
                },
              ),
              CardSimple(
                title: 'مدير الفرع (اختياري)',
                onTapCard: () {
                  Get.toNamed(AppRouteName.bchManager);
                },
              ),
              const SizedBox(height: 20)
            ],
          ),
        )),
      ),
    );
  }
}
