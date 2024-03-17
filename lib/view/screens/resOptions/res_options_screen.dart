import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/items_controller.dart';
import 'package:jdolh_brands/controller/resOptions/res_options_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/screens/items/create_items_screen.dart';
import 'package:jdolh_brands/view/widgets/common/appBarWithButtonCreate.dart';

class ResOptionsScreen extends StatelessWidget {
  final bool withArrowBack;
  const ResOptionsScreen({super.key, this.withArrowBack = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResOptionsController());

    return GetBuilder<ResOptionsController>(
        builder: (controller) => Scaffold(
              appBar: appBarWithButtonCreate(
                  onTapCreate: () {
                    controller.goToAddResOption();
                  },
                  withArrowBack: withArrowBack,
                  title: 'التفضيلات',
                  buttonText: 'انشاء تفضيل'),
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.resOptions.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.resOptions.length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) =>
                                  CustomCardWithDelete(
                                    text: controller
                                        .resOptions[index].resoptionsTitle!,
                                    onTap: () {
                                      controller.onTapCard(index);
                                    },
                                    onDelete: () {
                                      controller.deleteResOption(
                                          index, context);
                                    },
                                  ))
                          : Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'لا يوجد لديك اي تفضيلات!\n',
                                      style: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo'),
                                    ),
                                    TextSpan(
                                        text: 'اضف اول تفضيل للفرع',
                                        style: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontSize: 14,
                                            fontFamily: 'Cairo'))
                                  ])),
                            ),
                    ),
                  )
                ],
              ),
            ));
  }
}

class CustomCardWithDelete extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Function() onDelete;
  const CustomCardWithDelete(
      {super.key,
      required this.text,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 45.h,
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: AutoSizeText(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                    ),
                  )),
                  TextButton(
                      onPressed: onDelete,
                      child: Text(
                        'حذف',
                        style: titleSmall2.copyWith(color: Colors.red),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
