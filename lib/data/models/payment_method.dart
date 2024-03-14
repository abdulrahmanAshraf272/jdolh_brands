class PaymentMethod {
  int? id;
  String? title;
  int? adminMoney;
  int? adminPercent;

  PaymentMethod({this.id, this.title, this.adminMoney, this.adminPercent});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['paymentmethod_id'];
    title = json['paymentmethod_title'];
    adminMoney = json['adminMoney'];
    adminPercent = json['adminPercent'];
  }
}
