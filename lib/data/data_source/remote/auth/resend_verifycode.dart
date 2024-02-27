import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class ResendVerifycodeData {
  Crud crud;
  ResendVerifycodeData(this.crud);

  postData(String usernameOrEmail) async {
    var response = await crud.postData(ApiLinks.resendVerifycode, {
      "usernameOrEmail": usernameOrEmail,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
