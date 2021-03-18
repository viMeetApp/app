import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/widgets/home_feed/location_dialog/cubit/location_dialog_state.dart';

class LocationDialogCubit extends Cubit<LocationDialogState> {
  LocationDialogCubit({@required PostalPlace currentPlace})
      : super(LocationDialogState(currentPlace)) {
    _getPlaces();
  }

  void _getPlaces() {
    GeoService.getPostalPlaces()
        .then((value) => emit(state.copyWith(places: value)));
  }
}
