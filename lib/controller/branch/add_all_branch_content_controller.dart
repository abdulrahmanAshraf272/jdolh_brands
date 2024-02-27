import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAllBranchContentController extends GetxController {
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
}
