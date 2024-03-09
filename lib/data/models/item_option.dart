class ItemOption {
  int? id;
  String? title;
  int? priceDep;
  int? isBasic;
  String? elementIds;

  ItemOption(
      {this.id, this.title, this.priceDep, this.isBasic, this.elementIds});

  ItemOption.fromJson(Map<String, dynamic> json) {
    id = json['itemsoption_id'];
    title = json['itemsoption_title'];
    priceDep = json['itemsoption_priceDep'];
    isBasic = json['itemsoption_isBasic'];
    elementIds = json['itemsoption_elementids'];
  }
}
