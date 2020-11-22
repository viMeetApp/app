part of 'group_seetings_cubit.dart';

@immutable
abstract class GroupSettingsState {
  Group group;
}

class GroupSettingsUninitialized extends GroupSettingsState {}

class MemberSettings extends GroupSettingsState {}

class AdminSettings extends MemberSettings {
  AdminSettings();
  List<User> requestedToJoin = []; //List of all users who requested to Join
}
