import 'package:signup_app/services/geo_service.dart';

class LocationDialogState {
  List<PostalPlace> places;
  PostalPlace currentPlace;

  LocationDialogState(this.currentPlace);

  LocationDialogState copyWith(
      {PostalPlace currentPlace, List<PostalPlace> places}) {
    LocationDialogState state =
        LocationDialogState(currentPlace ?? this.currentPlace);
    state.places = places ?? this.places;
    return state;
  }
}
