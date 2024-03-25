import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/controller/allTimesMixin.dart';
import 'package:jdolh_brands/controller/items/items_controller.dart';
import 'package:jdolh_brands/controller/values_controller.dart';
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
import 'package:jdolh_brands/data/models/bch_worktime.dart';
import 'package:jdolh_brands/data/models/categories.dart';
import 'package:jdolh_brands/data/models/item_option.dart';
import 'package:jdolh_brands/data/models/resOption.dart';
import 'package:jdolh_brands/view/widgets/common/custom_time_picker.dart';

class EditItemsController extends GetxController with AllTimes {
  late Item item;

  bool isService = false;
  late String itemText;
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest imageStatusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  ItemsData itemsData = ItemsData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  ResOptionsData resOptionsData = ResOptionsData(Get.find());
  TimeOfDay? timeHelper;

  //Section 1
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController duration = TextEditingController();
  //Section 2
  TextEditingController dicount = TextEditingController();
  bool discountIsPercent = false;
  //Section 3
  List<ResOption> resOptions = [];
  List<int> selectedResOptions = [];
  //Section 4
  bool isAlwaysAvailable = true;
  //Section 5
  //List<ItemOption> addedItemOptions = [];
  //Section 6
  ItemOption? priceDepOption;
  //Section 7
  File? image;
  Uint8List? selectedImage;
  String? imageRecieved;
  //Section 8
  List<MyCategories> categories = [];
  List<String> categoriesTitle = [];
  int? selectedCategory;
  String initialCategory = '';

  bool checkIfResOptionSelected(int index) {
    if (selectedResOptions.contains(resOptions[index].resoptionsId)) {
      return true;
    } else {
      return false;
    }
  }

  //================== Navigation ==================//
  //===============================================//

  goToAddOptionsPriceDep() async {
    final result = await Get.toNamed(AppRouteName.addItemOptions, arguments: {
      'isPriceDep': true,
      'value': priceDepOption,
      "itemId": item.itemsId
    });
    if (result != null) {
      priceDepOption = result;
    }
  }

  goToAddOptions() {
    Get.toNamed(AppRouteName.additionalItemOptions,
        arguments: {"itemId": item.itemsId});
  }

