part of 'group_seetings_cubit.dart';

abstract class GroupSettingsState {}

class GroupMemberSettings extends GroupSettingsState {
  final Group group;
  GroupMemberSettings({@required this.group});
}

class AdminSettings extends GroupMemberSettings {
  AdminSettings({@required group}) : super(group: group);
}
