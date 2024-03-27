class Legaldata {
  int? legaldataId;
  int? legaldataBrandid;
  int? legaldataCrNumber;
  String? legaldataCrPhoto;
  int? legaldataTaxNumber;
  String? legaldataTaxPhoto;

  Legaldata(
      {this.legaldataId,
      this.legaldataBrandid,
      this.legaldataCrNumber,
      this.legaldataCrPhoto,
      this.legaldataTaxNumber,
      this.legaldataTaxPhoto});

  Legaldata.fromJson(Map<String, dynamic> json) {
    legaldataId = json['legaldata_id'];
    legaldataBrandid = json['legaldata_brandid'];
    legaldataCrNumber = json['legaldata_CrNumber'];
    legaldataCrPhoto = json['legaldata_CrPhoto'];
    legaldataTaxNumber = json['legaldata_taxNumber'];
    legaldataTaxPhoto = json['legaldata_taxPhoto'];
  }
}
