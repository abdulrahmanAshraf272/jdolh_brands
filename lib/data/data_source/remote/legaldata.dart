import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class LegaldataData {
  Crud crud;
  LegaldataData(this.crud);

  createLegaldata(
      {required String brandid,
      required String crNumber,
      required String taxNumber,
      required List<File> files}) async {
    var response = await crud.postDataWithFiles(
        ApiLinks.createLegaldata,
        {
          "brandid": brandid,
          "CrNumber": crNumber,
          "taxNumber": taxNumber,
        },
        files,
        ['crPhoto', 'taxPhoto']);

    return response.fold((l) => l, (r) => r);
  }
}
