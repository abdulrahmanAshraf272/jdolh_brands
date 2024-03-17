class IOptionElement {
  int? id;
  int? itemsoptionid;
  String? name;
  int? price;

  IOptionElement({this.id, this.name, this.price, this.itemsoptionid});

  IOptionElement.fromJson(Map<String, dynamic> json) {
    id = json['ioptionelement_id'];
    itemsoptionid = json['ioptionelement_itemsoptionid'];
    name = json['ioptionelement_name'];
    price = json['ioptionelement_price'];
  }
}
