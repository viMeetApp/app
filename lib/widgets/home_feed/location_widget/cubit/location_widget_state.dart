import 'package:signup_app/util/errors.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/vibit/vibit.dart';

class LocationWidgetState extends ViState {
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
