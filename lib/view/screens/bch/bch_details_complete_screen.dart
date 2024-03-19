import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final controller = Get.put(BchDetailsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          controller.bch.bchBranchName ?? '',
        ),
        centerTitle: true,
      ),
      body: GetBuilder<BchDetailsController>(
        builder: (controller) => SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              TopContainer(
                donePercent: controller.donePercent,
                title: 'تهانيا لقد اكملت بياناتك بنجاح, بانتظار موافقة الادارة',
              ),
              const SizedBox(height: 20),
              CardSimple(
                title: 'البيانات الاساسية',
                onTapCard: () {
                  controller.trySomething();
                },
              ),
              CardSimple(
                title: 'أوقات العمل',
                onTapCard: () {
                  Get.toNamed(AppRouteName.displayWorktime);
                },
              ),
              CardSimple(
                title: 'سياسة الحجز والفاتورة',
                onTapCard: () {
                  Get.toNamed(AppRouteName.displayPolicy);
                },
              ),
              CardSimple(
                title: 'طرق الدفع',
                onTapCard: () {
                  Get.toNamed(AppRouteName.displayPaymentMethods);
                },
              ),
              CardSimple(
                title: 'الأصناف',
                onTapCard: () {
                  Get.toNamed(AppRouteName.categories);
                },
              ),
              CardSimple(
                title: 'التفضيلات',
                onTapCard: () {
                  Get.toNamed(AppRouteName.resOptions);
                },
              ),
              CardSimple(
                title: controller.isService == 1
                    ? 'ال$servicesPloral'
                    : 'ال$productsPloral',
                onTapCard: () {
                  Get.toNamed(AppRouteName.items);
                },
              ),
              CardSimple(
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
