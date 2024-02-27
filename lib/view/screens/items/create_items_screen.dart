import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/items/create_item_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/view/widgets/branch/create_branch/widgets/number_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CreateItemsScreen extends StatelessWidget {
  const CreateItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateItemsController());
    return GetBuilder<CreateItemsController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'انشاء عنصر'),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'صورة العنصر'),
                    const SizedBox(height: 10),
                    ItemImage(),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'اسم العنصر'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textEditingController: controller.title,
                        hintText: 'مثال: شاورما, عصير مانجا ..'),
                    const SizedBox(height: 20),
                    const CustomSmallBoldTitle(title: 'وصف العنصر'),
                    const SizedBox(height: 10),
                    CustomTextField(
                        textEditingController: controller.title,
                        hintText: 'ادخل وصف العنصر (اختياري)'),
                    NumberTextFieldWithTitleAndText(
                      textEditingController: controller.price,
                      title: "السعر",
                      endText: 'ريال',
                    ),
                    const CustomSmallBoldTitle(title: 'متوفر ضمن صنف'),
                    const SizedBox(height: 10),
                    DropdownCategories(
                      horizontalPadding: 20,
                      verticalPadding: 10,
                    ),
                    const CustomSmallBoldTitle(title: 'متوفر ضمن تفضيل'),
                    const SizedBox(height: 10),
                    DropdownResOptions(
                      horizontalPadding: 20,
                      verticalPadding: 10,
                    ),
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

class ItemImage extends StatelessWidget {
  const ItemImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateItemsController());
    return Stack(
      children: [
        controller.imageSelected != null
            ? CircleAvatar(
                radius: 55,
                backgroundImage: MemoryImage(controller.imageSelected!),
              )
            : Container(
                height: 150.h,
                width: 260.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/placeholder.png',
                        ),
                        fit: BoxFit.cover)),
              ),
        Positioned(
            bottom: -10,
            right: -10,
            child: IconButton(
                onPressed: controller.selectImage,
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.black87,
                )))
      ],
    );
  }
}

class CustomBottomAppBarCreateItem extends StatelessWidget {
  const CustomBottomAppBarCreateItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateItemsController());
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

class DropdownCategories extends StatefulWidget {
  final double? width;
  final double horizontalPadding;
  final double verticalPadding;

  final double buttonHeight;
  const DropdownCategories(
      {super.key,
      this.width,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonHeight = 50});

  @override
  State<DropdownCategories> createState() => _DropdownCategoriesState();
}

class _DropdownCategoriesState extends State<DropdownCategories> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateItemsController());
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: AutoSizeText(
            'حدد الصنف',
            maxLines: 1,
            minFontSize: 1,
            style: titleSmall.copyWith(color: AppColors.gray600),
            overflow: TextOverflow.ellipsis,
          ),
          items: controller.categories
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: titleSmall.copyWith(color: AppColors.gray600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
              controller.selectedCategory = value;
              print(controller.selectedCategory);
            });
          },
          buttonStyleData: ButtonStyleData(
            height: widget.buttonHeight,
            //width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              //border: Border.all(color: Colors.black26),
              color: AppColors.gray,
            ),
            //elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: ImageIcon(AssetImage('assets/icons/arrow_down2.png')),
            iconSize: 18,
            iconEnabledColor: AppColors.gray600,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.gray,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}

class DropdownResOptions extends StatefulWidget {
  final double? width;
  final double horizontalPadding;
  final double verticalPadding;

  final double buttonHeight;
  const DropdownResOptions(
      {super.key,
      this.width,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonHeight = 50});

  @override
  State<DropdownResOptions> createState() => _DropdownResOptionsState();
}

class _DropdownResOptionsState extends State<DropdownResOptions> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateItemsController());
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding),
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: AutoSizeText(
            'حدد التفضيل',
            maxLines: 1,
            minFontSize: 1,
            style: titleSmall.copyWith(color: AppColors.gray600),
            overflow: TextOverflow.ellipsis,
          ),
          items: controller.resOptions
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: titleSmall.copyWith(color: AppColors.gray600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
              controller.selectedCategory = value;
              print(controller.selectedCategory);
            });
          },
          buttonStyleData: ButtonStyleData(
            height: widget.buttonHeight,
            //width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              //border: Border.all(color: Colors.black26),
              color: AppColors.gray,
            ),
            //elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: ImageIcon(AssetImage('assets/icons/arrow_down2.png')),
            iconSize: 18,
            iconEnabledColor: AppColors.gray600,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.gray,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
