part of 'group_cubit.dart';

abstract class GroupState {
  final Group group;
  final bool isUpdating;
  GroupState({required this.group, bool? isUpdating})
      : this.isUpdating = isUpdating ?? false;

  GroupState setIsUpdating(bool isUpdating);
}

///State while Loading everything
///When you are just a User No Rights to Change Group Delete, Admit Members etc.
class GroupMember extends GroupState {
  GroupMember({required group, bool? isUpdating})
      : super(group: group, isUpdating: isUpdating);

  GroupMember setIsUpdating(bool isUpdating) {
    return GroupMember(group: this.group, isUpdating: isUpdating);
  }
}

///Not Part of Group one can only ask to join
class NotGroupMember extends GroupState {
  late final bool
      requestedToJoin; //Whether one already requested to join the Group

  NotGroupMember({required Group group, bool? isUpdating})
      : super(group: group, isUpdating: isUpdating) {
    requestedToJoin = this
            .group
            .requestedToJoin
            ?.contains(AuthenticationService().getCurrentUserReference()) ??
        false;
  }
  NotGroupMember setIsUpdating(bool isUpdating) {
    return NotGroupMember(group: this.group, isUpdating: isUpdating);
  }
}

class GroupAdmin extends GroupMember {
  GroupAdmin({required group, bool? isUpdating})
      : super(group: group, isUpdating: isUpdating);

  GroupAdmin setIsUpdating(bool isUpdating) {
    return GroupAdmin(group: this.group, isUpdating: isUpdating);
  }
}
