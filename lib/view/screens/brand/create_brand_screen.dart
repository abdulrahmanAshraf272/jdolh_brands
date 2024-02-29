import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/brand/create_brand_controller.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/valid_input.dart';
import 'package:jdolh_brands/view/widgets/auth/custom_textform_auth.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_textfield.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/custom_button_one.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
    return Scaffold(
      appBar: customAppBar(title: 'البيانات التجارية', withArrowBack: false),
      floatingActionButton: CustomButtonOne(
          textButton: 'حفظ',
          onPressed: () {
            controller.createBrand(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        key: controller.formstatepart,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text('العلامة التجارية', style: headline4),
                  const SizedBox(height: 20),
                  LogoImage(),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'الإسم التجاري',
                    mustAdded: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                      textEditingController: controller.brandName,
                      hintText: 'الاسم التجاري الذي سيعرض في صفحتك'),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'رقم التواصل',
                    mustAdded: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                      textEditingController: controller.contactNumber,
                      hintText: 'ادخل رقم التواصل'),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'نوع المتجر',
                    bottomPadding: 10,
                    mustAdded: true,
                  ),
                  const DropdownBrandTypes(),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                      title: 'النوع الفرعي', bottomPadding: 10),
                  const DropdownBrandSubtypes(),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(title: 'حسابات التواصل الاجتماعي'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      textEditingController: controller.instagram,
                      hintText: 'رابط حساب instagram'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      textEditingController: controller.snapchat,
                      hintText: 'رابط حساب snapchat'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      textEditingController: controller.tiktok,
                      hintText: 'رابط حساب tiktok'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      textEditingController: controller.twitter,
                      hintText: 'رابط حساب twitter'),
                  const SizedBox(height: 10),
                  CustomTextField(
                      textEditingController: controller.facebook,
                      hintText: 'رابط حساب facebook'),
                  const SizedBox(height: 80)
                ]),
          ),
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateBrandController>(
        builder: (controller) => Stack(
              children: [
                controller.selectedImage != null
                    ? CircleAvatar(
                        radius: 55,
                        backgroundImage: MemoryImage(controller.selectedImage!),
                      )
                    : const CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage('assets/images/placeholder.png'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 70,
                    child: IconButton(
                        onPressed: () {
                          controller.uploadImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black87,
                        )))
              ],
            ));
  }
}

class DropdownBrandTypes extends StatefulWidget {
  final double? width;
  final double horizontalPadding;
  final double verticalPadding;

  final double buttonHeight;
  const DropdownBrandTypes(
      {super.key,
      this.width,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonHeight = 50});

  @override
  State<DropdownBrandTypes> createState() => _DropdownBrandTypesState();
}

class _DropdownBrandTypesState extends State<DropdownBrandTypes> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateBrandController>(
        builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                  vertical: widget.verticalPadding),
              width: widget.width,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: AutoSizeText(
                    'حدد نوع المتجر',
                    maxLines: 1,
                    minFontSize: 1,
                    style: titleSmall.copyWith(color: AppColors.gray600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: controller.brandTypesString
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:
                                  titleSmall.copyWith(color: AppColors.gray600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                      controller.setSelectedBrandType(value);
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
            ));
  }
}

class DropdownBrandSubtypes extends StatefulWidget {
  final double? width;
  final double horizontalPadding;
  final double verticalPadding;

  final double buttonHeight;
  const DropdownBrandSubtypes(
      {super.key,
      this.width,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonHeight = 50});

  @override
  State<DropdownBrandSubtypes> createState() => _DropdownBrandSubtypesState();
}

class _DropdownBrandSubtypesState extends State<DropdownBrandSubtypes> {
  //String? selectedValue;

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(CreateBrandController());
    return GetBuilder<CreateBrandController>(
        builder: (controller) => controller.selectedType == null
            ? Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: widget.verticalPadding),
                width: Get.width,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.gray,
                ),
                child: AutoSizeText(
                  'حدد النوع الفرعي',
                  maxLines: 1,
                  minFontSize: 1,
                  style: titleSmall.copyWith(color: Colors.grey.shade400),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalPadding,
                    vertical: widget.verticalPadding),
                width: widget.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: AutoSizeText(
                      'حدد النوع الفرعي',
                      maxLines: 1,
                      minFontSize: 1,
                      style: titleSmall.copyWith(color: AppColors.gray600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: controller.brandSubtypesToDisplay
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: titleSmall.copyWith(
                                    color: AppColors.gray600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: controller.selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        controller.selectedValue = value;
                        controller.setSelectedSubtypeType(value);
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
                      icon:
                          ImageIcon(AssetImage('assets/icons/arrow_down2.png')),
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
              ));
  }
}
