import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/widgets/home_feed/location_widget/cubit/location_widget_state.dart';

class LocationWidgetCubit extends Cubit<LocationWidgetState> {
  LocationWidgetCubit({PostalPlace currentPlace})
      : super(LocationWidgetState()) {
    if (currentPlace == null) {
      GeoService.getCurrentPlace().then((value) => setCurrentPlace(value));
    }
    _getPlaces();
  }

  void _getPlaces() {
    GeoService.getPostalPlaces().then((value) {
      state.places = value;
      refresh();
    });
  }

  void setCurrentPlace(PostalPlace place) {
    if (place != null) {
      GeoService.currentPlace = place;
      state.currentPlace = place;
      refresh();
    }
  }

  void refresh() {
    emit(state);
    print("updating");
  }
}
