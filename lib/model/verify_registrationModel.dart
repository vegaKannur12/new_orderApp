class VerifyRegistration {
  String? cid;
  String? fp;
  String? cD;
  String? error;
  String? sof;

  VerifyRegistration({this.cid, this.fp, this.cD, this.error, this.sof});

  VerifyRegistration.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    fp = json['fp'];
    cD = json['cD'];
    error = json['error'];
    sof = json['sof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['fp'] = this.fp;
    data['cD'] = this.cD;
    data['error'] = this.error;
    data['sof'] = this.sof;
    return data;
  }
}
