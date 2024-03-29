import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/controller/main_controller.dart';

import 'package:jdolh_brands/core/functions/alert_exit_app.dart';
import 'package:jdolh_brands/view/widgets/custom_bottom_appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> items = List.generate(20, (index) => 'Item $index');
  Future<void> _refreshData() async {
    // Simulate fetching new data
    await Future.delayed(Duration(seconds: 2));

    // Update the UI with the new data
    setState(() {
      items = List.generate(20, (index) => 'New Item $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return WillPopScope(
      onWillPop: alertExitApp,
      child: GetBuilder<MainController>(
          builder: (controller) => Scaffold(
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     //Get.toNamed(AppRouteName.checkin);
                //   },
                //   backgroundColor: AppColors.secondaryColor,
                //   shape: const CircleBorder(),
                //   child: const Icon(
                //     Icons.place,
                //     color: Colors.white,
                //   ),
                // ),
                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: const CustomBottomAppBar(),
                body: controller.listPage.elementAt(controller.currentPage),
              )),
    );
  }
}
