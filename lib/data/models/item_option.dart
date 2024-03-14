import 'package:jdolh_brands/data/models/ioption_element.dart';

class ItemOption {
  int? id;
  String? title;
  int? priceDep;
  int? isBasic;
  String? elementIds;
  List<IOptionElement>? elements;

  ItemOption(
      {this.id,
      this.title,
      this.priceDep,
      this.isBasic,
      this.elementIds,
      this.elements});

  ItemOption.fromJson(Map<String, dynamic> json) {
    List<IOptionElement> parsedElements = (json['elements'] as List)
        .map((element) => IOptionElement.fromJson(element))
        .toList();

    id = json['itemsoption_id'];
    title = json['itemsoption_title'];
    priceDep = json['itemsoption_priceDep'];
    isBasic = json['itemsoption_isBasic'];
    elementIds = json['itemsoption_elementids'];
    elements = parsedElements;
  }
}
