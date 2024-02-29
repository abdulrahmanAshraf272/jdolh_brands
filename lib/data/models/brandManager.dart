class BrandManager {
  int? brandManagerId;
  String? brandManagerName;
  String? brandManagerUsername;
  String? brandManagerEmail;
  String? brandManagerPhone;
  int? brandManagerApprove;

  BrandManager(
      {this.brandManagerId,
      this.brandManagerName,
      this.brandManagerUsername,
      this.brandManagerEmail,
      this.brandManagerPhone,
      this.brandManagerApprove});

  BrandManager.fromJson(Map<String, dynamic> json) {
    brandManagerId = json['brandmanager_id'];
    brandManagerName = json['brandmanager_name'];
    brandManagerUsername = json['brandmanager_username'];
    brandManagerEmail = json['brandmanager_email'];
    brandManagerPhone = json['brandmanager_phone'];
    brandManagerApprove = json['brandmanager_approve'];
  }
}
