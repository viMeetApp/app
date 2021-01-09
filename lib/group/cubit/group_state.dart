part of 'group_cubit.dart';

abstract class GroupState {
  Group group;
  GroupState({@required this.group});
}

///State while Loading everything
class GroupUninitialized extends GroupState {
  GroupUninitialized() : super(group: null);
}

///When you are just a User No Rights to Change Group Delete, Admit Members etc.
class GroupMember extends GroupState {
  GroupMember({@required group}) : super(group: group);
}

///Not Part of Group one can only ask to join
class NotGroupMember extends GroupState {
  NotGroupMember({@required group}) : super(group: group) {
    requestedToJoin = this
        .group
        .requestedToJoin
        .contains(FirebaseAuth.instance.currentUser.uid);
  }
  bool requestedToJoin; //Whether one already requested to join the Group

}

class GroupAdmin extends GroupMember {
  GroupAdmin({@required group}) : super(group: group);
}
