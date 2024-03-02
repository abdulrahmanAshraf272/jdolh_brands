import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class BchData {
  Crud crud;
  BchData(this.crud);

  createBch(
      {required String brandid,
      required String branchName,
      required String city,
      required String location,
      required String lat,
      required String lng,
      required String locationLink,
      required String desc,
      required String contactNumber,
      required File file}) async {
    var response = await crud.postDataWithFile(
        ApiLinks.createBch,
        {
          "brandid": brandid,
          "branchName": branchName,
          "city": city,
          "location": location,
          "lat": lat,
          "lng": lng,
          "locationLink": locationLink,
          "desc": desc,
          "contactNumber": contactNumber,
        },
        file,
        'file');

    return response.fold((l) => l, (r) => r);
  }

  getBillResPolicies() async {
    var response = await crud.getData(ApiLinks.getBillResPolicy);

    return response.fold((l) => l, (r) => r);
  }

  getPaymentMethods() async {
    var response = await crud.getData(ApiLinks.getPaymentMethods);

    return response.fold((l) => l, (r) => r);
  }

  addWorktime(
      {required String bchid,
      required String satTime,
      required String sunTime,
      required String monTime,
      required String tuesTime,
      required String wedTime,
      required String thursTime,
      required String friTime}) async {
    var response = await crud.postData(ApiLinks.addWorktimeBch, {
      "bchid": bchid,
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

  addBchManager({
    required String brandid,
    required String bchid,
    required String name,
  }) async {
    var response = await crud.postData(ApiLinks.addBchManager, {
      "brandid": brandid,
      "bchid": bchid,
      "name": name,
    });

    return response.fold((l) => l, (r) => r);
  }

  addPaymentMethods({
    required String paymentMethodsid,
    required String bchid,
  }) async {
    var response = await crud.postData(ApiLinks.addPaymentMethods, {
      "paymentMethodsid": paymentMethodsid,
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }

  addResDetails({
    required String bchid,
    required String invitorMax,
    required String invitorMin,
    required String cost,
    required String suspensionTimeLimit,
    required String additionalInfo,
  }) async {
    var response = await crud.postData(ApiLinks.addResDetails, {
      "bchid": bchid,
      "invitorMax": invitorMax,
      "invitorMin": invitorMin,
      "cost": cost,
      "suspensionTimeLimit": suspensionTimeLimit,
      "additionalInfo": additionalInfo,
    });

    return response.fold((l) => l, (r) => r);
  }

  addEditPolicy({
    required String bchid,
    required String resPolicyid,
    required String billPolicyid,
  }) async {
    var response = await crud.postData(ApiLinks.addEditPolicy, {
      "bchid": bchid,
      "resPolicyid": resPolicyid,
      "billPolicyid": billPolicyid,
    });

    return response.fold((l) => l, (r) => r);
  }
}
