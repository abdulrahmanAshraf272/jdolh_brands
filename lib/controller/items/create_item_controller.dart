import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/functions/pick_image.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/categories.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resOptions.dart';
import 'package:jdolh_brands/data/models/categories.dart';
import 'package:jdolh_brands/data/models/resOption.dart';
import 'package:jdolh_brands/view/widgets/common/custom_time_picker.dart';

class CreateItemsController extends GetxController with AllTimes {
  //TODO: Get the value from sharedprefs
  bool isService = false;
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  ItemsData itemsData = ItemsData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  ResOptionsData resOptionsData = ResOptionsData(Get.find());

  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController duration = TextEditingController();

  bool isAlwaysAvailable = true;
  TimeOfDay? timeHelper;

  //List<String> categories = ['سندوتشات', 'وجبات', 'عصائر'];
  List<MyCategories> categories = [];
  List<ResOption> resOptions = [];
  List<String> categoriesTitle = [];
  int? selectedCategory;

  File? image;
  Uint8List? selectedImage;
  List<int> selectedResOptions = [];

  // ============ Create item ===============//
  createItem() {
    var formdata = formstatepart.currentState;
    if (formdata!.validate() && allFieldsAdded()) {}
  }

  // ============ Check validation =============//
  allFieldsAdded() {
    if (title.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة اسم العنصر');
      return false;
    } else if (desc.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة وصف العنصر');
      return false;
    } else if (selectedResOptions.isEmpty) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة التفضيلات');
      return false;
    } else if (selectedCategory == null) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة الصنف');
      return false;
    } else if (image == null) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة صورة العنصر');
      return false;
    } else if (!checkDuration()) {
      return false;
    } else if (!isAlwaysAvailable) {
      if (!encodeAllDays()) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  bool checkDuration() {
    if (!isService) {
      if (duration.text == '') {
        Get.rawSnackbar(message: 'من فضلك قم باضافة مدة الحجز');
        return false;
      } else if (int.parse(duration.text) < 30 ||
          int.parse(duration.text) > 360) {
        Get.rawSnackbar(message: 'مدة الحجز يجب ان تكون اكبر من 30 دقيقة');
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  // ============= Geting Data ===========//
  getCategories() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await categoriesData.getCategories(bchid: '7');
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseCategories(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    }
    update();
  }

  getResOptions() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resOptionsData.getResOptions(bchid: '7');
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseResOptions(response);
      } else {
        Get.rawSnackbar(message: 'لا يوجد بيانات');
      }
    }
    update();
  }

  // =============== Parsing Data ==============//
  parseCategories(response) {
    categories.clear();
    List categoriesJson = response['data'];
    categories = categoriesJson.map((e) => MyCategories.fromJson(e)).toList();
    categoriesTitle = categories.map((e) => e.title!).toList();
  }

  parseResOptions(response) {
    resOptions.clear();
    List resOptionsJson = response['data'];
    resOptions = resOptionsJson.map((e) => ResOption.fromJson(e)).toList();
    print('resOption success: ${resOptions[0].resoptionsTitle}');

    //Make initial state all resOptions selected
    selectedResOptions =
        List.from(resOptions.map((e) => e.resoptionsId!).toList());
    print(selectedResOptions);
  }

  // ================ Select Data ===============//
  setSelectedCategory(String? value) {
    if (value != null) {
      selectedCategory =
          categories.firstWhere((element) => element.title == value).id;
      print('selectedCategory: $selectedCategory');
      //update();
    }
  }

  addRemoveResOptions(int index) {
    if (selectedResOptions.contains(resOptions[index].resoptionsId!)) {
      selectedResOptions.remove(resOptions[index].resoptionsId!);
    } else {
      selectedResOptions.add(resOptions[index].resoptionsId!);
    }
    print(selectedResOptions);
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

  // =================== Pick Time and Datys Functions ==============//

  applyToAll() {
    if (satFromP1 == null || satToP1 == null) {
      Get.rawSnackbar(
          message:
              'يجب تعيين اوقات عمل يوم السبت , ليتم تطبيق باقي الايام مثل يوم السبت',
          duration: const Duration(seconds: 5));
      return;
    }
    allDaysLikeSatDay();
    update();
  }

  switchDayOff(int i) {
    switchDayOffSetValue(i);
    update();
  }

  switchIsAlwaysAvailable() {
    isAlwaysAvailable = !isAlwaysAvailable;
  }

  void showCustomTimePicker(BuildContext context, int d) {
    final initialTime = TimeOfDay.now();
    int adjustedMinute = (initialTime.minute ~/ 30) * 30;
    final initialAdjustedTime =
        TimeOfDay(hour: initialTime.hour, minute: adjustedMinute);
    timeHelper = initialAdjustedTime;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CustomTimePicker(
            initialTime: initialTime,
            onTimeSelected: (selectedTime) {
              timeHelper = selectedTime;
            },
            onTapSave: () {
              Get.back();
              setTime(timeHelper, d);
              update();
            },
            onTapReset: () {
              Get.back();
              setTime(null, d);
              update();
            },
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    getCategories();
    getResOptions();
    super.onInit();
  }
}
