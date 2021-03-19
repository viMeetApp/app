import 'package:signup_app/services/error_service.dart';
import 'package:signup_app/services/geo_service.dart';

class LocationWidgetState {
  List<PostalPlace> places;
  PostalPlace currentPlace;
  ViException exception;

  LocationWidgetState({this.currentPlace});

  /*LocationWidgetState copyWith(
      {PostalPlace currentPlace,
      List<PostalPlace> places,
      ViException exception}) {
    LocationWidgetState state = LocationWidgetState();
    state.currentPlace ?? this.currentPlace;
    state.places = places ?? this.places;
    state.exception = exception;
    return state;
  }*/
}
