import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class ResDetailsData {
  Crud crud;
  ResDetailsData(this.crud);

  addEditResDetails({
    required String elementId,
    required String bchid,
    required String cost,
    required String? invitorMax,
    required String invitorMin,
    required String suspensionTime,
    required String info,
  }) async {
    var response = await crud.postData(ApiLinks.addEditResDetails, {
      "elementId": elementId,
      "bchid": bchid,
      "cost": cost,
      "invitorMax": invitorMax,
      "invitorMin": invitorMin,
      "suspensionTime": suspensionTime,
      "info": info,
    });

    return response.fold((l) => l, (r) => r);
  }

  getResDetails({
    required String bchid,
  }) async {
    var response = await crud.postData(ApiLinks.getResDetails, {
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
