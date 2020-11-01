part of 'group_cubit.dart';

class GroupState {
  final bool isSubscribed;
  final bool isAdmin;
  final Group group;

  GroupState({@required this.group})
      : isAdmin = false,
        isSubscribed = true;
}
