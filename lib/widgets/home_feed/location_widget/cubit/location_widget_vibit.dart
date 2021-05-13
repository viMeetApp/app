import 'package:signup_app/services/geo_services/classes.dart';
import 'package:signup_app/services/geo_services/geo_locator.dart';
import 'package:signup_app/services/geo_services/postal_place_repository.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/vibit/vibit.dart';

class LocationWidgetState extends ViState {
  final GeoLocator _geoLocator;

  List<PostalPlace>? places;
  static PostalPlace? currentPlace;
  ViException? exception;

  LocationWidgetState({PostalPlace? currentPlace, GeoLocator? geoLocator})
      : _geoLocator = geoLocator ?? GeoLocator() {
    if (currentPlace != null) {
      LocationWidgetState.currentPlace = currentPlace;
    }

    if (LocationWidgetState.currentPlace == null) {
      _geoLocator.getCurrentLocation().then((place) => _setCurrentPlace(place));
    }

    // load the list of postal places
    PostalPlaceRepository()
        .getAllPostalPlacesCurrentlyAvailabeInSystem()
        .then((value) {
      places = value;
      refresh();
    });
  }

  Future<PostalPlace> getDeviceLocation() async {
    PostalPlace currentPlace =
        await _geoLocator.changeToDeviceLocationAndGetLocation();
    _setCurrentPlace(currentPlace);
    return currentPlace;
  }

  void manuallySetCurrentPlace(PostalPlace place) {
    _geoLocator.manuallySetLocation(place);
    _setCurrentPlace(place);
  }

  void _setCurrentPlace(PostalPlace place) {
    currentPlace = place;
    refresh();
  }
}
