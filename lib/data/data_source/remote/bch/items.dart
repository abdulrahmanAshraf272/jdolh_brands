import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud);

  addItems({
    required String categoriesid,
    required String resoptionsid,
    required String title,
    required String price,
    required String dicount,
    required String discountPercentage,
    required String desc,
    required String withOptions,
    required String duration,
    required String alwaysAvailable,
    required String satTime,
    required String sunTime,
    required String monTime,
    required String tuesTime,
    required String wedTime,
    required String thursTime,
    required String friTime,
    required File file,
  }) async {
    var response = await crud.postDataWithFile(
        ApiLinks.addItems,
        {
          "categoriesid": categoriesid,
          "resoptionsid": resoptionsid,
          "title": title,
          "price": price,
          "dicount": dicount,
          "discountPercentage": discountPercentage,
          "desc": desc,
          "withOptions": withOptions,
          "duration": duration,
          "alwaysAvailable": alwaysAvailable,
          "satTime": satTime,
          "sunTime": sunTime,
          "monTime": monTime,
          "tuesTime": tuesTime,
          "wedTime": wedTime,
          "thursTime": thursTime,
          "friTime": friTime,
        },
        file,
        'file');

    return response.fold((l) => l, (r) => r);
  }
}
