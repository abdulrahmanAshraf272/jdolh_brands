import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);

  postData(String usernameOrEmail, String newPassword) async {
    var response = await crud.postData(ApiLinks.resetPassword, {
      "usernameOrEmail": usernameOrEmail,
      "newPassword": newPassword,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
