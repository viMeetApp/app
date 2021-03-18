import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/widgets/home_feed/location_widget/cubit/location_widget_state.dart';

class LocationWidgetCubit extends Cubit<LocationWidgetState> {
  LocationWidgetCubit({@required PostalPlace currentPlace})
      : super(LocationWidgetState(currentPlace)) {
    _getPlaces();
  }

  void _getPlaces() {
    GeoService.getPostalPlaces()
        .then((value) => emit(state.copyWith(places: value)));
  }

  void setCurrentPlace(PostalPlace place) {
    print("setting: " + place.name);
    emit(state.copyWith(currentPlace: place));
  }
}
