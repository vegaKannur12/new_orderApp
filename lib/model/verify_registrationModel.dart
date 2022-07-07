class VerifyRegistration {
  String? cid;
  String? fp;
  String? cD;
  String? msg;
  String? sof;

  VerifyRegistration({this.cid, this.fp, this.cD, this.msg, this.sof});

  VerifyRegistration.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    fp = json['fp'];
    cD = json['cD'];
    msg = json['msg'];
    sof = json['sof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['fp'] = this.fp;
    data['cD'] = this.cD;
    data['msg'] = this.msg;
    data['sof'] = this.sof;
    return data;
  }
}
