import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';
import 'package:jdolh_brands/core/constants/strings.dart';

class ViewBrandTypesData {
  Crud crud;
  ViewBrandTypesData(this.crud);

  getData() async {
    var response = await crud.getData(ApiLinks.brandTypes);

    return response.fold((l) => l, (r) => r);
  }
}
