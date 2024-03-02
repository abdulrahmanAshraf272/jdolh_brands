import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class CategoriesData {
  Crud crud;
  CategoriesData(this.crud);

  addCategories({
    required String bchid,
    required String title,
  }) async {
    var response = await crud.postData(ApiLinks.addCategories, {
      "bchid": bchid,
      "title": title,
    });

    return response.fold((l) => l, (r) => r);
  }
}
