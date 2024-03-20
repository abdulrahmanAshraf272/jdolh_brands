import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/categories_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';

class CategoriesScreen extends StatelessWidget {
  final bool withArrowBack;
  const CategoriesScreen({super.key, this.withArrowBack = true});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesController());

    unableToDeleteDialog(String desc) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'غير مسموح',
        desc: desc,
        btnOkText: 'حسناً',
      ).show();
    }

    return GetBuilder<CategoriesController>(
        builder: (controller) => Scaffold(
              appBar:
                  customAppBar(title: 'الاصناف', withArrowBack: withArrowBack),
              floatingActionButton: GoHomeButton(
                  onTap: () {
                    controller.onTapAddCategory();
                  },
                  text: 'إضافة',
                  height: 40,
                  width: 100),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: Column(
                children: [
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Expanded(
                      child: controller.categories.isNotEmpty
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.categories.length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) =>
                                  CategoriesListItem(
                                    title: controller.categories[index].title ??
                                        '',
                                    onTapDelete: () async {
                                      final result = await controller
                                          .deleteCategory(index);

                                      if (result != null) {
                                        unableToDeleteDialog(result);
                                      }
                                    },
                                  ))
                          : ListIsEmptyText(),
                    ),
                  )
                ],
              ),
            ));
  }
}

class CategoriesListItem extends StatelessWidget {
  final String title;
  final void Function() onTapDelete;

  const CategoriesListItem({
    super.key,
    required this.title,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AutoSizeText(title,
                  maxLines: 1,
                  minFontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  style: titleSmall),
            ),
          ),
          TextButton(
              onPressed: onTapDelete,
              child: Text(
                'حذف',
                style: titleSmall2.copyWith(color: Colors.red),
              ))
        ],
      ),
    );
  }
}

class ListIsEmptyText extends StatelessWidget {
  const ListIsEmptyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: 'اضف الاصناف التي سوف تعرض في القائمة\n',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                TextSpan(
                    text: 'مثال: مشويات , وجبات',
                    style: TextStyle(
                        color: AppColors.black.withOpacity(0.4),
                        fontSize: 14,
                        fontFamily: 'Cairo'))
              ])),
          SizedBox(height: 10),

          // CustomButton(
          //     onTap: () {
          //       controller.onTapAddCategory();
          //     },
          //     text: ' أضف ')
        ],
      ),
    );
  }
}
