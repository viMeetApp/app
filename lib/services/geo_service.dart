import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:signup_app/services/helpers/proximity_hash.dart';
import 'package:signup_app/util/errors.dart';

class PostalPlace {
  double? long;
  double? lat;
  String? name;
  String? plz;

  PostalPlace({this.lat, this.long, this.name, this.plz});

  PostalPlace.empty() : this(lat: 0, long: 0, name: "DEBUG", plz: "00000");

  PostalPlace.outside() : this(lat: 0, long: 0, name: "Erde", plz: "00000");
}

class GeohashRange {
  String? upper;
  String? lower;

  GeohashRange({this.lower, this.upper});

  GeohashRange.empty() : this(lower: "0", upper: "0");
}

class GeoService with ChangeNotifier {
  // The radius within which posts are requested in meters
  static const double POST_RADIUS = 10000;
  static final _geo = Geoflutterfire();
  static PostalPlace? _currentPlace;
  static List<Function> _currentPlaceListeners = <Function>[];

  static PostalPlace? get currentPlace {
    return _currentPlace;
  }

  static set currentPlace(PostalPlace? place) {
    _currentPlace = place ?? null;
    _executeCurrentPlaceListeners();
  }

  static addCurrentPlaceListener(Function function) {
    _currentPlaceListeners.add(function);
  }

  static _executeCurrentPlaceListeners() {
    for (Function funct in _currentPlaceListeners) {
      funct(_currentPlace);
    }
  }

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

  static Future<PostalPlace> getCurrentPlace() async {
    try {
      LocationData location = await getDeviceLocation();
      List<PostalPlace> places = await getPostalPlaces();

      PostalPlace? result;
      double distance = double.infinity;
      for (PostalPlace place in places) {
        double dist = sqrt(pow(place.lat! - location.latitude!, 2) +
            pow(place.long! - location.longitude!, 2));
        if (dist < distance) {
          distance = dist;
          result = place;
        }
      }
      if (result == null || distance > 0.1) {
        return PostalPlace.outside();
      }
      return result;
    } catch (err) {
      return Future.error(err);
    }
  }

  static Future<String> getCurrentGeohash() async {
    try {
      LocationData position = await getDeviceLocation();
      String geohash = _geo
          .point(latitude: position.latitude!, longitude: position.longitude!)
          .hash;
      return geohash.substring(0, 5); // return a geohash with limited accuracy
    } catch (err) {
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
        return Future.error(ViServiceLocationException());
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error(ViPermissionLocationException());
      }
    }

    return await location.getLocation();
  }

  static GeohashRange getGeohashRange() {
    if (_currentPlace == null) {
      return GeohashRange.empty();
    }
    List<String> range = createGeohashes(
        _currentPlace?.lat ?? 0, _currentPlace?.long ?? 0, POST_RADIUS, 3);
    if (range.length < 2) {
      if (range.length == 1) {
        return GeohashRange(lower: range[0], upper: range[0]);
      }
      throw ViException("RangeError in GeoHashRange: " + range.toString());
    }
    print(range.toString());
    return GeohashRange(lower: range[1], upper: range[0]);
  }
}
