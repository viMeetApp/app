import 'package:signup_app/util/errors.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/vibit/vibit.dart';

class LocationWidgetState extends ViState {
  List<PostalPlace>? places;
  PostalPlace? currentPlace;
  ViException? exception;

  LocationWidgetState({this.currentPlace}) {
    if (currentPlace == null) {
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
