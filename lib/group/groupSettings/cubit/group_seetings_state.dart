part of 'group_seetings_cubit.dart';

@immutable
abstract class GroupSettingsState {
  Map<User, bool> usersAndState =
      new Map(); //Map of all users and if they are Admin
  Group group;
}

class GroupSettingsUninitialized extends GroupSettingsState {}

class MemberSettings extends GroupSettingsState {}

class AdminSettings extends MemberSettings {
  AdminSettings();
  List<User> requestedToJoin = []; //List of all users who requested to Join
}
