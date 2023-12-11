import 'package:geocoding/geocoding.dart';
import 'package:weatherapp/component/geolocation/geolocation.dart';

import '../appBar.dart';
import 'package:http/http.dart' as http;

class  Pos {
  final String name;
  final String locality;
  final String country;

  final String longitude;
  final String latitude;

  Pos({required this.name, required this.country, required this.locality, required this.longitude, required this.latitude});
  Pos.empty() : name="", country="", locality="", longitude="", latitude="";
  Pos.fromJson(Map<String, dynamic> json) : name=json['name'], country=json['country'], locality=json['admin1']??json['admin2']??json['admin3']??json['admin4']??"", longitude=json["longitude"].toString(), latitude=json["latitude"].toString();
}
