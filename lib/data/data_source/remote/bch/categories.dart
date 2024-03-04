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

  getCategories({
    required String bchid,
  }) async {
    var response = await crud.postData(ApiLinks.getCategories, {
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteCategories({
    required String categoryid,
  }) async {
    var response = await crud.postData(ApiLinks.deleteCategories, {
      "categoryid": categoryid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
