import 'package:signup_app/util/presets/errors.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/vibit/vibit.dart';

class LocationWidgetState extends ViState {
  List<PostalPlace>? places;
  static PostalPlace? currentPlace;
  ViException? exception;

  LocationWidgetState({PostalPlace? currentPlace}) {
    if (currentPlace != null) {
      LocationWidgetState.currentPlace = currentPlace;
    }

    if (LocationWidgetState.currentPlace == null) {
      GeoService.getCurrentPlace().then((value) => setCurrentPlace(value));
    }

    // load the list of postal places
    GeoService.getPostalPlaces().then((value) {
      places = value;
      refresh();
    });
  }

  void setCurrentPlace(PostalPlace? place) {
    if (place != null) {
      GeoService.currentPlace = place;
      currentPlace = place;
      refresh();
    }
  }
}
