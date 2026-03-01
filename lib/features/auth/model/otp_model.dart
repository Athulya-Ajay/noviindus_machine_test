class OtpVerifyModel {
  bool? status;
  bool? privilage;
  Token? token;
  String? phone;

  OtpVerifyModel({this.status, this.privilage, this.token, this.phone});

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    privilage = json['privilage'];
    token = json['token'] != null ?  Token.fromJson(json['token']) : null;
    phone = json['phone'];
  }

  
}

class Token {
  String? refresh;
  String? access;

  Token({this.refresh, this.access});

  Token.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

}