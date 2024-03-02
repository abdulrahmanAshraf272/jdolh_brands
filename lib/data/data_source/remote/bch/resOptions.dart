import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class ResOptionsData {
  Crud crud;
  ResOptionsData(this.crud);

  addResOptions({
    required String bchid,
    required String title,
    required String countLimit,
    required String duration,
    required String alwaysAvailable,
    required String satTime,
    required String sunTime,
    required String monTime,
    required String tuesTime,
    required String wedTime,
    required String thursTime,
    required String friTime,
  }) async {
    var response = await crud.postData(ApiLinks.addResOptions, {
      "bchid": bchid,
      "title": title,
      "countLimit": countLimit,
      "duration": duration,
      "alwaysAvailable": alwaysAvailable,
      "satTime": satTime,
      "sunTime": sunTime,
      "monTime": monTime,
      "tuesTime": tuesTime,
      "wedTime": wedTime,
      "thursTime": thursTime,
      "friTime": friTime,
    });

    return response.fold((l) => l, (r) => r);
  }
}