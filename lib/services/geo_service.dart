import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:signup_app/util/data_models.dart';

class PostalPlace {
  double long;
  double lat;
  String name;
  String plz;

  PostalPlace({this.lat, this.long, this.name, this.plz});
}

class GeoService {
  static final _geo = Geoflutterfire();

  static Future<List<PostalPlace>> getPostalPlaces() async {
    String jsonData =
        await rootBundle.loadString("assets/data/places_germany.json");
    List<dynamic> converted = json.decode(jsonData);

    List<PostalPlace> result = [];

    for (var place in converted) {
      result.add(PostalPlace(
          lat: place["lat"] + 0.0,
          long: place["long"] + 0.0,
          name: place["name"],
          plz: place["plz"]));
    }
    return result;
  }

  static Future<String> getCurrentGeohash() async {
    try {
      LocationData position = await getDeviceLocation();
      String geohash = _geo
          .point(latitude: position.latitude, longitude: position.longitude)
          .hash;
      return geohash.substring(0, 5); // return a geohash with limited accuracy
    } catch (err) {
      log("geohash: " + err.toString());
      return Future.error(err);
    }
  }

  static Future<LocationData> getDeviceLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error(PostError.LocationDisabled);
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return Future.error(PostError.LocationDenied);
      }
    }

    return await location.getLocation();
  }
}
