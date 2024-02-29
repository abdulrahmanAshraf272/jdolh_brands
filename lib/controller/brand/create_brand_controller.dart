import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/functions/pick_image.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/brand.dart';
import 'package:jdolh_brands/data/data_source/remote/view_types_and_subtypes.dart';
import 'package:jdolh_brands/data/models/brand_subtype.dart';
import 'package:jdolh_brands/data/models/brand_type.dart';

class CreateBrandController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  ViewBrandTypesAndSubtypesData viewBrandTypesData =
      ViewBrandTypesAndSubtypesData(Get.find());
  BrandData brandData = BrandData(Get.find());
  MyServices myServices = Get.find();

  TextEditingController brandName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController snapchat = TextEditingController();
  TextEditingController tiktok = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController facebook = TextEditingController();

  BrandType? selectedType;
  BrandSubtype? selectedSubtype;
  List<BrandType> brandTypes = [];
  List<BrandSubtype> brandSubtypes = [];

  List<String> brandTypesString = [];
  List<String> brandSubtypesToDisplay = [];
  File? logo;
  Uint8List? selectedImage;

  //To solve the problem of the subtype .
  String? selectedValue;

  createBrand(BuildContext context) async {
    if (allValuesAdded()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await brandData.createBrand(
          managerId: myServices.sharedPreferences.getString("id")!,
          storeName: brandName.text,
          type: selectedType!.type!,
          isService: selectedType!.isService!.toString(),
          subtype: selectedSubtype!.subtype!,
          contactNumber: contactNumber.text,
          instagram: instagram.text,
          tiktok: tiktok.text,
          facebook: facebook.text,
          snapchat: snapchat.text,
          twitter: twitter.text,
          file: logo!);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'تم تسجيل الوصول',
            btnOkText: 'حسنا',
            onDismissCallback: (dismissType) {
              //Get.offAllNamed(AppRouteName.mainScreen);
            },
          ).show();
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  bool allValuesAdded() {
    if (brandName.text == '') {
      Get.rawSnackbar(message: 'ادخل الاسم التجاري');
      return false;
    } else if (selectedType == null) {
      Get.rawSnackbar(message: 'اختر نوع المتجر');
      return false;
    } else if (contactNumber.text == '') {
      Get.rawSnackbar(message: 'ادخل رقم التواصل');
      return false;
    } else if (logo == null) {
      Get.rawSnackbar(message: 'من فضلك قم برفع صورة العلامة التجارية');
      return false;
    } else {
      return true;
    }
  }

  setSelectedBrandType(String? value) {
    if (value != null) {
      selectedType = brandTypes.firstWhere((element) => element.type == value);

      selectedValue = null;
      selectedSubtype = null;
      brandSubtypesToDisplay.clear();
      for (int i = 0; i < brandSubtypes.length; i++) {
        if (brandSubtypes[i].typeId == selectedType!.id) {
          brandSubtypesToDisplay.add(brandSubtypes[i].subtype!);
        }
      }
      update();
      print(selectedType!.type);
    }
  }

  setSelectedSubtypeType(String? value) {
    if (value != null) {
      selectedSubtype =
          brandSubtypes.firstWhere((element) => element.subtype == value);
      print(selectedSubtype!.subtype);
    }
  }

  getBrandTypesAndSubtypes() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await viewBrandTypesData.getData();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseTypesAndSubtypes(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    } //
  }

  parseTypesAndSubtypes(response) {
    brandTypes.clear();
    brandSubtypes.clear();

    List typesJson = response['types'];
    List subtypesJson = response['subtypes'];

    brandTypes = typesJson.map((e) => BrandType.fromJson(e)).toList();
    brandSubtypes = subtypesJson.map((e) => BrandSubtype.fromJson(e)).toList();

    for (int i = 0; i < brandTypes.length; i++) {
      brandTypesString.add(brandTypes[i].type!);
    }
    update();
  }

  uploadImage() async {
    XFile? xFile = await pickImageFromGallery();

    if (xFile != null) {
      logo = File(xFile.path);
      selectedImage = await xFile.readAsBytes();
      update();
    } else {
      print("User canceled image picking");
      // Handle the case where the user canceled image picking
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBrandTypesAndSubtypes();
  }
}
