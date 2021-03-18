import 'package:signup_app/services/geo_service.dart';

class LocationWidgetState {
  List<PostalPlace> places;
  PostalPlace currentPlace;

  LocationWidgetState(this.currentPlace);

  LocationWidgetState copyWith(
      {PostalPlace currentPlace, List<PostalPlace> places}) {
    LocationWidgetState state =
        LocationWidgetState(currentPlace ?? this.currentPlace);
    state.places = places ?? this.places;
    return state;
  }
}
