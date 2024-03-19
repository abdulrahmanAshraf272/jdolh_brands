import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_brands/data/models/item_option.dart';

class ValuesController {
  static LatLng? latLngSelected;

  LatLng? currentPosition;

  static List<ItemOption> addedItemOptions = [];
}
