class BchManager {
  int? bchmanagerId;
  int? bchmanagerBrandid;
  String? bchmanagerName;
  String? bchmanagerUsername;
  String? bchmanagerPassword;
  String? bchmanagerEmail;
  String? bchmanagerPhone;
  int? bchmanagerIsActive;

  BchManager(
      {this.bchmanagerId,
      this.bchmanagerBrandid,
      this.bchmanagerName,
      this.bchmanagerUsername,
      this.bchmanagerPassword,
      this.bchmanagerEmail,
      this.bchmanagerPhone,
      this.bchmanagerIsActive});

  BchManager.fromJson(Map<String, dynamic> json) {
    bchmanagerId = json['bchmanager_id'];
    bchmanagerBrandid = json['bchmanager_brandid'];
    bchmanagerName = json['bchmanager_name'];
    bchmanagerUsername = json['bchmanager_username'];
    bchmanagerPassword = json['bchmanager_password'];
    bchmanagerEmail = json['bchmanager_email'];
    bchmanagerPhone = json['bchmanager_phone'];
    bchmanagerIsActive = json['bchmanager_isActive'];
  }
}
