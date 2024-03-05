import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class BchManagerData {
  Crud crud;
  BchManagerData(this.crud);

  addBchManager(
      {required String brandid,
      required String bchid,
      required String name}) async {
    var response = await crud.postData(ApiLinks.addBchManager,
        {"brandid": brandid, "bchid": bchid, "name": name});

    return response.fold((l) => l, (r) => r);
  }

  getBchManager({
    required String bchid,
  }) async {
    var response = await crud.postData(ApiLinks.getBchManager, {
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteBchManager(
      {required String bchid, required String bchManagerid}) async {
    var response = await crud.postData(ApiLinks.deleteBchManager,
        {"bchid": bchid, "bchManagerid": bchManagerid});

    return response.fold((l) => l, (r) => r);
  }

  switchEnableBchManager({
    required String bchManagerid,
  }) async {
    var response = await crud.postData(ApiLinks.switchEnableBchManager, {
      "bchManagerid": bchManagerid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
