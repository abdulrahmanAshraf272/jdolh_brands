import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/data/data_source/remote/auth/signup.dart';
import 'package:jdolh_brands/data/data_source/remote/view_brand_types.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> formstatepart1 = GlobalKey<FormState>();
  GlobalKey<FormState> formstatepart2 = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  ViewBrandTypesData viewBrandTypesData = ViewBrandTypesData(Get.find());
  SignupData signupData = SignupData(Get.find());
  var brandTypes;
  TextEditingController brandName = TextEditingController();
  String brandLogo = '';
  bool isService = true;
  Uint8List? imageSelected;
  List<String> items = [];
  String? selectedType;
  StatusRequest statusRequest = StatusRequest.none;
  bool passwordVisible = true;
  showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  // ========= Page View functions ==========//
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int pagesNumber = 2;

  onTapNext() {
    //Check if the user filled the fields of signup part1 before go to part2
    var formdata = formstatepart1.currentState;
    if (formdata!.validate()) {
      if (currentPage < (pagesNumber - 1)) {
        pageController.animateToPage(
          currentPage + 1,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      update();
    }
  }

  onTapBack() {
    if (currentPage != 0) {
      pageController.animateToPage(
        currentPage - 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    update();
  }

  onPageChange(int page) {
    currentPage = page;
    update();
  }

  goToVerifycode() {
    Get.offNamed(AppRouteName.verifyCode,
        arguments: {"email": email.text, 'resetPassword': 0});
  }

  goToLogin() {
    Get.offAllNamed(AppRouteName.login);
  }

  getBrandTypes() async {
    var response = await viewBrandTypesData.getData();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        brandTypes = response['data'];

        items.clear();
        for (int i = 0; i < brandTypes.length; i++) {
          items.add(brandTypes[i]['brandTypes_type']);
        }
        print(items[0]);
      } else {
        Get.rawSnackbar(
            message:
                'غير قادر على تحميل انواع المتاجر, اغلق التطبيق ثم افتحه مرة اخرى');
      }
    } //
  }

  signup() async {
    var formdata = formstatepart2.currentState;
    if (formdata!.validate()) {
      //TODO: Check if the user select type and Logo.
      print(selectedType);
      if (selectedType != null) {
        int isService = getIsService(brandTypes, selectedType!)!;
        print(username.text);
        print(email.text);
        print(password.text);
        print(phoneNumber.text);
        print(selectedType);
        print(brandName.text);
        print(isService);
      }
      goToVerifycode();
    }
  }

  int? getIsService(List data, String targetType) {
    for (var map in data) {
      if (map['brandTypes_type'] == targetType) {
        return map['brandTypes_isService'] as int?;
      }
    }
    return null; // Return null if targetType is not found
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    imageSelected = img;
    update();
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }

    print('No image selected');
  }

  @override
  void onInit() {
    getBrandTypes();
    super.onInit();
  }

  @override
  void dispose() {
    //if he wants to come back to edit name or somthing to find what he wrote and edit it .
    name.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    brandName.dispose();
    super.dispose();
  }
}
