import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/functions/pick_image.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/brand.dart';
import 'package:jdolh_brands/data/data_source/remote/legaldata.dart';
import 'package:jdolh_brands/data/data_source/remote/view_types_and_subtypes.dart';
import 'package:jdolh_brands/data/models/brand.dart';
import 'package:jdolh_brands/data/models/brand_subtype.dart';
import 'package:jdolh_brands/data/models/brand_type.dart';

class CreateLegaldataController extends GetxController {
  bool afterSignup = true;
  StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  LegaldataData legaldataData = LegaldataData(Get.find());
  MyServices myServices = Get.find();

  TextEditingController crNumber = TextEditingController();
  TextEditingController taxNumber = TextEditingController();

  File? imageCr;
  Uint8List? selectedImageCr;

  File? imageTax;
  Uint8List? selectedImageTax;

  createBrand(BuildContext context) async {
    var formdata = formstatepart.currentState;
    if (formdata!.validate() && allFieldsGood()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await legaldataData.createLegaldata(
          brandid: myServices.sharedPreferences.getString("brandid") ?? '-1',
          crNumber: crNumber.text,
          taxNumber: taxNumber.text,
          files: [imageCr!, imageTax!]);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          displayDoneDialog(context, () {
            if (afterSignup) {
              //navigate offNamed LegalDataScreen
            } else {
              //navigate offAllNamed mainScreen
              //Get.offAllNamed(AppRouteName.mainScreen);
            }
          });
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  allFieldsGood() {
    if (imageCr == null) {
      Get.rawSnackbar(message: 'من فضلك قم برفع صورة من السجل التجاري');
      return false;
    } else if (imageTax == null) {
      Get.rawSnackbar(message: 'من فضلك قم برفع صورة الشهادة الضريبية');
      return false;
    } else {
      return true;
    }
  }

  uploadImageCr() async {
    XFile? xFile = await pickImageFromGallery();

    if (xFile != null) {
      imageCr = File(xFile.path);
      selectedImageCr = await xFile.readAsBytes();
      update();
    } else {
      print("User canceled image picking");
      // Handle the case where the user canceled image picking
    }
  }

  uploadImageTax() async {
    XFile? xFile = await pickImageFromGallery();

    if (xFile != null) {
      imageTax = File(xFile.path);
      selectedImageTax = await xFile.readAsBytes();
      update();
    } else {
      print("User canceled image picking");
      // Handle the case where the user canceled image picking
    }
  }

  onTapSkip() {
    print('shit');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments != null) {
      afterSignup = Get.arguments['afterSignup'];
      print(afterSignup);
    }
  }
}
