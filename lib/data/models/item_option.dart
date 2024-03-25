import 'package:jdolh_brands/data/models/ioption_element.dart';

class ItemOption {
  int? id;
  int? itemsid;
  String? title;
  int? priceDep;
  int? isBasic;
  int? isMultiselect;

  ItemOption(
      {this.id,
      this.itemsid,
      this.title,
      this.priceDep,
      this.isBasic,
      this.isMultiselect});

  ItemOption.fromJson(Map<String, dynamic> json) {
    // List<IOptionElement> parsedElements = (json['elements'] as List)
    //     .map((element) => IOptionElement.fromJson(element))
    //     .toList();

    id = json['itemsoption_id'];
    itemsid = json['itemsoption_itemsid'];
    title = json['itemsoption_title'];
    priceDep = json['itemsoption_priceDep'];
    isBasic = json['itemsoption_isBasic'];
    isMultiselect = json['itemsoption_isMultiselect'];
    //elements = parsedElements;
  }
}
