import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/repositories/group_interactions.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/common.dart';
import 'package:collection/collection.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GroupRepository _groupRepository = GroupRepository();
  final AuthenticationService _authenticationService = AuthenticationService();
  final GroupInteractions _groupInteractions;

  GroupCubit({required Group group})
      : this._groupInteractions = GroupInteractions(group: group),
        super(_getCurrentGroupState(
            group, FirebaseAuth.instance.currentUser!.uid)) {
    //Subscribe to Group to keep information up to date
    _groupRepository.getGroupStreamById(group.id).listen((group) {
      emit(_getCurrentGroupState(
          group, _authenticationService.getCurrentUserUid()));
    });
  }

  Future<void> requestToJoinGroup() {
    return _groupInteractions.joinGroup();
  }

  Future<void> leaveGroup() {
    return _groupInteractions.leaveGroup();
  }

  static GroupState _getCurrentGroupState(Group group, String userId) {
    final GroupUserReference? ownRef =
        group.members.firstWhereOrNull((member) => member.id == userId);
    if (ownRef != null) {
      return (ownRef.isAdmin
          ? GroupAdmin(group: group)
          : GroupMember(group: group));
    }
    return (NotGroupMember(group: group));
  }
}
