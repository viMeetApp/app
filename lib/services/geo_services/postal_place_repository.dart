import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:signup_app/services/geo_services/classes.dart';

/// Repository to convert Location given by LocationData (e.g. long and lat) to Postal Place
class PostalPlaceRepository {
  /// Returns List of all Postal Places in Germany (at the Moment from local json data)
  Future<List<PostalPlace>>
      getAllPostalPlacesCurrentlyAvailabeInSystem() async {
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

  /// Retuns PostalPlace to given Location
  ///
  /// Compares Location to all locations specified in assets/data/places_germany.json returns nearest Location
  Future<PostalPlace> convertLocationToPostalPlace(
      LocationData location) async {
    if ((location.latitude == null) || location.longitude == null)
      throw Exception(
          'Provided Location did not have lattitude or longitude set');
    List<PostalPlace> places =
        await getAllPostalPlacesCurrentlyAvailabeInSystem();

    PostalPlace? result;
    double distance = double.infinity;
    for (PostalPlace place in places) {
      double dist = sqrt(pow(place.lat - location.latitude!, 2) +
          pow(place.long - location.longitude!, 2));
      if (dist < distance) {
        distance = dist;
        result = place;
      }
    }
    if (result == null || distance > 0.1) {
      return PostalPlace.outside();
    }
    return result;
  }
}
