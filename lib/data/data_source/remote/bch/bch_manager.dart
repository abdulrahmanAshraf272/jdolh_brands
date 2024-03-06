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
      required String name,
      required String username,
      required String password}) async {
    var response = await crud.postData(ApiLinks.addBchManager, {
      "brandid": brandid,
      "bchid": bchid,
      "name": name,
      "username": username,
      "password": password
    });

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

  changePassword(
      {required String bchManagerid, required String password}) async {
    var response = await crud.postData(ApiLinks.changePasswordBchManager,
        {"bchManagerid": bchManagerid, "password": password});

    return response.fold((l) => l, (r) => r);
  }
}
