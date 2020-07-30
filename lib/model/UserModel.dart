class UserModel{
  int id;
  String email;
  String password;
  String name;
  String nidn;
  String alamat;
  String status;
  String createdAt;
  String updatedAt;
  UserModel(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.nidn,
      this.alamat,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    nidn = json['nidn'];
    alamat = json['alamat'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['nidn'] = this.nidn;
    data['alamat'] = this.alamat;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
