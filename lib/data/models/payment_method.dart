class PaymentMethod {
  int? id;
  String? title;

  PaymentMethod({
    this.id,
    this.title,
  });

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['paymentmethod_id'];
    title = json['paymentmethod_title'];
  }
}
