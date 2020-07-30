import 'package:mobile_absensi/model/UserModel.dart';

class LoginResponseModel {
  String status;
  UserModel data;
  String token;

  LoginResponseModel({this.status, this.data, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }else{
      data['data']=null;
    }
    data['token'] = this.token;
    return data;
  }
}