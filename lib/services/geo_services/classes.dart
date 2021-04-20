import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

class PostalPlace extends Equatable {
  final double long;
  final double lat;
  final String name;
  final String? plz;

  PostalPlace(
      {required this.lat, required this.long, required this.name, this.plz});

  PostalPlace.empty() : this(lat: 0, long: 0, name: "DEBUG", plz: "00000");

  PostalPlace.outside() : this(lat: 0, long: 0, name: "Erde", plz: "00000");

  factory PostalPlace.fromMap(Map<String, dynamic> map) {
    return PostalPlace(
        lat: map['lat'], long: map['long'], name: map['name'], plz: map['plz']);
  }

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'long': long, 'name': name, 'plz': plz};
  }

  String toJsonString() {
    return jsonEncode(toMap());
  }

  factory PostalPlace.fromRawJson(String rawJson) {
    Map<String, dynamic> map = jsonDecode(rawJson);
    return PostalPlace.fromMap(map);
  }

  bool equalsLocationData(LocationData locationData) {
    return locationData.longitude == long && locationData.latitude == lat;
  }

  // Override to allow comparison between to instances. Two Places are equal if long and lat are equaL
  @override
  List<Object> get props => [long, lat];
}

class GeohashRange {
  String? upper;
  String? lower;

  GeohashRange({this.lower, this.upper});

  GeohashRange.empty() : this(lower: "0", upper: "0");
}
