import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';
import 'package:jdolh_brands/core/constants/strings.dart';

class ViewBrandTypesAndSubtypesData {
  Crud crud;
  ViewBrandTypesAndSubtypesData(this.crud);

  getData() async {
    var response = await crud.getData(ApiLinks.brandTypesAndsubtypes);

    return response.fold((l) => l, (r) => r);
  }
}
