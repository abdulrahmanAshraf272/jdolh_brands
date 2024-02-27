import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class VerifycodeData {
  Crud crud;
  VerifycodeData(this.crud);

  postData(String usernameOrEmail, String verifycode) async {
    var response = await crud.postData(ApiLinks.verifycode, {
      "usernameOrEmail": usernameOrEmail,
      "verifycode": verifycode,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
