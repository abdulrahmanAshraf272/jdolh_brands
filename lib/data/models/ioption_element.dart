class IOptionElement {
  int? id;
  String? name;
  int? price;

  IOptionElement({this.id, this.name, this.price});

  IOptionElement.fromJson(Map<String, dynamic> json) {
    id = json['ioptionelement_id'];
    name = json['ioptionelement_name'];
    price = json['ioptionelement_price'];
  }
}
