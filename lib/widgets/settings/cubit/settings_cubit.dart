import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/settings_repository.dart';
import 'package:signup_app/util/data_models.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository = SettingsRepository();

  SettingsCubit() : super(SettingsUninitialized()) {
    _repository.observeUser().listen((user) {
      if (user != null) {
        emit(SettingsState(user: user));
      }
    });
  }

  void setName(String newName) {
    //Check if MessageString is valid
    if (newName.length != 0 ?? newName != null) {
      _repository.setUserName(newName);
    }
  }
}
