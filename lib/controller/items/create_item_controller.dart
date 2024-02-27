import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateItemsController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController duration = TextEditingController();
  Uint8List? imageSelected;

  List<String> categories = ['سندوتشات', 'وجبات', 'عصائر'];
  String? selectedCategory = '';
  List<String> resOptions = ['طاولات داخية', 'طاولات خارجية'];

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
