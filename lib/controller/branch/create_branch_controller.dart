import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/core/class/status_request.dart';

class CreateBranchController extends GetxController with times {
  GlobalKey<FormState> formstatepart = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController branchName = TextEditingController();
  TextEditingController branchManagerName = TextEditingController();
  TextEditingController branchDesc = TextEditingController();
  TextEditingController resAdditionalInfo = TextEditingController();
  TextEditingController branchLocationLink = TextEditingController();
  TextEditingController resCost = TextEditingController();
  TextEditingController resSuspensionLimitTime = TextEditingController();
  Uint8List? imageSelected;
  late String branchLocation = '';
  late double branchLat;
  late double branchLng;
  String? policySelected;
  List<String> resPolicies = [
    'قيمة الفاتورة تدفع عند الوصول ويمكن تعديلها',
    'قيمة الفاتورة يجب دفعها مسبقا و غير مستردة ولا يمكن تعديل الطلب',
    'قيمة الفاتورة يمكن دفعها عند الوصول وتعديل الطلب',
    'قيمة الفاتورة يمكن دفعها عند الوصول ولا يمكن تعديل الطلب وغير مستردة',
  ];
  List<String> paymentMethod = [
    'الدفع بالبطاقة',
    'الدفع بالتقسيط',
    'الدفع عند الوصول'
  ];

  //TimeOfDay? satTimeFromP1;

  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int pagesNumber = 4;
  double progressBarPercent = 0;

  onTapNext() {
    if (currentPage < (pagesNumber - 1)) {
      pageController.animateToPage(
        currentPage + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      increaseDecreaseProgress(true);
    }

    update();
  }

  increaseDecreaseProgress(bool increase) {
    if (increase) {
      progressBarPercent += (1 / (pagesNumber - 1));
    } else {
      progressBarPercent -= (1 / (pagesNumber - 1));
    }
  }

  onTapBack() {
    if (currentPage != 0) {
      pageController.animateToPage(
        currentPage - 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      increaseDecreaseProgress(false);
    }
    update();
  }

  onPageChange(int page) {
    currentPage = page;
    update();
  }

  setTime(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      satTimeFromP1 = value;
      update();
    });
    print('sdf');
  }

  String displayTime(TimeOfDay? time, BuildContext context) {
    if (time != null) {
      return time.format(context).toString();
    } else {
      return '';
    }
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
}

mixin Pageview {}

mixin times {
  TimeOfDay? satTimeFromP1;
}
