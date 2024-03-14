class ResDetails {
  int? id;
  int? bchid;
  int? cost;
  int? invitorMax;
  int? invitorMin;
  int? suspensionTimeLimit;
  String? additionalInfo;

  ResDetails(
      {this.id,
      this.bchid,
      this.cost,
      this.invitorMax,
      this.invitorMin,
      this.suspensionTimeLimit,
      this.additionalInfo});

  ResDetails.fromJson(Map<String, dynamic> json) {
    id = json['resdetails_id'];
    bchid = json['resdetails_bchid'];
    cost = json['resdetails_cost'];
    invitorMax = json['resdetails_invitorMax'];
    invitorMin = json['resdetails_invitorMin'];
    suspensionTimeLimit = json['resdetails_suspensionTimeLimit'];
    additionalInfo = json['resdetails_additionalInfo'];
  }
}
