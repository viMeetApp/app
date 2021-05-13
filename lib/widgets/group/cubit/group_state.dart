part of 'group_cubit.dart';

abstract class GroupState {
  final Group group;
  GroupState({required this.group});
}

///State while Loading everything
///When you are just a User No Rights to Change Group Delete, Admit Members etc.
class GroupMember extends GroupState {
  GroupMember({required group}) : super(group: group);
}

///Not Part of Group one can only ask to join
class NotGroupMember extends GroupState {
  late final bool
      requestedToJoin; //Whether one already requested to join the Group

  NotGroupMember({required group}) : super(group: group) {
    print(AuthenticationService().getCurrentUserReference().id);
    requestedToJoin = this
            .group
            .requestedToJoin
            ?.contains(AuthenticationService().getCurrentUserReference()) ??
        false;
  }

  NotGroupMember copyWith({bool? requesting}) {
    return NotGroupMember(
      group: group,
    );
  }
}

class GroupAdmin extends GroupMember {
  GroupAdmin({required group}) : super(group: group);
}