  // ============ Edit item ===============//
  //========================================//
  editItem(BuildContext context) async {
    if (allFieldsAdded()) {
      String resOptionsIds =
          selectedResOptions.map((element) => element).join(',');

      statusRequest = StatusRequest.loading;
      update();
      //Edit image
      if (image != null) {
        bool editImageDone = await editItemImage();
        if (!editImageDone) {
          statusRequest = StatusRequest.none;
          update();
          Get.rawSnackbar(message: 'حدث خطأ اثناء رفع الصورة, حاول مرة اخرى');
          return;
        }
      }
      //Edit Data
      var response = await itemsData.editItem(
        itemId: item.itemsId.toString(),
        categoriesid: selectedCategory.toString(),
        resoptionsid: resOptionsIds,
        title: title.text,
        price: price.text,
        dicount: discountIsPercent ? '' : dicount.text,
        discountPercentage: discountIsPercent ? dicount.text : '',
        desc: desc.text,
        withOptions: ValuesController.addedItemOptions.isEmpty ? '0' : '1',
        duration: duration.text,
        alwaysAvailable: isAlwaysAvailable ? '1' : '0',
        satTime: satTime ?? '',
        sunTime: sunTime ?? '',
        monTime: monTime ?? '',
        tuesTime: tuesTime ?? '',
        wedTime: wedTime ?? '',
        thursTime: thursTime ?? '',
        friTime: friTime ?? '',
      );
      statusRequest = handlingData(response);
      update();
      print(' ================$statusRequest');
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Item itemAdded = Item.fromJson(response['data']);
          displayDoneDialog(context, () {
            Get.back(result: itemAdded);
          });
        } else {
          statusRequest = StatusRequest.failure;
          print('failute');
        }
      } //if success
    } //check all fields added
  } //create item

  Future<bool> editItemImage() async {
    var response = await itemsData.editItemImage(
        itemId: item.itemsId.toString(), file: image!);
    imageStatusRequest = handlingData(response);
    if (imageStatusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // ============ Check validation =============//
  //===========================================//
  allFieldsAdded() {
    if (title.text == '') {
      Get.rawSnackbar(message: 'من فضلك قم باضافة اسم $itemText');
      return false;
    } else if (selectedResOptions.isEmpty) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة التفضيلات');
      return false;
    } else if (selectedCategory == null) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة الصنف');
      return false;
    } else if (price.text == '' && priceDepOption == null) {
      Get.rawSnackbar(message: 'من فضلك قم باضافة السعر');
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
      } else if (int.parse(duration.text) % 30 != 0) {
        Get.rawSnackbar(message: 'يجب ان تكون مدة الحجز من مضاعفات ال30 دقيقة');
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  // ================= Geting Data ===============//
  //==============================================//
  getCategories() async {
    var response =
        await categoriesData.getCategories(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseCategories(response);
        print('get categories done $statusRequest');

        update();
      } else {
        statusRequest = StatusRequest.failure;
        update();
        throw Exception('get categories failed');
      }
    } else {
      statusRequest = StatusRequest.failure;
      update();
      throw Exception('get categories failed');
    }
  }

  getResOptions() async {
    var response =
        await resOptionsData.getResOptions(bchid: myServices.getBchid());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseResOptions(response);
        print('get ResOptoins done $statusRequest');
        update();
      } else {
        statusRequest = StatusRequest.failure;
        update();
        throw Exception('get res option failed failed');
      }
    } else {
      statusRequest = StatusRequest.failure;
      update();
      throw Exception('get res option failed failed');
    }
  }

  getSelectedResOptionsIds() async {
    var response = await resOptionsData.getSelectedResOptionsIds(
        itemId: item.itemsId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List dataList = response['data'];
        //selectedResOptions = List.from(dataList);
        selectedResOptions.clear();
        for (int i = 0; i < dataList.length; i++) {
          selectedResOptions.add(dataList[i]['items_resoptions_resoptionsid']);
        }

        print(selectedResOptions);
        print('getting selectedResOption done');
        update();
      } else {
        statusRequest = StatusRequest.failure;
        update();
        throw Exception('get selected resOption failed failed');
      }
    } else {
      statusRequest = StatusRequest.failure;
      update();
      throw Exception('get selected resOption failed failed');
    }
  }

  getSelectedItemOptions() async {
    var response =
        await itemsData.getSelectedItemOptions(itemId: item.itemsId.toString());
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        parseSelectedItemOption(response);
        print('get selected itemOption is done');
        update();
      } else {
        // ignore: avoid_print
        print('no options found');
        return true;
      }
    } else {
      statusRequest = StatusRequest.failure;
      update();
      throw Exception('get selectedItemOption failed');
    }
  }

  // Future<void> fetchData() async {
  //   try {
  //     await Future.wait<void>([
  //       getCategories(),
  //       getResOptions(),
  //       getAndSetData(),
  //       getSelectedResOptionsIds(),
  //       getSelectedItemOptions(),
  //     ]);
  //     update();
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     // Handle error if necessary
  //   }
  // }

  // =============== Parsing Data ==============//
  //===========================================//
  parseCategories(response) {
    categories.clear();
    List categoriesJson = response['data'];
    categories = categoriesJson.map((e) => MyCategories.fromJson(e)).toList();
    categoriesTitle = categories.map((e) => e.title!).toList();

    initialCategory = categories
        .firstWhere((element) => element.id == selectedCategory)
        .title!;
  }

  parseResOptions(response) {
    resOptions.clear();
    List resOptionsJson = response['data'];
    resOptions = resOptionsJson.map((e) => ResOption.fromJson(e)).toList();

    //Make initial state all resOptions selected
    selectedResOptions =
        List.from(resOptions.map((e) => e.resoptionsId!).toList());
  }

  parseSelectedItemOption(response) {
    ValuesController.addedItemOptions.clear();
    List data = response['data'];
    List<ItemOption> itemOptions = [];

    itemOptions = data.map((e) => ItemOption.fromJson(e)).toList();

    for (int i = 0; i < itemOptions.length; i++) {
      if (itemOptions[i].priceDep == 1) {
        priceDepOption = itemOptions[i];
        itemOptions.remove(itemOptions[i]);
      }
    }
    ValuesController.addedItemOptions = List.from(itemOptions);
  }

  // ================ Select Data ===============//
  //=============================================//
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

  changeDiscountIsPercent(bool isPercent) {
    if (isPercent) {
      discountIsPercent = true;
    } else {
      discountIsPercent = false;
    }
    print('discountIsPercent: $discountIsPercent');
    update();
  }

  // =================== Pick Time and Days Functions ==============//
  //===============================================================//
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

  getAndSetData() {
    if (Get.arguments != null) {
      item = Get.arguments as Item;
      //Section 1
      title.text = item.itemsTitle ?? '';
      desc.text = item.itemsDesc ?? '';
      price.text = item.itemsPrice.toString();
      duration.text = item.itemsDuration.toString();
      //Section 2
      discountIsPercent = item.itemsDiscountPercentage != 0 ? true : false;
      dicount.text = discountIsPercent
          ? item.itemsDiscountPercentage.toString()
          : item.itemsDiscount.toString();

      //Section 7
      imageRecieved = item.itemsImage!;
      //Section 6
      selectedCategory = item.itemsCategoriesid;

      //Section 4
      isAlwaysAvailable = item.itemsAlwaysAvailable == 1 ? true : false;
      if (!isAlwaysAvailable) {
        BchWorktime worktime = BchWorktime(
          bchworktimeSat: item.itemsSatTime,
          bchworktimeSun: item.itemsSunTime,
          bchworktimeMon: item.itemsMonTime,
          bchworktimeTues: item.itemsTuesTime,
          bchworktimeWed: item.itemsWedTime,
          bchworktimeThurs: item.itemsThursTime,
          bchworktimeFri: item.itemsFriTime,
        );
        decodeFromStringToTimeOfDay(worktime);
      }
    }
    update();
  }

  @override
  void onInit() async {
    isService = myServices.getIsService() == 1 ? true : false;
    isService ? itemText = 'الحجز' : itemText = 'المنتج';
    getAndSetData();

    getCategories();
    getResOptions();
    getSelectedResOptionsIds();
    getSelectedItemOptions();

    super.onInit();
  }
}
