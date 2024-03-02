import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class BrandData {
  Crud crud;
  BrandData(this.crud);

  createBrand(
      {required String managerId,
      required String storeName,
      required String type,
      required String subtype,
      required String isService,
      required String contactNumber,
      required String instagram,
      required String tiktok,
      required String snapchat,
      required String facebook,
      required String twitter,
      required File file}) async {
    var response = await crud.postDataWithFile(
        ApiLinks.createBrand,
        {
          "managerId": managerId,
          "storeName": storeName,
          "type": type,
          "subType": subtype,
          "isService": isService,
          "contractNumber": contactNumber,
          "instagram": instagram,
          "tiktok": tiktok,
          "snapchat": snapchat,
          "facebook": facebook,
          "twitter": twitter,
        },
        file,
        'file');

    return response.fold((l) => l, (r) => r);
  }
}
