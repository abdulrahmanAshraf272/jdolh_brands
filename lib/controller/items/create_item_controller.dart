import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/controller/items/items_controller.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_routes_name.dart';
import 'package:jdolh_brands/core/functions/awsome_dialog_custom.dart';
import 'package:jdolh_brands/core/functions/handling_data_controller.dart';
import 'package:jdolh_brands/core/functions/pick_image.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/categories.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/items.dart';
import 'package:jdolh_brands/data/data_source/remote/bch/resOptions.dart';
import 'package:jdolh_brands/data/models/Item.dart';
import 'package:jdolh_brands/data/models/categories.dart';
import 'package:jdolh_brands/data/models/item_option.dart';
import 'package:jdolh_brands/data/models/resOption.dart';
import 'package:jdolh_brands/view/widgets/common/custom_time_picker.dart';

class CreateItemsController extends GetxController with AllTimes {
  //TODO: Get the value from sharedprefs
  bool isService = false;
  late String itemText;
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  ItemsController itemsController = Get.put(ItemsController());

  ItemsData itemsData = ItemsData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  ResOptionsData resOptionsData = ResOptionsData(Get.find());

  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController dicount = TextEditingController();
  bool discountIsPercent = false;

  bool isPriceDep = false;

  List<int> addedItemOptionsIds = [];
  List<ItemOption> addedItemOptions = [];

  changeDiscountIsPercent(bool isPercent) {
    if (isPercent) {
      discountIsPercent = true;
    } else {
      discountIsPercent = false;
    }
    print('discountIsPercent: $discountIsPercent');
    update();
  }

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
  createItem(BuildContext context) async {
    //var formdata = formstatepart.currentState;
    if (allFieldsAdded()) {
      String resOptionsIds =
          resOptions.map((item) => item.resoptionsId).join(',');
      String optionsIds = addedItemOptions.map((item) => item.id).join(',');
      print('all fields add');
      statusRequest = StatusRequest.loading;
      update();
      var response = await itemsData.addItems(
          bchid: myServices.getBchid(),
          categoriesid: selectedCategory.toString(),
          resoptionsid: resOptionsIds,
          title: title.text,
          price: price.text,
          dicount: discountIsPercent ? '' : dicount.text,
          discountPercentage: discountIsPercent ? dicount.text : '',
          desc: desc.text,
          withOptions: addedItemOptions.isEmpty ? '0' : '1',
          duration: duration.text,
          alwaysAvailable: isAlwaysAvailable ? '1' : '0',
          satTime: satTime ?? '',
          sunTime: sunTime ?? '',
          monTime: monTime ?? '',
          tuesTime: tuesTime ?? '',
          wedTime: wedTime ?? '',
          thursTime: thursTime ?? '',
          friTime: friTime ?? '',
          ioptionSelected: optionsIds,
          file: image!);
      statusRequest = handlingData(response);
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          print('success');
          //add the item just created to local , to display it.
          Item item = Item.fromJson(response['data']);
          itemsController.items.add(item);

          //Change the donePercent of the bch
          myServices.setBchstep('7');
          displayDoneDialog(context, () {
            Get.back();
          });
        } else {
          statusRequest = StatusRequest.failure;
          print('failute');
        }
      }
    }
  }

  // ============ Check validation =============//
  allFieldsAdded() {
    if (title.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة اسم $itemText');
      return false;
    } else if (desc.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة وصف $itemText');
      return false;
    } else if (selectedResOptions.isEmpty) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة التفضيلات');
      return false;
    } else if (selectedCategory == null) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة الصنف');
      return false;
    } else if (image == null) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة صورة $itemText');
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
    if (isService) {
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

  goToAddOptionsPriceDep() async {
    final result = await Get.toNamed(AppRouteName.addItemOptions,
        arguments: {'isPriceDep': true});
    if (result != null) {
      addedItemOptions.add(result);
      isPriceDep = true;
    }
  }

  goToAddOptions() async {
    Get.toNamed(AppRouteName.additionalItemOptions);
    // if (result != null) {
    //   //Here i will recive list not one object.
    //   addedItemOptions.addAll(result);
    // }
  }

  @override
  void onInit() {
    //TODO: get is service
    isService = myServices.getIsService() == 1 ? true : false;
    isService ? itemText = 'الحجز' : itemText = 'المنتج';
    getCategories();
    getResOptions();
    super.onInit();
  }
}
