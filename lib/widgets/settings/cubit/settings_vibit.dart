import 'package:signup_app/repositories/settings_repository.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/vibit/vibit.dart';

class SettingsState extends ViState {
  // dependencies
  final SettingsRepository _repository;
  final AuthenticationService _authService;

  SettingsState(
      {SettingsRepository? settingsRepository,
      AuthenticationService? authenticationService})
      : _repository = settingsRepository ?? SettingsRepository(),
        _authService = authenticationService ?? AuthenticationService() {
    _authService.getCurrentUserStream().listen((user) {
      this.user = user;
      refresh();
    });
    _authService.updateAfterNewListenerSubscibed();
  }

  // values
  User? user;

  void setName(String newName) {
    //Check if MessageString is valid
    if (newName.length != 0) {
      _repository.setUserName(newName);
    }
  }
}
