import 'package:jdolh_brands/data/models/ioption_element.dart';

class ItemOption {
  int? id;
  int? itemsid;
  String? title;
  int? priceDep;
  int? isBasic;

  ItemOption({
    this.id,
    this.itemsid,
    this.title,
    this.priceDep,
    this.isBasic,
  });

  ItemOption.fromJson(Map<String, dynamic> json) {
    // List<IOptionElement> parsedElements = (json['elements'] as List)
    //     .map((element) => IOptionElement.fromJson(element))
    //     .toList();

    id = json['itemsoption_id'];
    itemsid = json['itemsoption_itemsid'];
    title = json['itemsoption_title'];
    priceDep = json['itemsoption_priceDep'];
    isBasic = json['itemsoption_isBasic'];
    //elements = parsedElements;
  }
}
