import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/controller/legaldata/display_legaldata_controller.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';
import 'package:jdolh_brands/view/widgets/common/custom_text_display_general.dart';
import 'package:jdolh_brands/view/widgets/common/custom_title.dart';
import 'package:jdolh_brands/view/widgets/common/rect_image_display.dart';

class DisplayLegaldataScreen extends StatelessWidget {
  const DisplayLegaldataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayLegaldataController());
    return GetBuilder<DisplayLegaldataController>(
        builder: (controller) => Scaffold(
              appBar: customAppBar(title: 'البيانات القانونية'),
              body: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'رقم السجل التجاري',
                    mustAdded: true,
                  ),
                  CustomTextDisplayGeneral(
                    text: controller.crNumber.toString(),
                  ),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'صورة من السجل التجاري',
                    mustAdded: true,
                  ),
                  const SizedBox(height: 10),
                  RectImageDisplay(
                    image: '${ApiLinks.legaldata}/${controller.crPhoto}',
                  ),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'رقم الضريبة',
                    mustAdded: true,
                  ),
                  CustomTextDisplayGeneral(
                    text: controller.taxNumber.toString(),
                  ),
                  const SizedBox(height: 20),
                  const CustomSmallBoldTitle(
                    title: 'صورة الشهادة الضريبية',
                    mustAdded: true,
                  ),
                  const SizedBox(height: 10),
                  RectImageDisplay(
                    image: '${ApiLinks.legaldata}/${controller.taxPhoto}',
                  ),
                  const SizedBox(height: 80),
                ]),
              ),
            ));
  }
}
