import 'dart:ffi';

import 'package:http/http.dart' as http;

const loginUrl = 'https://shrouded-fjord-74940.herokuapp.com/api/login';
const getNearUrl = 'https://shrouded-fjord-74940.herokuapp.com/api/nearMe';
const absenUrl = "https://shrouded-fjord-74940.herokuapp.com/api/absenPegawai";

class Client {
  static LoginUser(String email,String password) async {
    var client = await http.post(loginUrl,body: {
      'email' : email,
      'password': password
    });
    return client.body;
  }

  static GetNearestCabang(double latitude,double longitude) async{
    var client = await http.post(getNearUrl,body: {
      'latitude' : latitude.toString(),
      'longitude' : longitude.toString()
    });
    print(client.body);
    return client.body;
  }

  static AbsenPegawai (int userId,int lokasiId) async {
    var client = await http.post(absenUrl,body: {
      'userId':userId.toString() ,
      'idTempat': lokasiId.toString()
    });
    return client.body;
  }
}