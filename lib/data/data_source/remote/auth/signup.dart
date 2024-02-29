import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);

  postData(String name, String username, String password, String email,
      String phone) async {
    var response = await crud.postData(ApiLinks.signUp, {
      "name": name,
      "username": username,
      "password": password,
      "email": email,
      "phone": phone,
    });

    return response.fold((leftValue) {
      return leftValue;
    }, (rightValue) {
      return rightValue;
    });
    //returnresponse.fold((l) => l, (r) => r);
  }
}
