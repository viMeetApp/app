part of 'group_settings_cubit.dart';

abstract class GroupSettingsState {
  final Group group;
  GroupSettingsState({required this.group});
}

class GroupMemberSettings extends GroupSettingsState {
  GroupMemberSettings({required group}) : super(group: group);
}

class AdminSettings extends GroupMemberSettings {
  AdminSettings({required group}) : super(group: group);
}
