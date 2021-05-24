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

  ///Returns geohash for current point
  ///
  ///Heavily influenced by GeoFlutter fire
  String geoHash() {
    const BASE32_CODES = '0123456789bcdefghjkmnpqrstuvwxyz';
    const int numberOfChars = 9;

    var chars = [], bits = 0, bitsTotal = 0, hashValue = 0;
    double maxLat = 90, minLat = -90, maxLon = 180, minLon = -180, mid;

    while (chars.length < numberOfChars) {
      if (bitsTotal % 2 == 0) {
        mid = (maxLon + minLon) / 2;
        if (this.long > mid) {
          hashValue = (hashValue << 1) + 1;
          minLon = mid;
        } else {
          hashValue = (hashValue << 1) + 0;
          maxLon = mid;
        }
      } else {
        mid = (maxLat + minLat) / 2;
        if (this.lat > mid) {
          hashValue = (hashValue << 1) + 1;
          minLat = mid;
        } else {
          hashValue = (hashValue << 1) + 0;
          maxLat = mid;
        }
      }

      bits++;
      bitsTotal++;
      if (bits == 5) {
        var code = BASE32_CODES[hashValue];
        chars.add(code);
        bits = 0;
        hashValue = 0;
      }
    }

    return chars.join('');
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
