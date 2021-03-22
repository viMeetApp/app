import 'package:signup_app/repositories/settings_repository.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/vibit/vibit.dart';

class SettingsState extends ViState {
  // dependencies
  final SettingsRepository _repository = SettingsRepository();

  // values
  User? user;

  SettingsState() {
    _repository.observeUser().listen((user) {
      if (user != null) {
        print("SETTING REFRESH:" + user.toMap().toString());
        this.user = user;
        refresh();
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
