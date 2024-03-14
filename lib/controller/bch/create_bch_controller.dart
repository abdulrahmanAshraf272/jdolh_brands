import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/functions/pick_image.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/bch.dart';
import 'package:jdolh_brands/data/data_source/remote/brand.dart';
import 'package:jdolh_brands/data/data_source/remote/legaldata.dart';
import 'package:jdolh_brands/data/data_source/remote/view_types_and_subtypes.dart';
import 'package:jdolh_brands/data/models/bch.dart';
import 'package:jdolh_brands/data/models/brand.dart';
import 'package:jdolh_brands/data/models/brand_subtype.dart';
import 'package:jdolh_brands/data/models/brand_type.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/custom_button.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';

class CreateBchController extends GetxController {
  bool afterSignup = true;
  StatusRequest statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  BchData bchData = BchData(Get.find());
  MyServices myServices = Get.find();

  TextEditingController bchName = TextEditingController();
  TextEditingController bchDesc = TextEditingController();
  TextEditingController bchPhone = TextEditingController();
  TextEditingController bchLocationLink = TextEditingController();

  String? location;
  LatLng? latLngSelected;

  String? city;

  File? image;
  Uint8List? selectedImage;

  createBch(BuildContext context) async {
    var formdata = formstatepart.currentState;
    if (formdata!.validate() && allFieldsAdded()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await bchData.createBch(
          brandid: myServices.sharedPreferences.getString("brandid") ?? '-1',
          branchName: bchName.text,
          city: city!,
          location: location!,
          lat: latLngSelected!.latitude.toString(),
          lng: latLngSelected!.longitude.toString(),
          locationLink: bchLocationLink.text,
          desc: bchDesc.text,
          contactNumber: bchPhone.text,
          file: image!);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      update();
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          myServices.setBchstep('1');
          myServices.setBrandstep('4');
          Bch bch = Bch.fromJson(response['data']);
          myServices.setBchid(bch.bchId.toString());

          displayDoneDialog(context, () {
            Get.offAllNamed(AppRouteName.mainScreen);
            Get.toNamed(AppRouteName.bchDetails);
          });
        } else {
          statusRequest = StatusRequest.failure;
          update();
        }
      }
    }
  }

  allFieldsAdded() {
    if (image == null) {
      Get.rawSnackbar(message: 'من فضلك قم برفع صورة من الفرع');
      return false;
    } else if (city == null) {
      Get.rawSnackbar(message: 'من فضلك قم باختيار المدينة');
      return false;
    } else if (location == null) {
      Get.rawSnackbar(message: 'من فضلك قم بتحديد الموقع');
      return false;
    } else {
      return true;
    }
  }

  uploadImage() async {
    XFile? xFile = await pickImageFromGallery();

    if (xFile != null) {
      image = File(xFile.path);
      selectedImage = await xFile.readAsBytes();
      update();
    } else {
      print("User canceled image picking");
      // Handle the case where the user canceled image picking
    }
  }

  goToAddLocation() async {
    final result = await Get.toNamed(AppRouteName.selectAddress);
    if (result != null) {
      LatLng? receivedLatLng = result as LatLng?;

      if (receivedLatLng != null) {
        latLngSelected = receivedLatLng;
        print(
            'lat: ${latLngSelected!.latitude}, lng: ${latLngSelected!.longitude}');

        List<Placemark> placemarks = await placemarkFromCoordinates(
            latLngSelected!.latitude, latLngSelected!.longitude,
            localeIdentifier: 'ar');

        location = '${placemarks[0].locality}, ${placemarks[0].street}';
        print(location);
        update();
      }
    }
  }

  String diplayLocation() {
    if (location == null) {
      return 'حدد موقع الفرع';
    } else {
      return location!;
    }
  }
}
