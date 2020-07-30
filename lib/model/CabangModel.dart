class CabangModel {
  int id;
  String name;
  String addres;
  double latitude;
  double longitude;
  int radius;
  String createdAt;
  String updatedAt;

  CabangModel(
      {this.id,
        this.name,
        this.addres,
        this.latitude,
        this.longitude,
        this.radius,
        this.createdAt,
        this.updatedAt});

  CabangModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addres = json['addres'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    radius = json['radius'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['addres'] = this.addres;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['radius'] = this.radius;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}