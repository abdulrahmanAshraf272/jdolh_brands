import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_brands/controller/select_address_controller.dart';
import 'package:jdolh_brands/core/class/handling_data_view.dart';
import 'package:jdolh_brands/core/class/status_request.dart';
import 'package:jdolh_brands/core/constants/app_colors.dart';
import 'package:jdolh_brands/core/constants/text_syles.dart';
import 'package:jdolh_brands/core/functions/find_checkincard_icon.dart';
import 'package:jdolh_brands/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_brands/view/widgets/common/custom_appbar.dart';

import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class SelectAddressScreen extends StatelessWidget {
  const SelectAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectAddressController());
    return Scaffold(
      appBar: customAppBar(title: 'تحديد الموقع'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToMyCurrentLocation();
        },
        backgroundColor: AppColors.secondaryColor,
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<SelectAddressController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    markers: controller.marker.toSet(),
                    onTap: (latLong) {
                      controller.setMarkAndSaveNewLatLong(latLong);
                    },
                    initialCameraPosition: controller.cameraPosition,
                    onMapCreated: (GoogleMapController mController) {
                      controller.mapController.complete(mController);
                    },
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 120.w,
                    left: 120.w,
                    child: GoHomeButton(
                      text: 'حفظ',
                      onTap: () {
                        controller.onTapSave();
                      },
                    )),
                buildFloatingSearchBar(context)
              ],
            )),
      ),
    );
  }
}

Widget buildFloatingSearchBar(BuildContext context) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  return GetBuilder<SelectAddressController>(
      builder: (controller) => FloatingSearchBar(
            hint: 'بحث...',
            controller: floatingSearchBarController,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 800),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            axisAlignment: isPortrait ? 0.0 : -1.0,
            openAxisAlignment: 0.0,
            width: isPortrait ? 600 : 500,
            debounceDelay: const Duration(milliseconds: 500),
            onQueryChanged: (query) {
              controller.getPlacesSuggestations(query);
            },
            progress: controller.searchStatusRequest == StatusRequest.loading
                ? true
                : false,
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(children: [
                  controller.suggestionPlaces.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.suggestionPlaces.length,
                          itemBuilder: (context, index) => PlacesListItem(
                            name: controller.extractTitle(index),
                            location: controller.removeTitle(index),
                            type: controller.suggestionPlaces[index].type!,
                            onTapCard: () {
                              //Get.back();
                              controller.getPlaceDetails(index);
                              floatingSearchBarController.close();
                              controller.suggestionPlaces.clear();
                            },
                          ),
                        )
                      : SizedBox()
                ]),
              );
            },
          ));
}

class PlacesListItem extends StatelessWidget {
  final String name;
  final String location;
  final String type;
  final void Function() onTapCard;

  const PlacesListItem({
    super.key,
    required this.name,
    required this.location,
    required this.type,
    required this.onTapCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            findSuitableIconForCard(type),
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(name,
                                    maxLines: 1,
                                    minFontSize: 11,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleSmall),
                                AutoSizeText(location,
                                    maxLines: 1,
                                    minFontSize: 11,
                                    overflow: TextOverflow.ellipsis,
                                    style: titleSmallGray)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
