part of 'settings_cubit.dart';

@immutable
class SettingsState {
  User user;

  SettingsState({@required this.user});
}

///State while Loading everything
class SettingsUninitialized extends SettingsState {
  SettingsUninitialized() : super(user: null);
}
